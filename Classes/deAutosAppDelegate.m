//
//  deAutosAppDelegate.m
//  deAutos
//
//  Created by Moises Swiczar on 10/1/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "deAutosAppDelegate.h"
#import "deAutosViewController.h"
#import "UChache.h"
#import "NDBSearch.h"

#define SQLDATABASENAME @"deautos3.sql"

@implementation deAutosAppDelegate

@synthesize window;
@synthesize  acontrollersearch;
@synthesize is_ipod;
@synthesize is_simulator;
@synthesize internetConnectionStatus;

@synthesize dMarca;
@synthesize dModelo;
@synthesize dProvincia;
@synthesize dLocalidad;
@synthesize dCombustible;
@synthesize is_nuevo;
@synthesize database;


@synthesize desdeano;
@synthesize hastaano;


- (void)updateStatus
{
	self.internetConnectionStatus	= [[Reachability sharedReachability] internetConnectionStatus];
}

- (void)reachabilityChanged:(NSNotification *)note
{
    [self updateStatus];
}



-(void)createEditableCopyOfDatabaseIfNeeded 
{
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:SQLDATABASENAME];
	success = [fileManager fileExistsAtPath:writableDBPath];
	if (success) 
	{
		firsttimeExecution=NO;
		return;
	}
	firsttimeExecution=YES;
	// The writable database does not exist, so copy the default to the appropriate location.
	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:SQLDATABASENAME];
	success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
	if (!success) 
	{
		NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}

- (void)initializeDatabase
{
	// The database is stored in the application bundle. 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:SQLDATABASENAME];
	// Open the database. The database was prepared outside the application.
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
	} 
	else 
	{
		// Even though the open failed, call close to properly clean up resources.
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
		// Additional error handling, as appropriate...
	}
}

-(void)startdatabase
{
	[self createEditableCopyOfDatabaseIfNeeded];
	[self initializeDatabase];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	
	
	[self startdatabase];
	
	
	
											
											// Override point for customization after app launch    
											deAutosViewController *viewController =[ [deAutosViewController alloc] initWithNibName:@"deAutosViewController" bundle:nil];
											navcon = [[UINavigationController alloc] initWithRootViewController:viewController];
											navcon.navigationBarHidden=YES;
											navcon.navigationBar.tintColor = [UIColor blackColor];
											[viewController release];
											
											
	is_ipod =[[[UIDevice currentDevice]model]isEqualToString:@"iPod touch"];
	is_simulator = [[[UIDevice currentDevice]model]isEqualToString:@"iPhone Simulator"];
	
	[[Reachability sharedReachability] setHostName: @"www.apple.com"];
	[[Reachability sharedReachability] setNetworkStatusNotificationsEnabled:YES];
	[self updateStatus];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:@"kNetworkReachabilityChangedNotification" object:nil];
	
	backAlert2 = [[UIAlertView alloc]initWithTitle:@"Deautos.com" message:@"No es posible conectarse a internet.\nFavor de reintentar nuevamente luego." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	/*
    [[GANTracker sharedTracker] startTrackerWithAccountID:TRAKERGOOGLE
										   dispatchPeriod:kGANDispatchPeriodSec
												 delegate:nil];


	NSError *error;
	if (![[GANTracker sharedTracker] trackEvent:@"my_category"
										 action:@"my_action"
										  label:@"my_label"
										  value:-1
									  withError:&error]) 
	{
		// Handle error here
		NSLog(@"Error");
	}
	 */
	[self trackpage:@"/InicioAplicacion"];
    [window addSubview:navcon.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [navcon release];
    [window release];
    [super dealloc];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
//	[[GANTracker sharedTracker] stopTracker];
	[UChache saveImages];
	[NDBSearch finalizeStatements];
	sqlite3_close(database);

}

-(void) shownotreacheable
{
	[backAlert2 show];
	
}

/*

if (![[GANTracker sharedTracker] trackEvent:@"my_category"
									 action:@"my_action"
									  label:@"my_label"
									  value:-1
								  withError:&error]) {
	// Handle error here
}
*/



-(void) trackpage:(NSString*) thestr
{
	/*
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:thestr
										 withError:&error]) {
		// Handle error here
		NSLog(@"Error");
	
	
	}
	 */
}




@end

//
//  deAutosAppDelegate.h
//  deAutos
//
//  Created by Moises Swiczar on 10/1/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "/usr/include/sqlite3.h"

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "GANTracker.h"

#define TRAKERGOOGLE @"UA-1254112-16"

static const NSInteger kGANDispatchPeriodSec = 10;


@interface deAutosAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController * navcon;
	id acontrollersearch;
	NetworkStatus internetConnectionStatus;
	BOOL is_simulator;
	BOOL is_ipod;
	UIAlertView * backAlert2;
	sqlite3 *database;

	NSMutableDictionary *dMarca;
	NSMutableDictionary *dModelo;
	NSMutableDictionary *dProvincia;
	NSMutableDictionary *dLocalidad;
	NSMutableDictionary *dCombustible;
	BOOL is_nuevo;
	BOOL firsttimeExecution;
	NSString *desdeano;
	NSString *hastaano;
	
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic,assign) 	id acontrollersearch;
@property (nonatomic) BOOL is_ipod;
@property (nonatomic) BOOL is_nuevo;

@property (nonatomic,copy) NSMutableDictionary *dMarca;
@property (nonatomic,copy) NSMutableDictionary *dModelo;
@property (nonatomic,copy) NSMutableDictionary *dProvincia;
@property (nonatomic,copy) NSMutableDictionary *dLocalidad;
@property (nonatomic,copy) NSMutableDictionary *dCombustible;

@property (nonatomic,copy) NSString *desdeano;
@property (nonatomic,copy) NSString *hastaano;


@property (nonatomic)sqlite3 *database ;

@property NetworkStatus internetConnectionStatus;
@property    BOOL is_simulator;

-(void) updateStatus;
-(void) shownotreacheable;


-(void) trackpage:(NSString*) thestr;

@end


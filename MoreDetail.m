//
//  MoreDetail.m
//  deAutos
//
//  Created by Moises Swiczar on 11/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MoreDetail.h"
#import "WSCall.h"
#import "deAutosAppDelegate.h"

@implementation MoreDetail
@synthesize theaviso;


-(void) clikoninfobar:(id)aobj
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)workOnBackground:(BOOL)background
{
	self.view.userInteractionEnabled = !background;
	if (background)
	{
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		[backAlert show];
		[progressInd startAnimating];
		
	}
	else
	{
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		[progressInd stopAnimating];
		[backAlert dismissWithClickedButtonIndex:0 animated:YES];
	}
}

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		thearray =[[NSMutableArray  alloc] init];
		progressInd = [[UIActivityIndicatorView alloc] init];
		progressInd.hidesWhenStopped = YES;
		progressInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
		[progressInd sizeToFit];
		progressInd.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
										UIViewAutoresizingFlexibleRightMargin |
										UIViewAutoresizingFlexibleTopMargin |
										UIViewAutoresizingFlexibleBottomMargin);
		
		backAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"", @"")
											   message:NSLocalizedString(@"Cargando datos...\nPor favor aguarde.", @"") //@SK
											  delegate:nil 
									 cancelButtonTitle:nil
									 otherButtonTitles:nil];
		//backAlert.transform = CGAffineTransformTranslate( backAlert.transform, 0.0, -110.0 );//@SK
		progressInd.center = CGPointMake(backAlert.frame.size.width / 2.0, -5.0);
		[backAlert addSubview:progressInd];
		self.title = @"Deautos.com";
		thebanner1 = [[NBanner alloc]init];

    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate trackpage:@"/detalleEquipamiento"];
}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn addTarget:self action:@selector(clikoninfobar:) forControlEvents:UIControlEventTouchUpInside];
	btn.frame = CGRectMake(0, 0, 50, 20);
	[btn setImage:[UIImage imageNamed:@"Back Inactivo.png"] forState:UIControlStateNormal];
	UIBarButtonItem * theinfobutton = [[UIBarButtonItem alloc] initWithCustomView:btn];
	self.navigationItem.hidesBackButton=YES;
	
	self.navigationItem.leftBarButtonItem = theinfobutton;
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
	
	if(theweb!=nil)
	{
		[theweb release];
		theweb=nil;

	}
	
	
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	if(theweb!=nil)
	{
		[theweb release];
		theweb=nil;
	}

	if(thearray!=nil)
	{
		[thearray removeAllObjects];
		[thearray release];
		thearray=nil;

	}
		
	if(progressInd!=nil)
	{
		[progressInd release];
		progressInd=nil;

	}
	
	if(backAlert!=nil)
	{
		[backAlert release];
		backAlert=nil;
	}


    [super dealloc];
	
}

-(IBAction) clickBanner:(id)aob
{
	if(theweb==nil)
	{
		theweb = [[SimpleWebView alloc] initWithNibName:@"SimpleWebView" bundle:nil];
	}
	theweb.string_web =thebanner1.UrlClick;
	[self.navigationController pushViewController:theweb animated:YES];
	[theweb go];
	
}

-(void) fillthetext
{
	NSUInteger total= [thearray count];
	NSMutableDictionary* thedict;
	NSUInteger i;
	thespecs.text =@"";
	for (i=0;i<total ; i++)
	{
		thedict =[thearray objectAtIndex:i];
		thespecs.text =[NSString stringWithFormat:@"%@\n%@",thespecs.text,[thedict objectForKey:@"clsTblDic_nombre"]];
	}
}


-(void) loaddata:(id)aobj
{
	
	
	
	
	NSString * idAviso;
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[appDelegate updateStatus];
	if (appDelegate.internetConnectionStatus==NotReachable)
	{
		[self fillthetext];
		[self workOnBackground:NO];
		[appDelegate  shownotreacheable];
		
		return;
	}
	
	
	[WSCall getBannerforPosicion:2 is_nuevo:appDelegate.is_nuevo thebanner:thebanner1];
	
	
	NSURL *url = [NSURL URLWithString:thebanner1.UrlImage];
	imageBanner.image = [[UIImage imageWithData: [NSData dataWithContentsOfURL:url]] retain];
	
	if(appDelegate.is_nuevo)
	{
		idAviso = [theaviso objectForKey:@"clsAviso0km_id"];
	}
	else
	{
		idAviso =  [theaviso objectForKey:@"clsAvisoUsado_id"];
	}
	[thearray removeAllObjects];
	[WSCall getDetailAuto:thearray theaviso:idAviso nuevos:appDelegate.is_nuevo];
	[self fillthetext];
	[self workOnBackground:NO];
}

-(void) show
{
	thespecs.text =@"";
	[self workOnBackground:YES];
	atimergetdata = [NSTimer scheduledTimerWithTimeInterval:	0.1		// seconds
													 target:		self
												   selector:	@selector (loaddata:)
												   userInfo:	self		// makes the currently-active audio queue (record or playback) available to the updateBargraph method
													repeats:	NO];
	
}





@end

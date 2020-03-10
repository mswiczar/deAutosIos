//
//  MensajeEnviado.m
//  deAutos
//
//  Created by Moises Swiczar on 11/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MensajeEnviado.h"
#import "deAutosAppDelegate.h"
#import "WSCall.h"


@implementation MensajeEnviado

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		theweb=nil;
		self.title =@"Deautos.com";
		thebanner1 = [[NBanner alloc]init];

		
    }
    return self;
}
-(void) clikoninfobar:(id)aobj
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate trackpage:@"/mensajeEnviado"];
	
	
	[WSCall getBannerforPosicion:3 is_nuevo:appDelegate.is_nuevo thebanner:thebanner1];
	
	
	NSURL *url = [NSURL URLWithString:thebanner1.UrlImage];
	thebanner.image = [[UIImage imageWithData: [NSData dataWithContentsOfURL:url]] retain];
	
	
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
	
	if(theweb!=nil)
	{
		[theweb release];
		theweb=nil;
	}
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	if(theweb!=nil)
	{
		[theweb release];
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

-(IBAction) clickVolverBusqueda:(id)aob
{
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	[self.navigationController popToViewController:appDelegate.acontrollersearch animated:YES];

}
-(IBAction) clickVolverInicio:(id)aob
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction) clickAnunciosSimilares:(id)aob
{
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	[self.navigationController popToViewController:appDelegate.acontrollersearch animated:YES];
}



@end

//
//  SimpleWebView.m
//
//  Created by Moises Swiczar on 12/02/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SimpleWebView.h"
#import "deAutosAppDelegate.h"
@implementation SimpleWebView
@synthesize string_web;
@synthesize string_title;



// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title =@"Deautos.com";

    }
    return self;
}

-(void) clikoninfobar:(id)aobj
{
	[self.navigationController popViewControllerAnimated:YES];
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewWillAppear:(BOOL)animated
{
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate trackpage:@"/bannerClick"];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[myview stopLoading];
}


- (void)viewDidLoad {
    [super viewDidLoad];

	CGRect frame = CGRectMake(0.0, 0.0, 25.0, 25.0);
	UIActivityIndicatorView *progressView = [[UIActivityIndicatorView alloc] initWithFrame:frame];
	progressView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
	progressView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
									 UIViewAutoresizingFlexibleRightMargin |
									 UIViewAutoresizingFlexibleTopMargin |
									 UIViewAutoresizingFlexibleBottomMargin);
	
	UINavigationItem *navItem = self.navigationItem;
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:progressView];
	navItem.rightBarButtonItem = buttonItem;
	// we are done with these since the nav bar retains them:
	[progressView release];
	[buttonItem release];
		

	// start fetching the default web page
	[(UIActivityIndicatorView *)navItem.rightBarButtonItem.customView startAnimating];							
	[self go];
	UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn addTarget:self action:@selector(clikoninfobar:) forControlEvents:UIControlEventTouchUpInside];
	btn.frame = CGRectMake(0, 0, 50, 20);
	[btn setImage:[UIImage imageNamed:@"Back Inactivo.png"] forState:UIControlStateNormal];
	UIBarButtonItem * theinfobutton = [[UIBarButtonItem alloc] initWithCustomView:btn];
	self.navigationItem.hidesBackButton=YES;
	
	self.navigationItem.leftBarButtonItem = theinfobutton;

	
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


- (void)stopProgressIndicator
{
	UINavigationItem *navItem = self.navigationItem;
	UIActivityIndicatorView *progView = (UIActivityIndicatorView *)navItem.rightBarButtonItem.customView;
	[progView stopAnimating];
	progView.hidden = YES;
}


-(void)go
{
	UINavigationItem *navItem = self.navigationItem;
	[(UIActivityIndicatorView *)navItem.rightBarButtonItem.customView startAnimating];							
	
	[myview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string_web]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	UINavigationItem *navItem = self.navigationItem;
	
	UIActivityIndicatorView *progView = (UIActivityIndicatorView *)navItem.rightBarButtonItem.customView;
	[progView startAnimating];
	progView.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[self stopProgressIndicator];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[self stopProgressIndicator];
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate updateStatus];
	if (appDelegate.internetConnectionStatus==NotReachable)
	{
		[appDelegate shownotreacheable];
		return;
	}
	
	
}






@end

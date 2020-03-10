//
//  ImageDetail.m
//  deAutos
//
//  Created by Moises Swiczar on 11/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageDetail.h"
#import "deAutosAppDelegate.h"

@implementation ImageDetail
@synthesize string_web;
@synthesize string_title;
@synthesize arrayimagenames;



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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

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
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate trackpage:@"/imagenesAuto"];

	
	UINavigationItem *navItem = self.navigationItem;
	[(UIActivityIndicatorView *)navItem.rightBarButtonItem.customView startAnimating];							
	
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSURL *baseURL = [NSURL fileURLWithPath:path];
	if(arrayimagenames==nil)
	{
		NSString * htmlString = [NSString stringWithFormat:@"<html><body><center><br><br><br><br><br><br><br><br><br><img src='%@' width=640 height=480/></center></body></html>",string_web];
		[myview loadHTMLString:htmlString baseURL:baseURL];	
	}
	else
	{
		NSString * htmlString = [NSString stringWithFormat:@"<html><body>"];
		NSUInteger i;
		for (i =0 ; i<[arrayimagenames count]; i++)
		{
			htmlString = [NSString stringWithFormat:@"%@<br><br><br><br><br><br><br><center><img src='%@' width=640 height=480/></center>",htmlString,[arrayimagenames objectAtIndex:i]];
		}
		htmlString = [NSString stringWithFormat:@"%@<br><br><br><br><br><br><br></body></html>",htmlString];
		[myview loadHTMLString:htmlString baseURL:baseURL];	
	
	}
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

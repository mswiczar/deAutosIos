//
//  MoreDetail.h
//  deAutos
//
//  Created by Moises Swiczar on 11/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleWebView.h"
#import "NBanner.h"

@interface MoreDetail : UIViewController {
	SimpleWebView *theweb;
	IBOutlet UIImageView *imageBanner;
	NSMutableArray * thearray;
	IBOutlet UITextView * thespecs;
	NSMutableDictionary * theaviso;
	NBanner* thebanner1;

	
	UIActivityIndicatorView *progressInd;
	UIAlertView             *backAlert;
	NSTimer	                *atimergetdata;
	
}

@property(nonatomic,assign) NSMutableDictionary * theaviso;
-(IBAction) clickBanner:(id)aobj;
-(void) show;

@end






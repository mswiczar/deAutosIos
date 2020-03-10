//
//  ListResultScreen.h
//  deAutos
//
//  Created by Moises Swiczar on 11/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleWebView.h"
#import "NBanner.h"

//	NSInteger sorttype = 0 precio asc;
//	NSInteger sorttype = 1 precio desc;
//	NSInteger sorttype = 2 ano asc;
//	NSInteger sorttype = 3 ano desc;
//	NSInteger sorttype = 4 km asc;
//	NSInteger sorttype = 5 km desc;


#import "DetailAuto.h"

@interface ListResultScreen : UIViewController {
	IBOutlet  UIImageView *thebanner;
	IBOutlet  UIImageView *theheadersort;
	IBOutlet  UITableView *thetable;
	NSMutableArray        *thearray;
	NSInteger              sorttype;
	DetailAuto            *theautodetail;
	SimpleWebView         *theweb;
	
	UIActivityIndicatorView *progressInd;
	UIAlertView             *backAlert;
	NSTimer	                *atimergetdata;
	
	UIImage *image1;
	NSInteger avisosporpag;
	NSInteger paginanro;
	UITableViewCell *thecell;
	NSString *thesort;
	NSString *asc_desc;
	NSInteger intorden;
	NBanner *thebanner1;
	
	
	IBOutlet  UIImageView *IVprecio;
	IBOutlet  UIImageView *IVano;
	IBOutlet  UIImageView *IVkm;

	
}

-(IBAction) clickbanner:(id)aobj;

-(IBAction) clickSortPrecio:(id)aobj;
-(IBAction) clickSortAnio:(id)aobj;
-(IBAction) clickSortKm:(id)aobj;

-(void) dofill;
-(void)showmoredata;

@end

//
//  deAutosViewController.h
//  deAutos
//
//  Created by Moises Swiczar on 10/1/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListResultScreen.h"
#import "BookMarked.h"

@interface deAutosViewController : UIViewController {

	IBOutlet UIImageView *imagenuevo;
	IBOutlet UIImageView *imageusado;
	IBOutlet UITableView *tablesearch;
	ListResultScreen* myresult;
	
	BookMarked * achoose;
	UIImage *image1;

	
}


-(IBAction) clicknuevo:(id)aobj;
-(IBAction) clickusado:(id)aobj;
-(IBAction) clickbuscar:(id)aobj;




@end


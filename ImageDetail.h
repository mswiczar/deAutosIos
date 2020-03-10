//
//  ImageDetail.h
//  deAutos
//
//  Created by Moises Swiczar on 11/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageDetail : UIViewController {
	IBOutlet UIWebView * myview; 
	NSString *string_web; 
	NSString *string_title;
	NSMutableArray * arrayimagenames;
}
@property (nonatomic,copy)  NSString *string_web;
@property (nonatomic,copy)  NSString *string_title;
@property (nonatomic,assign) NSMutableArray * arrayimagenames;

-(void)go;
@end

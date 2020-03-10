//
//  ImageController.h

#import <UIKit/UIKit.h>

@interface ImageController : UIViewController {
	IBOutlet UIImageView* theimageview;
	BOOL loaded;
	NSString* stringImages;
	NSString* stringImages2;
	IBOutlet UIActivityIndicatorView * activitiind;	
	id thecont;
	NSURLConnection *queryConnection;
	NSMutableData *receivedData;

	
	
}
@property (nonatomic,retain) NSMutableData *receivedData;

@property (nonatomic,copy) NSString* stringImages;
@property (nonatomic,copy) NSString* stringImages2;
@property (nonatomic,assign) id thecont;
-(IBAction) click:(id)aobj;
-(void) show:(id)aobj;
-(void) stop;

@end

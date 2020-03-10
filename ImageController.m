
//

#import "ImageController.h"
#import "deAutosAppDelegate.h"
#import "WSCall.h"
#import "ImageController.h"
#import "UChache.h"
#import "DetailAuto.h"

@implementation ImageController
@synthesize stringImages;
@synthesize stringImages2;
@synthesize thecont;
@synthesize receivedData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		loaded=NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor clearColor];
	[activitiind startAnimating];


	
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
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	if(queryConnection!=nil)
	{
		[queryConnection cancel];
		[queryConnection release];
		queryConnection=nil;
		
	}
	[super dealloc];
	
}






-(IBAction) click:(id)aobj
{
	if(loaded)
	{
		((DetailAuto*)thecont).theurlimagetosee=stringImages2;
		[((DetailAuto*)thecont) changenow];
	}
}


- (void) loadImageInBackground
{
	/*
	sleep(1);
	//NSURL *url = [NSURL URLWithString:self.stringImages];
	//theloadimage = [[UIImage imageWithData: [NSData dataWithContentsOfURL:url]] retain];
	theloadimage=[[UIImage imageWithData:[UChache cachedIconFromURL:self.stringImages]]retain];
	theimageview.image=theloadimage;
	[activitiind stopAnimating];
	loaded=YES;
	sleep(1);
	 */
}



-(void) show:(id)aobj
{
	if(self.stringImages==nil)
	{
		theimageview.alpha=0;
		return;
	};
	
	
	theimageview.alpha=0;
	if ([UChache existincache:self.stringImages])
	{
		NSData * thedata = [UChache cachedIconFromURL:self.stringImages];
		UIImage * theim = [UIImage imageWithData:thedata];
		if(theim!=nil)
		{
			theimageview.image=theim;
		}
		else
		{
			theimageview.image=nil;
			loaded=YES;
			theimageview.alpha=0;
			[activitiind stopAnimating];
			return;
		}
		[thedata release];
		[activitiind stopAnimating];
		loaded=YES;
		theimageview.alpha=1;
		return;
	}
	
	[activitiind startAnimating];
		
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.stringImages]
							cachePolicy:NSURLRequestReturnCacheDataElseLoad
											 timeoutInterval:30];
	queryConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (queryConnection) 
	{
			self.receivedData = [NSMutableData data];
	} 
	else 
	{
		[activitiind stopAnimating];
		NSLog(@"Connection Error");
	}
/*	
	[NSThread detachNewThreadSelector:@selector(loadImageInBackground)
							 toTarget:self withObject:nil];
 */
}


-(void) stop
{
	[activitiind stopAnimating];
	[queryConnection cancel]; 
	theimageview.alpha=0;
}



//connection delegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	// release the connection, and the data object
    [connection release];
    // receivedData is declared as a method instance elsewhere
    self.receivedData = nil;
	[activitiind stopAnimating];

	
	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
	[activitiind stopAnimating];
	theimageview.alpha=1;
	theimageview.image=[UIImage imageWithData:receivedData];
	NSData * thedata = [[NSData alloc] initWithData:receivedData];
	[UChache setInCache:thedata aurl:stringImages];
	[thedata release];

    self.receivedData = nil;
	loaded=YES;
    [queryConnection release];
	queryConnection = nil;
}









@end

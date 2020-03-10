
#import "CellMore.h"

@implementation CellMore




- (id)initWithFrame:(CGRect)aRect reuseIdentifier:(NSString *)identifier
{
	if (self = [super initWithFrame:aRect reuseIdentifier:identifier])
	{
		theimage =[ [UIImageView  alloc] initWithFrame:CGRectZero];
		theimage.image = [UIImage imageNamed:@"Prox 10 Inactivo.png"];
		
		thesleep = [[UIActivityIndicatorView  alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		thesleep.hidesWhenStopped=YES;

		[self.contentView addSubview:theimage];
		[self.contentView addSubview:thesleep];
	
		self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgfirstscreen.png"]];
	}
	return self;
}




- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGRect frameItemnAdress = CGRectMake(220,10,70, 30);
	theimage.frame = frameItemnAdress;

	frameItemnAdress = CGRectMake(145,17.5,20, 20);
	thesleep.frame= frameItemnAdress;

	
	
}

- (void)dealloc
{
	[theimage release];
	[thesleep release];
    [super dealloc];
}



-(void) start
{
	theimage.alpha=0;
	[thesleep startAnimating];
}

-(void) stop
{
	theimage.alpha=1;
	[thesleep stopAnimating];
}




@end



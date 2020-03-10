//  UICellConfig.h

#import <UIKit/UIKit.h>
@interface Cellinfo: UITableViewCell
{
	NSMutableDictionary *thedict;
	UIImageView *aimageview1;
	UILabel * label_nombre;
	UILabel * label_ano;
	UILabel * label_combustible;
	UILabel * label_precio;
	UILabel * label_kms;
	UILabel * label_vendido;
	
	
}

+(void) getformatedprice:(NSString *)instring outstring:(NSString**)outstring;

@property (nonatomic,assign) 	NSMutableDictionary *thedict;

-(void) showData;

@end

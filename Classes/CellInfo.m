

#import "Cellinfo.h"
#import "deAutosAppDelegate.h"
#import "UChache.h"

@implementation Cellinfo
@synthesize thedict;

static NSNumberFormatter *numberFormatter=nil;

- (id)initWithFrame:(CGRect)aRect reuseIdentifier:(NSString *)identifier
{
	if (self = [super initWithFrame:aRect reuseIdentifier:identifier])
	{
		aimageview1 = [[UIImageView alloc] initWithFrame:aRect];
		aimageview1.backgroundColor = [UIColor clearColor];
		aimageview1.opaque = NO;
		aimageview1.image = [UIImage imageNamed:@"pic1.png"];
		self.contentView.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:aimageview1];

		label_nombre =[[UILabel alloc]initWithFrame:CGRectZero];
		label_nombre.textColor = [UIColor blackColor];
		label_nombre.font =[UIFont fontWithName:@"Helvetica" size:12];

		label_ano =[[UILabel alloc]initWithFrame:CGRectZero];
		label_ano.textColor = [UIColor blackColor];
		label_ano.font =[UIFont fontWithName:@"Helvetica" size:12];

		label_combustible =[[UILabel alloc]initWithFrame:CGRectZero];
		label_combustible.textColor = [UIColor blackColor];
		label_combustible.font =[UIFont fontWithName:@"Helvetica" size:12];

		label_precio =[[UILabel alloc]initWithFrame:CGRectZero];
		label_precio.textColor = [UIColor blackColor];
		label_precio.font =[UIFont fontWithName:@"Helvetica" size:12];

		label_kms =[[UILabel alloc]initWithFrame:CGRectZero];
		label_kms.textColor = [UIColor blackColor];
		label_kms.font =[UIFont fontWithName:@"Helvetica" size:12];
		
		label_vendido =[[UILabel alloc]initWithFrame:CGRectZero];
		label_vendido.textColor = [UIColor orangeColor];
		label_vendido.font =[UIFont fontWithName:@"Helvetica" size:12];
		
		
		

		[self.contentView addSubview:label_nombre];
		[self.contentView addSubview:label_ano];
		[self.contentView addSubview:label_combustible];
		[self.contentView addSubview:label_precio];
		[self.contentView addSubview:label_kms];
		[self.contentView addSubview:label_vendido];

		
		label_vendido.text =@"";
		label_nombre.text =@"";
		label_ano.text=@"";
		label_combustible.text=@"";
		label_precio.text=@"";
		label_kms.text=@"";
		
		

	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGRect Pic1 = CGRectMake(0,10,70, 50);
	aimageview1.frame = Pic1;

	Pic1 = CGRectMake(74,7.5,220,15);
	label_nombre.frame = Pic1;
	
	Pic1 = CGRectMake(74,25,80, 15);
	label_ano.frame = Pic1;
	
	Pic1 = CGRectMake(150,25,130, 15);
	label_precio.frame = Pic1;
	
	Pic1 = CGRectMake(74,42.5,80, 15);
	label_combustible.frame = Pic1;

	Pic1 = CGRectMake(150,42.5,130, 15);
	label_kms.frame = Pic1;

	Pic1 = CGRectMake(240,42.5,60, 15);
	label_vendido.frame = Pic1;
	
	
}



- (void)dealloc
{
	[aimageview1 release];
	[label_nombre release];
	[label_ano release];
	[label_combustible release];
	[label_precio release];
	[label_kms release];
	[label_vendido release];
    [super dealloc];
}

/*
 deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
 
 
 */
//2009-11-10 13:12:42.675 deAutos[15587:20b] http://www.deautos.com/images/images/fotosplaya//54947.jpg

-(void) showData
{
	NSString * precio;
	
	NSInteger est;
	label_vendido.text =@"";

	
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];

	if(appDelegate.is_nuevo)
	{
		est= [((NSString*)[thedict objectForKey:@"clsAviso0km_Estado_id"]) intValue];

		[Cellinfo getformatedprice:[thedict objectForKey:@"clsAviso0km_Precio"]  outstring:&precio];
//		NSLog([NSString stringWithFormat:@"http://www.deautos.com/images/fotos0KM/%@.jpg",[thedict objectForKey:@"clsAviso0km_Fotos_id"]]);
//		NSData * theda = [UChache cachedIconFromURL:;
//		aimageview1.image =[UIImage imageWithData:theda];
//		[theda release];

		NSData * theda = [UChache cachedIconFromURL:[NSString stringWithFormat:@"http://www.deautos.com/images/fotos0KM/%@.jpg",[thedict objectForKey:@"clsAviso0km_Fotos_id"]]];
		UIImage *theimg  = [UIImage imageWithData:theda];
		if(theimg!=nil)
		{
			aimageview1.image=theimg;
			[thedict setObject:aimageview1.image forKey:@"imagen"];
		}
		else
		{
			[thedict setObject:[UIImage imageNamed:@"noimage.png"] forKey:@"imagen"];
			aimageview1.image=[UIImage imageNamed:@"noimage.png"];
			
		}
		[theda release];
		
		
		
		
		label_nombre.text =[NSString stringWithFormat:@"%@ %@ %@",[thedict objectForKey:@"clsAviso0km_Auto_Modelo_Marca_Nombre"],[thedict objectForKey:@"clsAviso0km_Auto_Modelo_Nombre"],[thedict objectForKey:@"clsAviso0km_Auto_Nombre"]];
		label_ano.text=[NSString stringWithFormat:@"Año: %@",[thedict objectForKey:@"clsAviso0km_Anio"]];
		label_combustible.text=[thedict objectForKey:@"clsAviso0km_Combustible"];
		label_precio.text= [NSString stringWithFormat:@"Precio: %@ %@",[thedict objectForKey:@"clsAviso0km_Moneda_nombre"],precio];
		label_kms.text=[NSString stringWithFormat:@"Km: %@",[thedict objectForKey:@"clsAviso0km_Km"]];

	}
	
	else
	{
		est= [((NSString*)[thedict objectForKey:@"clsAvisoUsado_Estado_id"]) intValue];

		//NSLog();
//		NSString* theurl =  @"http://www.deautos.com//images/fotosplaya/706525.jpg";
//		NSData * theda = [UChache cachedIconFromURL:[NSString stringWithFormat:@"http://www.deautos.com%@%@.jpg",[thedict objectForKey:@"clsAvisoUsado_AvisoTipo_pathDir"],[thedict objectForKey:@"clsAvisoUsado_Fotos_id"]]];
		[Cellinfo getformatedprice:[thedict objectForKey:@"clsAvisoUsado_Precio"]  outstring:&precio];

		//NSString* theurl =  @"http://www.deautos.com//images/fotosplaya/706525.jpg";
		if([thedict objectForKey:@"imagen"]==nil)
		{
			NSString* theurl = [NSString stringWithFormat:@"http://www.deautos.com/images/fotosplaya/%@.jpg",[thedict objectForKey:@"clsAvisoUsado_Fotos_id"]];
			NSData * theda = [UChache cachedIconFromURL:theurl];
			UIImage *theimg  = [UIImage imageWithData:theda];
			if(theimg!=nil)
			{
				aimageview1.image=theimg;
				[thedict setObject:aimageview1.image forKey:@"imagen"];
			}
			else
			{
				[thedict setObject:[UIImage imageNamed:@"noimage.png"] forKey:@"imagen"];
				aimageview1.image=[UIImage imageNamed:@"noimage.png"];

			}
			[theda release];
		}
		else
		{
			aimageview1.image =[thedict objectForKey:@"imagen"];
		}
		
		if(est<3)
		{
			label_vendido.text =@"";
		}
		else
		{
			label_vendido.text =@"Vendido";

		}
		label_nombre.text =[NSString stringWithFormat:@"%@ %@ %@",[thedict objectForKey:@"clsAvisoUsado_Auto_Modelo_Marca_Nombre"],[thedict objectForKey:@"clsAvisoUsado_Auto_Modelo_Nombre"],[thedict objectForKey:@"clsAvisoUsado_Auto_Nombre"]];
		label_ano.text=[NSString stringWithFormat:@"Año: %@",[thedict objectForKey:@"clsAvisoUsado_Anio"]];
		label_combustible.text=[thedict objectForKey:@"clsAvisoUsado_Combustible"];
		label_precio.text= [NSString stringWithFormat:@"Precio: %@ %@",[thedict objectForKey:@"clsAvisoUsado_Moneda_nombre"],precio];
		label_kms.text=[NSString stringWithFormat:@"Km: %@",[thedict objectForKey:@"clsAvisoUsado_Km"]];
		
	}
	
}



+(void) getformatedprice:(NSString *)instring outstring:(NSString**)outstring
{
	NSNumber *result =[[NSNumber  alloc] initWithFloat :[instring floatValue]];
	
	if (numberFormatter==nil) 
	{
		numberFormatter=	[[NSNumberFormatter alloc] init];
		[numberFormatter setFormatterBehavior:kCFNumberFormatterCurrencyStyle];
		[numberFormatter setDecimalSeparator:@","];
		
		NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
		[numberFormatter setLocale:usLocale];
		[numberFormatter setPositiveFormat:@"###,###,##0"];
		[usLocale release];
		
	}
	
	*outstring = [numberFormatter stringFromNumber:result];
	[result release];
}

@end



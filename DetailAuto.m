//
//  DetailAuto.m
//  deAutos
//
//  Created by Moises Swiczar on 11/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DetailAuto.h"
#import "deAutosAppDelegate.h"
#import "UChache.h"
#import "ImageController.h"
#import "WSCall.h"
#import "Cellinfo.h"

@implementation DetailAuto
@synthesize theobj;
@synthesize theurlimagetosee;
@synthesize receivedData;



-(void) fixit
{
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate trackpage:@"/detalleAuto"];
	
	
	
	
	
//	theurlimagetosee = @"";
	thebut.alpha=0;
	displayimage.alpha=0;
	NSString * theprice;
	
	if(appDelegate.is_nuevo)
	{
		[ Cellinfo getformatedprice:[theobj objectForKey:@"clsAviso0km_Precio"] outstring:&theprice];
		themore.alpha=0;
	//	self.theurlimagetosee=[NSString stringWithFormat:@"http://www.deautos.com/images/fotos0KM/%@_1g.jpg",[theobj objectForKey:@"clsAviso0km_Fotos_id"]];
		label_titulo.text =[NSString stringWithFormat:@"%@ %@ %@",[theobj objectForKey:@"clsAviso0km_Auto_Modelo_Marca_Nombre"],[theobj objectForKey:@"clsAviso0km_Auto_Modelo_Nombre"],[theobj objectForKey:@"clsAviso0km_Auto_Nombre"]];
		label_ano.text =[NSString stringWithFormat:@"%@",[theobj objectForKey:@"clsAviso0km_Anio"]];
		label_combistible.text=[theobj objectForKey:@"clsAviso0km_Combustible"];
		label_precio.text= [NSString stringWithFormat:@"%@ %@",[theobj objectForKey:@"clsAviso0km_Moneda_nombre"],theprice];
		label_kms.text=[NSString stringWithFormat:@"%@",[theobj objectForKey:@"clsAviso0km_Km"]];
		
		label_segmento.text     =[theobj objectForKey:@"clsAviso0km_Auto_Segmento"];
		label_color.text        =[theobj objectForKey:@"clsAviso0km_Color_nombre"];
		label_equipamiento.text =[theobj objectForKey:@"clsAviso0km_Equipamiento"];
		label_formadepago.text  =[theobj objectForKey:@"clsAviso0km_FormadePago"];
		label_localidad.text =[theobj objectForKey:@"clsAviso0km_Localidad_Zona_Provincia_Nombre"];
		
		
		
		//label_comentarios.text  =[theobj objectForKey:@"clsAviso0km_Km"];
	}
	
	else
	{
		[ Cellinfo getformatedprice:[theobj objectForKey:@"clsAvisoUsado_Precio"] outstring:&theprice];
		
		themore.alpha=1;
		displayimage.alpha=0;
		
//		self.theurlimagetosee=[NSString stringWithFormat:@"http://www.deautos.com/images/fotosplaya/%@_1c.jpg",[theobj objectForKey:@"clsAvisoUsado_Fotos_id"]];

		
		label_titulo.text =[NSString stringWithFormat:@"%@ %@ %@",[theobj objectForKey:@"clsAvisoUsado_Auto_Modelo_Marca_Nombre"],[theobj objectForKey:@"clsAvisoUsado_Auto_Modelo_Nombre"],[theobj objectForKey:@"clsAvisoUsado_Auto_Nombre"]];
		label_ano.text =[NSString stringWithFormat:@"%@",[theobj objectForKey:@"clsAvisoUsado_Anio"]];
		label_combistible.text=[theobj objectForKey:@"clsAvisoUsado_Combustible"];
		label_precio.text= [NSString stringWithFormat:@"%@ %@",[theobj objectForKey:@"clsAvisoUsado_Moneda_nombre"],theprice];
		label_kms.text=[NSString stringWithFormat:@"%@",[theobj objectForKey:@"clsAvisoUsado_Km"]];
		
		label_segmento.text     =[theobj objectForKey:@"clsAvisoUsado_Auto_Segmento"];
		label_color.text        =[theobj objectForKey:@"clsAvisoUsado_Color_nombre"];
		label_equipamiento.text =[theobj objectForKey:@"clsAvisoUsado_Equipamiento"];
		label_formadepago.text  =[theobj objectForKey:@"clsAvisoUsado_FormadePago"];
		label_localidad.text =[theobj objectForKey:@"clsAvisoUsado_Localidad_Zona_Provincia_Nombre"];
		
		//label_comentarios.text  =[theobj objectForKey:@"clsAvisoUsado_Km"];
	}
	
}

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		thecontactar=nil;	
		theimagedet=nil;
		theweb=nil;
		thearrayImages = [[NSMutableArray alloc]init ];
		self.title =@"Deautos.com";
		thefullshowimages = [[NSMutableArray alloc] init];
		themoredetail=nil;
		thebanner1 = [[NBanner alloc]init];
		needreload =NO;

		for (unsigned i = 0; i < 8; i++) 
		{
			[thearrayImages addObject:[NSNull null]];
		}
		
    }
    return self;
}
-(void) clikoninfobar:(id)aobj
{
	[self.navigationController popViewControllerAnimated:YES];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn addTarget:self action:@selector(clikoninfobar:) forControlEvents:UIControlEventTouchUpInside];
	btn.frame = CGRectMake(0, 0, 50, 20);
	[btn setImage:[UIImage imageNamed:@"Back Inactivo.png"] forState:UIControlStateNormal];
	UIBarButtonItem * theinfobutton = [[UIBarButtonItem alloc] initWithCustomView:btn];
	self.navigationItem.hidesBackButton=YES;
	
	self.navigationItem.leftBarButtonItem = theinfobutton;
	if (needreload)
	{
		needreload=NO;
		[self show];
	}
	
	
}


- (void)viewDidAppear:(BOOL)animated
{
	//[self changenow];
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];

	if(appDelegate.is_nuevo)
	{
		self.theurlimagetosee=[NSString stringWithFormat:@"http://www.deautos.com/images/fotos0KM/%@_%dg.jpg",[theobj objectForKey:@"clsAviso0km_Fotos_id"],1];
		
	}
	else
	{
		self.theurlimagetosee=[NSString stringWithFormat:@"http://www.deautos.com/images/fotosplaya/%@_%dg.jpg",[theobj objectForKey:@"clsAvisoUsado_Fotos_id"],1];
	}		
	
	if(displayimage.alpha==0)
	{
	NSData * thedata = [UChache cachedIconFromURL:theurlimagetosee];
	displayimage.image =[UIImage imageWithData:thedata];
	[thedata release];
	displayimage.alpha=1;
	}
	
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

	if(thecontactar!=nil)
	{
		[thecontactar release];
		thecontactar=nil;
	}

	if(theimagedet!=nil)
	{
		[theimagedet release];
		theimagedet=nil;

	}

	if(theweb!=nil)
	{
		[theweb release];
		theweb=nil;

	}

	if(themoredetail!=nil)
	{
		[themoredetail release];
		themoredetail=nil;

	}
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
//	needreload =YES;

	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

//- (void)viewWillA:(BOOL)animated // Called when the view is dismissed, covered or otherwise hidden. Default does nothing

- (void)viewWillAppear:(BOOL)animated
{
	
	butoncontactar.alpha=0;
	NSInteger est;
	BOOL equip;
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	if(appDelegate.is_nuevo)
	{
		est= [((NSString*)[theobj objectForKey:@"clsAviso0km_Estado_id"]) intValue];
		equip= [[theobj objectForKey:@"clsAviso0km_Equipamiento_clsTblDic_value"]isEqualToString:@"true"];
		
	}
	else
	{
		est= [((NSString*)[theobj objectForKey:@"clsAvisoUsado_Estado_id"]) intValue];
		equip= [[theobj objectForKey:@"clsAvisoUsado_Equipamiento_clsTblDic_value"]isEqualToString:@"true"];
		
	}
	
	if(est< 3)
	{
		butoncontactar.alpha=1;
		labelVendido.alpha=0;
	}
	else
	{
		labelVendido.alpha=1;
	}
	
	for (unsigned i = 0; i < 8; i++) 
	{
		//[self loadScrollViewWithPage:i];
	    ImageController *controller = [thearrayImages objectAtIndex:i];
		if  ((NSNull *)controller != [NSNull null])
		{
			[controller stop];
			[controller.view setNeedsDisplay];
		}
	}
	if(qimages >4)
	{
		themorearrow.alpha=1;
	}
	else
	{
		themorearrow.alpha=0;

	}
	for (unsigned i = 0; i < qimages; i++) 
	{
		//[self loadScrollViewWithPage:i];
	    ImageController *controller = [thearrayImages objectAtIndex:i];
		if  ((NSNull *)controller != [NSNull null])
		{
			[controller show:self];
			[controller.view setNeedsDisplay];
		}
	}
	BEqui.alpha=0;
	BEqui2.alpha=0;

	if(equip)

	{
		BEqui.alpha=1;
		BEqui2.alpha=1;

	}
	
	[self fixit];
	
	
	
}


- (void)viewWillDisappear:(BOOL)animated // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
{

	for (unsigned i = 0; i < 8; i++) 
	{
		//[self loadScrollViewWithPage:i];
	    ImageController *controller = [thearrayImages objectAtIndex:i];
		if  ((NSNull *)controller != [NSNull null])
		{
			[controller stop];
			[controller.view setNeedsDisplay];
		}
	}
}


- (void)dealloc {
    
	if(thecontactar!=nil)
	{
		[thecontactar release];
	}
	
	if(theimagedet!=nil)
	{
		[theimagedet release];
	}
	
	if(theweb!=nil)
	{
		[theweb release];
	}
	
	if(themoredetail!=nil)
	{
		[themoredetail release];
	}

	[super dealloc];
	
}

-(IBAction) clickImage:(id)aobj
{
	if(theimagedet==nil)
	{
		theimagedet = [[ImageDetail alloc] initWithNibName:@"ImageDetail" bundle:nil];
	}
	theimagedet.string_web =self.theurlimagetosee;
	theimagedet.arrayimagenames = nil;
	[self.navigationController pushViewController:theimagedet animated:YES];
	[theimagedet go];
}


-(IBAction) clickbanner:(id)aobj
{
	if(theweb==nil)
	{
		theweb = [[SimpleWebView alloc] initWithNibName:@"SimpleWebView" bundle:nil];
	}
	theweb.string_web =thebanner1.UrlClick;

//	theweb.string_web =@"http://www.deautos.com";
	[self.navigationController pushViewController:theweb animated:YES];
	[theweb go];
	
}

-(IBAction) clickContactar:(id)aobj
{
	if(thecontactar==nil)
	{
		thecontactar = [[Contactar alloc] initWithNibName:@"Contactar" bundle:nil];
	}
	thecontactar.theaviso = theobj;
	
	[self.navigationController pushViewController:thecontactar animated:YES];
}




-(void) loaddata:(id)aobj
{
//	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
/*
	if(appDelegate.is_nuevo)
	{		
		NSData * aux=[UChache cachedIconFromURL:[NSString stringWithFormat:@"http://www.deautos.com/images/fotos0KM/%@_1c.jpg",[theobj objectForKey:@"clsAviso0km_Fotos_id"]]];
		displayimage.image =[UIImage imageWithData:aux];
		[aux release];
	}
	else
	{
		NSData * aux=[UChache cachedIconFromURL:[NSString stringWithFormat:@"http://www.deautos.com/%@_1c.jpg",[theobj objectForKey:@"clsAvisoUsado_Fotos_id"]]];
		displayimage.image =[UIImage imageWithData:aux];
		[aux release];
	}	
 */

 displayimage.alpha=1;
	thebut.alpha=1;
	[theact stopAnimating];
	
}
-(void) loaddata2:(id)aobj
{
	NSData * thedata = [UChache cachedIconFromURL:self.theurlimagetosee];
	displayimage.image =[UIImage imageWithData:thedata];
	[thedata release];
	displayimage.alpha=1;
	thebut.alpha=1;
	[theact stopAnimating];
	
}

-(void) changenow
{
	displayimage.alpha=0;
	thebut.alpha=0;
	[theact startAnimating];
	
	
	
	
	atimergetdata = [NSTimer scheduledTimerWithTimeInterval: 0.1
													 target: self
												   selector: @selector (loaddata2:)
												   userInfo: self
													repeats: NO];
	
}

-(void) showalldata
{
	[theact startAnimating];
	
	atimergetdata = [NSTimer scheduledTimerWithTimeInterval: 0.1
													 target: self
												   selector: @selector (loaddata:)
												   userInfo: self
													repeats: NO];
};

-(void) createarrayimages
{
	
	
	//64 x 48
	
	
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	if(appDelegate.is_nuevo)
	{
	//	cantidadimagenes = [((NSString*)[theobj objectForKey:@"clsAviso0km_AvisoTipo_qFotos"]) intValue];
		qimages= [((NSString*)[theobj objectForKey:@"clsAviso0km_Fotos_qFotos"]) intValue];
	}
	else
	{
	//	cantidadimagenes = [((NSString*)[theobj objectForKey:@"clsAvisoUsado_AvisoTipo_qFotos"]) intValue];
		qimages= [((NSString*)[theobj objectForKey:@"clsAvisoUsado_Fotos_qFotos"]) intValue];
	}
	
	thescroll.pagingEnabled = NO;
	thescroll.multipleTouchEnabled=NO;
    thescroll.showsHorizontalScrollIndicator = NO;
    thescroll.showsVerticalScrollIndicator = NO;
    thescroll.scrollsToTop = NO;
	
	
	
	thescroll.contentSize = CGSizeMake(80 * 8 + 40, thescroll.frame.size.height);
	CGPoint thepoint;
	thepoint.x=0;
	thepoint.y=0;
	
	thescroll.contentOffset = thepoint;
	
	for (unsigned i = 0; i < 8; i++) {
		[self loadScrollViewWithPage:i];

    }
	
}





-(void) adelay:(id)aobj
{
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];

	
	NSString * stringURL;
	
	if(appDelegate.is_nuevo)
	{		
		stringURL =[NSString stringWithFormat:@"http://www.deautos.com/images/fotos0KM/%@_1c.jpg",[theobj objectForKey:@"clsAviso0km_Fotos_id"]];
	}
	else
	{
		stringURL =[NSString stringWithFormat:@"http://www.deautos.com/images/fotosplaya/%@_1c.jpg",[theobj objectForKey:@"clsAvisoUsado_Fotos_id"]];
	}	
	
	if ([UChache existincache:stringURL])
	{
		[theact stopAnimating];
		displayimage.alpha=1;
		thebut.alpha=1;
		NSData * thed = [UChache cachedIconFromURL:stringURL];
		displayimage.image=[UIImage imageWithData:thed];
		[thed release];
	}
	else
	{
		[theact startAnimating];
		
		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:stringURL]
												 cachePolicy:NSURLRequestReturnCacheDataElseLoad
											 timeoutInterval:30];
		
		queryConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
		if (queryConnection) 
		{
			[theact startAnimating];
			displayimage.alpha=0;
			thebut.alpha=0;
			self.receivedData = [NSMutableData data];
		} 
		else 
		{
			[theact stopAnimating];
			NSLog(@"Connection Error");
		}
	}
	
	//	[self showalldata];
	[self createarrayimages];
	if(qimages >4)
	{
		themorearrow.alpha=1;
	}
	else
	{
		themorearrow.alpha=0;
		
	}
	

}

-(void)loadall:(id)aobj
{
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];

	[WSCall getBannerforPosicion:1 is_nuevo:appDelegate.is_nuevo thebanner:thebanner1];
	NSURL *url = [NSURL URLWithString:thebanner1.UrlImage];
	theimagebanner.image = [[UIImage imageWithData: [NSData dataWithContentsOfURL:url]] retain];
	[thebanneract stopAnimating];

}

-(void) show
{
	qimages=0;
	themorearrow.alpha=0;
	/*
	NSUInteger total = [thearrayImages count];
	NSUInteger actual;
	*/
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate trackpage:@"/detalleAuto"];

	if(appDelegate.is_nuevo)
	{
		qimages= [((NSString*)[theobj objectForKey:@"clsAviso0km_Fotos_qFotos"]) intValue];
	}
	else
	{
		qimages= [((NSString*)[theobj objectForKey:@"clsAvisoUsado_Fotos_qFotos"]) intValue];
	}
	
	
	
//	theurlimagetosee = @"";
	thebut.alpha=0;
	displayimage.alpha=0;
	NSString * theprice;
	
	if(appDelegate.is_nuevo)
	{
		[ Cellinfo getformatedprice:[theobj objectForKey:@"clsAviso0km_Precio"] outstring:&theprice];
		themore.alpha=0;
		self.theurlimagetosee=[NSString stringWithFormat:@"http://www.deautos.com/images/fotos0KM/%@_1c.jpg",[theobj objectForKey:@"clsAviso0km_Fotos_id"]];
		label_titulo.text =[NSString stringWithFormat:@"%@ %@ %@",[theobj objectForKey:@"clsAviso0km_Auto_Modelo_Marca_Nombre"],[theobj objectForKey:@"clsAviso0km_Auto_Modelo_Nombre"],[theobj objectForKey:@"clsAviso0km_Auto_Nombre"]];
		label_ano.text =[NSString stringWithFormat:@"%@",[theobj objectForKey:@"clsAviso0km_Anio"]];
		label_combistible.text=[theobj objectForKey:@"clsAviso0km_Combustible"];
		label_precio.text= [NSString stringWithFormat:@"%@ %@",[theobj objectForKey:@"clsAviso0km_Moneda_nombre"],theprice];
		label_kms.text=[NSString stringWithFormat:@"%@",[theobj objectForKey:@"clsAviso0km_Km"]];

		label_segmento.text     =[theobj objectForKey:@"clsAviso0km_Auto_Segmento"];
		label_color.text        =[theobj objectForKey:@"clsAviso0km_Color_nombre"];
		label_equipamiento.text =[theobj objectForKey:@"clsAviso0km_Equipamiento"];
		label_formadepago.text  =[theobj objectForKey:@"clsAviso0km_FormadePago"];
		label_localidad.text =[NSString stringWithFormat:@"%@, %@",[theobj objectForKey:@"clsAviso0km_Localidad_Zona_Provincia_Nombre"], [theobj objectForKey:@"clsAviso0km_Localidad_Nombre"]];

		
		//label_comentarios.text  =[theobj objectForKey:@"clsAviso0km_Km"];
	}
	
	else
	{
		[ Cellinfo getformatedprice:[theobj objectForKey:@"clsAvisoUsado_Precio"] outstring:&theprice];
		
		themore.alpha=1;
		displayimage.alpha=0;
		self.theurlimagetosee=[NSString stringWithFormat:@"http://www.deautos.com/images/fotosplaya/%@_1c.jpg",[theobj objectForKey:@"clsAvisoUsado_Fotos_id"]];
		
		label_titulo.text =[NSString stringWithFormat:@"%@ %@ %@",[theobj objectForKey:@"clsAvisoUsado_Auto_Modelo_Marca_Nombre"],[theobj objectForKey:@"clsAvisoUsado_Auto_Modelo_Nombre"],[theobj objectForKey:@"clsAvisoUsado_Auto_Nombre"]];
		label_ano.text =[NSString stringWithFormat:@"%@",[theobj objectForKey:@"clsAvisoUsado_Anio"]];
		label_combistible.text=[theobj objectForKey:@"clsAvisoUsado_Combustible"];
		label_precio.text= [NSString stringWithFormat:@"%@ %@",[theobj objectForKey:@"clsAvisoUsado_Moneda_nombre"],theprice];
		label_kms.text=[NSString stringWithFormat:@"%@",[theobj objectForKey:@"clsAvisoUsado_Km"]];

		label_segmento.text     =[theobj objectForKey:@"clsAvisoUsado_Auto_Segmento"];
		label_color.text        =[theobj objectForKey:@"clsAvisoUsado_Color_nombre"];
		label_equipamiento.text =[theobj objectForKey:@"clsAvisoUsado_Equipamiento"];
		label_formadepago.text  =[theobj objectForKey:@"clsAvisoUsado_FormadePago"];
		label_localidad.text =[NSString stringWithFormat:@"%@, %@",[theobj objectForKey:@"clsAvisoUsado_Localidad_Zona_Provincia_Nombre"], [theobj objectForKey:@"clsAvisoUsado_Localidad_Nombre"]];

		//label_comentarios.text  =[theobj objectForKey:@"clsAvisoUsado_Km"];
	}
	[self adelay:self];
	[thebanneract startAnimating];

	atimergetdataBanner = [NSTimer scheduledTimerWithTimeInterval:	0.5		// seconds
													 target:		self
												   selector:	@selector (loadall:)
												   userInfo:	self		// makes the currently-active audio queue (record or playback) available to the updateBargraph method
													repeats:	NO];
	
}

-(IBAction) clickMoreDetail:(id)aobj
{
	
	if(themoredetail==nil)
	{
		themoredetail = [[MoreDetail alloc] initWithNibName:@"MoreDetail" bundle:nil];
	}
	themoredetail.theaviso = theobj;
	[self.navigationController pushViewController:themoredetail animated:YES];
	[themoredetail show];
}


- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= [thearrayImages count]) return;
	
    // replace the placeholder if necessary
    ImageController *controller = [thearrayImages objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[ImageController alloc] initWithNibName:@"ImageController" bundle:nil];
		//controller.thenav =self.navigationController;
        [thearrayImages replaceObjectAtIndex:page withObject:controller];
		controller.thecont=self;
        [controller release];
    }
	
    // add the controller's view to the scroll view
    if (nil == controller.view.superview) {
        CGRect frame = thescroll.frame;
		frame.origin.x = 80*(page);
		frame.size.height = 60;
		frame.size.width = 64;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [thescroll addSubview:controller.view];
    }
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if(appDelegate.is_nuevo)
	{
		controller.stringImages=[NSString stringWithFormat:@"http://www.deautos.com/images/fotos0KM/%@_%dc.jpg",[theobj objectForKey:@"clsAviso0km_Fotos_id"],page+1];
		controller.stringImages2=[NSString stringWithFormat:@"http://www.deautos.com/images/fotos0KM/%@_%dg.jpg",[theobj objectForKey:@"clsAviso0km_Fotos_id"],page+1];

	}
	else
	{
		controller.stringImages=[NSString stringWithFormat:@"http://www.deautos.com/images/fotosplaya/%@_%dc.jpg",[theobj objectForKey:@"clsAvisoUsado_Fotos_id"],page+1];
		controller.stringImages2=[NSString stringWithFormat:@"http://www.deautos.com/images/fotosplaya/%@_%dg.jpg",[theobj objectForKey:@"clsAvisoUsado_Fotos_id"],page+1];
	}		
	[controller show:self];
	
	
}


-(IBAction) clickshowall:(id)aobj
{
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	[thefullshowimages removeAllObjects];
	if(appDelegate.is_nuevo)
	{
		for (int i=0; i< qimages ; i++)
		{
			[thefullshowimages addObject:[NSString stringWithFormat:@"http://www.deautos.com/images/fotos0KM/%@_%dg.jpg",[theobj objectForKey:@"clsAviso0km_Fotos_id"],i+1]];
		}
	}
	else
	{
		for (int i=0; i< qimages ; i++)
		{
			[thefullshowimages addObject:[NSString stringWithFormat:@"http://www.deautos.com/images/fotosplaya/%@_%dg.jpg",[theobj objectForKey:@"clsAvisoUsado_Fotos_id"],i+1]];
		}
	}
	theimagedet.arrayimagenames =thefullshowimages;

	if(theimagedet==nil)
	{
		theimagedet = [[ImageDetail alloc] initWithNibName:@"ImageDetail" bundle:nil];
	}

	
	//[thefullshowimages addObject:[NSString stringWithFormat:@"http://www.deautos.com/images/fotos0KM/%@_%dg.jpg",[theobj objectForKey:@"clsAviso0km_Fotos_id"],i+1]];

	
	theimagedet.string_web =self.theurlimagetosee;
	theimagedet.arrayimagenames = thefullshowimages;
	[self.navigationController pushViewController:theimagedet animated:YES];
	[theimagedet go];
	
	
}





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
	[theact stopAnimating];
	displayimage.alpha=0;
	thebut.alpha=0;

	
	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
	[theact stopAnimating];
	displayimage.alpha=1;
	thebut.alpha=1;

	displayimage.image=[UIImage imageWithData:receivedData];
    self.receivedData = nil;
	
    [queryConnection release];
	queryConnection = nil;
}






@end

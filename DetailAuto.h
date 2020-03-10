//
//  DetailAuto.h
//  deAutos
//
//  Created by Moises Swiczar on 11/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contactar.h"
#import "ImageDetail.h"
#import "SimpleWebView.h"
#import "MoreDetail.h"
#import "NBanner.h" 

@interface DetailAuto : UIViewController {
	IBOutlet UIScrollView * thescroll;
	IBOutlet UIImageView *displayimage;
	IBOutlet UILabel * label_titulo;
	
	IBOutlet UILabel * label_ano;
	IBOutlet UILabel * label_combistible;
	IBOutlet UILabel * label_precio;
	IBOutlet UILabel * label_kms;
	IBOutlet UILabel * label_version;
	IBOutlet UILabel * label_segmento;
	IBOutlet UILabel * label_color;
	IBOutlet UILabel * label_comentarios;

	IBOutlet UILabel * label_formadepago;
	IBOutlet UILabel * label_localidad;
	IBOutlet UILabel * label_equipamiento;
	
	
	IBOutlet UIImageView *theimagebanner;
	NSMutableDictionary * theobj;
	Contactar* thecontactar;
	ImageDetail* theimagedet;
	SimpleWebView *theweb;
	IBOutlet UIActivityIndicatorView * theact;
	NSTimer	                *atimergetdata;
	IBOutlet UIButton * thebut;
	NSString * theurlimagetosee;
	MoreDetail* themoredetail;
	IBOutlet UIButton * themore;
	NSMutableArray * thearrayImages;
	IBOutlet UIButton * showall;
	
	NSMutableArray * thefullshowimages;
	NSTimer *atimergetdataBanner;
	
	NSURLConnection *queryConnection;
	NSMutableData *receivedData;
	NBanner *thebanner1;
	IBOutlet UIButton *butoncontactar;
	BOOL needreload;
	NSInteger qimages;
	IBOutlet UIActivityIndicatorView *thebanneract;	
	IBOutlet UIImageView *themorearrow;
	
	IBOutlet UIButton * BEqui;
	IBOutlet UILabel * BEqui2;
	IBOutlet UILabel *labelVendido;
	
	
}

@property (nonatomic,retain) NSMutableData *receivedData;

-(IBAction) clickshowall:(id)aobj;

-(IBAction) clickbanner:(id)aobj;
-(IBAction) clickContactar:(id)aobj;
-(IBAction) clickImage:(id)aobj;

-(IBAction) clickMoreDetail:(id)aobj;
- (void)loadScrollViewWithPage:(int)page;


-(void) show;
-(void) changenow;

@property (nonatomic,assign) NSMutableDictionary * theobj;
@property (nonatomic,copy) NSString * theurlimagetosee;

@end

//
//  Contactar.h
//  deAutos
//
//  Created by Moises Swiczar on 11/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MensajeEnviado.h"
#import "SimpleWebView.h"
#import "NBanner.h"


@interface Contactar : UIViewController {
	IBOutlet UITextField *TextApellido;
	IBOutlet UITextField *TextTel;
	IBOutlet UITextField *TextEmail;
	IBOutlet UITextField *TextContacto;
	IBOutlet UITextField *TextComentarios;
	IBOutlet UITextField *TextCaptcha;
	
	IBOutlet UIImageView *imageBanner;
	IBOutlet UIImageView *imageCaptcha;
	IBOutlet UIActivityIndicatorView * theact;
	MensajeEnviado* themensajeenviadosc;
	SimpleWebView *theweb;

	NSMutableDictionary * thesaveitems;
	NSMutableDictionary * theaviso;
	IBOutlet UIView *themove;
	NSTimer *atimergetdata;
	NBanner *thebanner1;
	NSString * stringsessioncookie;
	NSString * imagebannerstr;
	

	
}

@property(nonatomic,assign) NSMutableDictionary * theaviso;
@property(nonatomic, copy)  NSString * stringsessioncookie;
@property(nonatomic, copy) NSString * imagebannerstr;


-(IBAction) clickBanner:(id)aobj;
-(IBAction) clickContactar:(id)aobj;
-(void) doneediting:(id) aobj;
-(IBAction) clickrefreshcaptcha:(id)aobj;



@end



//
//  MensajeEnviado.h
//  deAutos
//
//  Created by Moises Swiczar on 11/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleWebView.h"
#import "NBanner.h"


@interface MensajeEnviado : UIViewController {
	SimpleWebView *theweb;
	NBanner* thebanner1;
	IBOutlet UIImageView* thebanner;
}

-(IBAction) clickBanner:(id)aob;

-(IBAction) clickVolverBusqueda:(id)aob;
-(IBAction) clickVolverInicio:(id)aob;
-(IBAction) clickAnunciosSimilares:(id)aob;

@end

//
//  Contactar.m
//  deAutos
//
//  Created by Moises Swiczar on 11/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Contactar.h"
#import "WSCall.h"
#import "deAutosAppDelegate.h"




@implementation Contactar

@synthesize theaviso;
@synthesize stringsessioncookie;
@synthesize imagebannerstr;

-(void) Persist
{
	
	
	if((![TextApellido.text isEqualToString:@""]) && (TextApellido.text !=nil))
	{
		[thesaveitems setObject:TextApellido.text forKey:@"TextApellido"];
	}
	
	if((![TextTel.text isEqualToString:@""]) && (TextTel.text !=nil))
	{
		[thesaveitems setObject:TextTel.text forKey:@"TextTel"];
	}
	
	if((![TextEmail.text isEqualToString:@""]) && (TextEmail.text !=nil))
	{
		[thesaveitems setObject:TextEmail.text forKey:@"TextEmail"];
	}
	
	if((![TextContacto.text isEqualToString:@""]) && (TextContacto.text !=nil))
	{
		[thesaveitems setObject:TextContacto.text forKey:@"TextContacto"];
	}
		
	if((![TextComentarios.text isEqualToString:@""]) && (TextComentarios.text !=nil))
	{
		[thesaveitems setObject:TextComentarios.text forKey:@"TextComentarios"];
	}
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"data.txt"];
	NSLog(writableDBPath);
	[thesaveitems writeToFile:writableDBPath atomically:YES];
	
}

-(void) InitPersist
{
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"data.txt"];
	success = [fileManager fileExistsAtPath:writableDBPath];
	if (success) 
	{
		thesaveitems = [[NSMutableDictionary alloc] initWithContentsOfFile:writableDBPath];
		
	}
	else
	{
		thesaveitems = [[NSMutableDictionary alloc] initWithCapacity:1];
	}
	

}





 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		themensajeenviadosc=nil;
		theweb=nil;
		self.title =@"Deautos.com";
		[self InitPersist];
		thebanner1 = [[NBanner alloc]init];

		


		
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
	
	if([thesaveitems objectForKey:@"TextApellido"]!=nil)
	{
		TextApellido.text =[thesaveitems objectForKey:@"TextApellido"];
	}
	else
	{
		TextApellido.text =@"";
	}
	
	if([thesaveitems objectForKey:@"TextTel"]!=nil)
	{
		TextTel.text =[thesaveitems objectForKey:@"TextTel"];
	}
	else
	{
		TextTel.text =@"";
	}

	
	if([thesaveitems objectForKey:@"TextEmail"]!=nil)
	{
		TextEmail.text =[thesaveitems objectForKey:@"TextEmail"];
	}
	else
	{
		TextEmail.text =@"";
	}

	if([thesaveitems objectForKey:@"TextContacto"]!=nil)
	{
		TextContacto.text =[thesaveitems objectForKey:@"TextContacto"];
	}
	else
	{
		TextContacto.text =@"";
	}

	if([thesaveitems objectForKey:@"TextComentarios"]!=nil)
	{
		TextComentarios.text =[thesaveitems objectForKey:@"TextComentarios"];
	}
	else
	{
		TextComentarios.text =@"";
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
	if(themensajeenviadosc!=nil)
	{
		[themensajeenviadosc release];
		themensajeenviadosc=nil;

	}

	if(theweb!=nil)
	{
		[theweb release];
		theweb=nil;

	}
	
	
	 
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	if(themensajeenviadosc!=nil)
	{
		[themensajeenviadosc release];
		themensajeenviadosc=nil;

	}
	
	if(theweb!=nil)
	{
		[theweb release];
		theweb=nil;
	}
	
}


- (void)viewWillAppear:(BOOL)animated
{
	TextCaptcha.text =@"";
	imageCaptcha.alpha=0;
	[theact startAnimating];
	atimergetdata = [NSTimer scheduledTimerWithTimeInterval:	1		// seconds
													 target:		self
												   selector:	@selector (loaddata:)
												   userInfo:	self		// makes the currently-active audio queue (record or playback) available to the updateBargraph method
													repeats:	NO];
}



-(IBAction) clickBanner:(id)aobj
{
	if(theweb==nil)
	{
		theweb = [[SimpleWebView alloc] initWithNibName:@"SimpleWebView" bundle:nil];
	}
	theweb.string_web =thebanner1.UrlClick;

	[self.navigationController pushViewController:theweb animated:YES];
	[theweb go];
	[self doneediting:self];

}

-(IBAction) clickContactar:(id)aobj
{
	[self doneediting:self];
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];

	
	[self Persist];
	if(([TextCaptcha.text isEqualToString:@""]) || (TextCaptcha.text ==nil))
	{
		UIAlertView * thealer = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"Favor de ingresar el numero de confirmación. (captcha)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[thealer  show];
		[thealer release];
		
		return;
	
	}

	
	if((![TextApellido.text isEqualToString:@""]) && (TextApellido.text !=nil))
	{
		if((![TextTel.text isEqualToString:@""]) && (TextTel.text !=nil))
		{
			if((![TextEmail.text isEqualToString:@""]) && (TextEmail.text !=nil))
			{
				
					if(appDelegate.is_nuevo)
					{		
						[thesaveitems setObject:[theaviso objectForKey:@"clsAviso0km_id"] forKey:@"aviso_id"];
					}
					else
					{
						[thesaveitems setObject:[theaviso objectForKey:@"clsAvisoUsado_id"] forKey:@"aviso_id"];
					}
				
				[thesaveitems setObject:TextCaptcha.text forKey:@"captcha"];
	
				deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
				NSString * theer;
				
				
				
				[appDelegate updateStatus];
				if (appDelegate.internetConnectionStatus==NotReachable)
				{
//					[self workOnBackground:NO];
					[appDelegate  shownotreacheable];
					return;
				}
				
				BOOL resultado =[WSCall getContactarAviso:@"" diccionario:thesaveitems nuevos:appDelegate.is_nuevo idcookie:self.stringsessioncookie ares:&theer ];

				
				
				if (resultado)
				{
					if(themensajeenviadosc==nil)
					{
						themensajeenviadosc = [[MensajeEnviado alloc] initWithNibName:@"MensajeEnviado" bundle:nil];
					}
					[self.navigationController pushViewController:themensajeenviadosc animated:YES];
				}
				else
				{
					UIAlertView * thealer = [[UIAlertView alloc] initWithTitle:@"Error" message:theer delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
					[thealer  show];
					[thealer release];
					TextCaptcha.text =@"";
					imageCaptcha.alpha=0;
					[theact startAnimating];
					atimergetdata = [NSTimer scheduledTimerWithTimeInterval:	1		// seconds
														 target:		self
													   selector:	@selector (loaddata:)
													   userInfo:	self		// makes the currently-active audio queue (record or playback) available to the updateBargraph method
														repeats:	NO];
		
				}
				return;
			}
	
		}
	}
	UIAlertView * thealer = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"Favor de ingresar todos lo campos." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[thealer  show];
	[thealer release];
	
}






- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField       
{
	if (TextCaptcha!=textField)
	{
		CGRect arect = textField.frame;
		if ((arect.origin.y > 100) && (arect.origin.y < 320))
		{
			CGRect arectFrame = self.view.frame;
			arectFrame.origin.y = -arect.origin.y+70;
			
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.75];
			self.view.frame = arectFrame;
			[UIView commitAnimations];
		}
	}
	else
	{
		CGRect arectFrame = self.view.frame;
		arectFrame.origin.y = -200;
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.75];
		self.view.frame = arectFrame;
		[UIView commitAnimations];
		
	
	}

	
	
	
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField       

{
	CGRect arectFrame = self.view.frame;
	arectFrame.origin.y=0;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.35];
	self.view.frame = arectFrame;
	[UIView commitAnimations];
	
	[textField endEditing:TRUE];
	return YES;
	
}

-(void) doneediting:(id) aobj
{
	[TextApellido endEditing:TRUE];
	[TextTel endEditing:TRUE];
	[TextEmail endEditing:TRUE];
	[TextContacto endEditing:TRUE];
	[TextComentarios endEditing:TRUE];
	[TextCaptcha endEditing:TRUE];

	CGRect arectFrame = self.view.frame;
	arectFrame.origin.y=0;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.35];
	self.view.frame = arectFrame;
	[UIView commitAnimations];
	
	
	
}



-(void) loaddata:(id)aobj
{
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate trackpage:@"/contactar"];
	
	
	
	[WSCall getBannerforPosicion:2 is_nuevo:appDelegate.is_nuevo thebanner:thebanner1];
	
	
		NSURL *url = [NSURL URLWithString:thebanner1.UrlImage];
		imageBanner.image = [[UIImage imageWithData: [NSData dataWithContentsOfURL:url]] retain];
	
	
//ASP.NET_SessionId=11mwua55uocfiajjuo2y4b3q
	NSString * aux=@"";
	NSString * aux2=@"";
	
	if ([WSCall getCaptcha:&aux imagename:&aux2])
	{
		self.stringsessioncookie =aux;
		self.imagebannerstr=aux2;
//	imageCaptcha.image = [UIImage imageWithData: [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:URL_CAPTCHA]]];
		imageCaptcha.image = [UIImage imageWithContentsOfFile:self.imagebannerstr];

	}
	[theact stopAnimating];
	imageCaptcha.alpha=2;

}



-(IBAction) clickrefreshcaptcha:(id)aobj
{
	imageCaptcha.alpha=0;
	[theact startAnimating];
	atimergetdata = [NSTimer scheduledTimerWithTimeInterval:	1		// seconds
													 target:		self
												   selector:	@selector (loaddata:)
												   userInfo:	self		// makes the currently-active audio queue (record or playback) available to the updateBargraph method
													repeats:	NO];
	
}







@end

//
//  ListResultScreen.m
//  deAutos
//
//  Created by Moises Swiczar on 11/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import "ListResultScreen.h"
#import "deAutosAppDelegate.h"
#import "Cellinfo.h"
#import "WSCall.h"
#import "CellMore.h"

@implementation ListResultScreen


-(void)workOnBackground:(BOOL)background
{
	self.view.userInteractionEnabled = !background;
	if (background)
	{
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		backAlert.transform = CGAffineTransformTranslate( backAlert.transform, 0.0, -50.0 );

		[backAlert show];
		[progressInd startAnimating];
		
	}
	else
	{
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		[progressInd stopAnimating];
		[backAlert dismissWithClickedButtonIndex:0 animated:YES];
	}
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		thebanner1 = [[NBanner alloc]init];
		thearray = 	[[NSMutableArray alloc]init] ;
		sorttype=0;
		theautodetail=nil;
		theweb=nil;
		self.title =@"Deautos.com";
		
		progressInd = [[UIActivityIndicatorView alloc] init];
		progressInd.hidesWhenStopped = YES;
		progressInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
		[progressInd sizeToFit];
		progressInd.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
										UIViewAutoresizingFlexibleRightMargin |
										UIViewAutoresizingFlexibleTopMargin |
										UIViewAutoresizingFlexibleBottomMargin);

		backAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"", @"")
											   message:NSLocalizedString(@"Buscando avisos...\nPor favor aguarde.", @"") 
											  delegate:nil 
									 cancelButtonTitle:nil
									 otherButtonTitles:nil];
		progressInd.center = CGPointMake(backAlert.frame.size.width / 2.0, -5.0);

		[backAlert addSubview:progressInd];
		image1 = [UIImage  imageNamed:@"right.png"];
		thesort=@"precioabs";
		asc_desc=@"Asc";
		intorden=1;

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
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	appDelegate.acontrollersearch = self;
	
	UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn addTarget:self action:@selector(clikoninfobar:) forControlEvents:UIControlEventTouchUpInside];
	btn.frame = CGRectMake(0, 0, 50, 20);
	[btn setImage:[UIImage imageNamed:@"Back Inactivo.png"] forState:UIControlStateNormal];
	UIBarButtonItem * theinfobutton = [[UIBarButtonItem alloc] initWithCustomView:btn];
	self.navigationItem.hidesBackButton=YES;
	
	self.navigationItem.leftBarButtonItem = theinfobutton;
	IVprecio.image = [UIImage imageNamed:@"precio negro2.png"];;

}

- (void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBarHidden=NO;
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate trackpage:@"/resultadoBusqueda"];

	

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
	[thearray release];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    
	if (theautodetail!=nil)
	{
		[theautodetail release];
	}

	if (theweb!=nil)
	{
		[theweb release];
	}

	if (progressInd!=nil)
	{
		[progressInd release];
	}

	if (backAlert!=nil)
	{
		[backAlert release];
	}

	if (image1!=nil)
	{
		[image1 release];
	}
	
	[super dealloc];
	
	
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if([thearray count]==[indexPath row])
	{	
		return 55;
	}
	else
	{
		return 70;
	
	}
}

// This table will always only have one section.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv
{
    return 1;
}

// One row per book, the number of books is the number of rows.
- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section 
{
	if([thearray count]==0)
	{
		return 0;
	}
	else
	{
		if(([thearray count] % 10)==0  )
		{
			return	[thearray count]+1;
		}
		else
		{
			return	[thearray count];
		}
	}
	return 0;
}


- (UITableViewCell *)obtainTableCellForRow:(NSInteger)row
{
	UITableViewCell *cell = nil;
	cell = [thetable dequeueReusableCellWithIdentifier:@"Cellinfo"];
	if (cell == nil)
	{
		cell = [[[Cellinfo alloc] initWithFrame:CGRectZero reuseIdentifier:@"Cellinfo"] autorelease];
	}
	return cell;
}

- (UITableViewCell *)obtainTableCellForRowMore:(NSInteger)row
{
	UITableViewCell *cell = nil;
	cell = [thetable dequeueReusableCellWithIdentifier:@"CellMore"];
	if (cell == nil)
	{
		cell = [[[CellMore alloc] initWithFrame:CGRectZero reuseIdentifier:@"CellMore"] autorelease];
	}
	thecell= cell;
	return cell;
}




- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	UITableViewCell *cell;
	NSInteger row = [indexPath row];
	
	if(row == [thearray count])
	{
		cell = [self obtainTableCellForRowMore:row];
		cell.accessoryView =nil;
		cell.selectionStyle = 	UITableViewCellSelectionStyleGray;

	}
	else
	{
		cell = [self obtainTableCellForRow:row];
		NSMutableDictionary *thestore = [thearray objectAtIndex: row];
		((Cellinfo *)cell).thedict = thestore;
		[(Cellinfo *)cell showData];
		cell.selectionStyle = 	UITableViewCellSelectionStyleGray;
		CGRect arect ;
		arect.origin.x=0;
		arect.origin.y=0;
		arect.size.height = image1.size.height;
		arect.size.width = image1.size.width;
		
		UIImageView* acc = [[UIImageView alloc] initWithFrame:arect];
		acc.image = image1;
		cell.accessoryView =acc;
		[acc release];
	
	}
	
			

	
	return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	if(indexPath.row!=[thearray count])
	{
		if(theautodetail==nil)
		{
			theautodetail = [[DetailAuto alloc] initWithNibName:@"DetailAuto" bundle:nil];
		}
		theautodetail.theobj = [thearray objectAtIndex: indexPath.row];

		[self.navigationController pushViewController:theautodetail animated:YES];
		[theautodetail show];
	}
	else
	{
		[(CellMore*)thecell start];
		[self showmoredata];
	}
	[tv deselectRowAtIndexPath:indexPath	animated:YES];
	return indexPath;
}


-(IBAction) clickbanner:(id)aobj
{
	if(theweb==nil)
	{
		theweb = [[SimpleWebView alloc] initWithNibName:@"SimpleWebView" bundle:nil];
	}
	
	theweb.string_web =thebanner1.UrlClick;
	[self.navigationController pushViewController:theweb animated:YES];
	[theweb go];
}

-(IBAction) clickSortPrecio:(id)aobj
{
	if((intorden==1) || (intorden==2))
	{
		if(intorden==1)
		{
			intorden=2;
			asc_desc=@"Desc";
			
			IVprecio.image = [UIImage imageNamed:@"precio negro1.png"];;
			IVano.image = [UIImage imageNamed:@"ano blanco.png"];
			IVkm.image = [UIImage imageNamed:@"km blanco.png"];;
			
		}
		else
		{
			IVprecio.image = [UIImage imageNamed:@"precio negro2.png"];;
			IVano.image = [UIImage imageNamed:@"ano blanco.png"];
			IVkm.image = [UIImage imageNamed:@"km blanco.png"];;
			
			intorden=1;
			asc_desc=@"Asc";
		}
	}
	else
	{
		IVprecio.image = [UIImage imageNamed:@"precio negro2.png"];;
		IVano.image = [UIImage imageNamed:@"ano blanco.png"];
		IVkm.image = [UIImage imageNamed:@"km blanco.png"];;
		
		intorden=1;
		asc_desc=@"Asc";
	}
	thesort=@"precioabs";
	[self dofill];
}

-(IBAction) clickSortAnio:(id)aobj
{
	
	
	if((intorden==3) || (intorden==4))
	{
		if(intorden==3)
		{
			intorden=4;
			asc_desc=@"Desc";
			IVprecio.image = [UIImage imageNamed:@"precio blanco.png"];;
			IVano.image = [UIImage imageNamed:@"ano negro1.png"];
			IVkm.image = [UIImage imageNamed:@"km blanco.png"];;
			
		}
		else
		{
			intorden=3;
			IVprecio.image = [UIImage imageNamed:@"precio blanco.png"];;
			IVano.image = [UIImage imageNamed:@"ano negro2.png"];
			IVkm.image = [UIImage imageNamed:@"km blanco.png"];;
			
			asc_desc=@"Asc";
		}
	}
	else
	{
		IVprecio.image = [UIImage imageNamed:@"precio blanco.png"];;
		IVano.image = [UIImage imageNamed:@"ano negro2.png"];
		IVkm.image = [UIImage imageNamed:@"km blanco.png"];;
		
		intorden=3;
		asc_desc=@"Asc";
	}
	thesort=@"anio";

	[self dofill];
}


-(IBAction) clickSortKm:(id)aobj
{
	if((intorden==5) || (intorden==6))
	{
		if(intorden==5)
		{
			IVprecio.image = [UIImage imageNamed:@"precio blanco.png"];;
			IVano.image = [UIImage imageNamed:@"ano blanco.png"];
			IVkm.image = [UIImage imageNamed:@"km negro1.png"];;
			
			intorden=6;
			asc_desc=@"Desc";
		}
		else
		{
			IVprecio.image = [UIImage imageNamed:@"precio blanco.png"];;
			IVano.image = [UIImage imageNamed:@"ano blanco.png"];
			IVkm.image = [UIImage imageNamed:@"km negro2.png"];;
			
			intorden=5;
			asc_desc=@"Asc";
		}
	}
	else
	{
		IVprecio.image = [UIImage imageNamed:@"precio blanco.png"];;
		IVano.image = [UIImage imageNamed:@"ano blanco.png"];
		IVkm.image = [UIImage imageNamed:@"km negro2.png"];;
		
		intorden=5;
		asc_desc=@"Asc";
	}
	
	thesort=@"km";
	[self dofill];
}


-(void) loaddata:(id)aobj
{
	
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[appDelegate updateStatus];
	if (appDelegate.internetConnectionStatus==NotReachable)
	{
		[self workOnBackground:NO];
		[appDelegate  shownotreacheable];
//		[self.navigationController popViewControllerAnimated:YES];
		return;
	}
	
	
	
	[WSCall getBannerforPosicion:0 is_nuevo:appDelegate.is_nuevo thebanner:thebanner1];

	
	NSURL *url = [NSURL URLWithString:thebanner1.UrlImage];
	thebanner.image = [[UIImage imageWithData: [NSData dataWithContentsOfURL:url]] retain];

					   
					   
	NSMutableDictionary *adict = [[NSMutableDictionary alloc]init];
	avisosporpag=10;
	paginanro=1;
	[adict setObject:asc_desc forKey:@"AD"];
	[adict setObject:[NSString stringWithFormat:@"%d",avisosporpag] forKey:@"AvisosxPag"];
	[adict setObject:[NSString stringWithFormat:@"%d",paginanro] forKey:@"NroPag"];
	[adict setObject:thesort forKey:@"OrderField"];
	
	
	if([appDelegate.dMarca objectForKey:@"clsMarca_Id"]!=nil)
	{
		[adict setObject:[appDelegate.dMarca objectForKey:@"clsMarca_Id"] forKey:@"Marca"];
		
	}
	
	if([appDelegate.dModelo objectForKey:@"clsModelo_Id"]!=nil)
	{
		[adict setObject:[appDelegate.dModelo objectForKey:@"clsModelo_Id"] forKey:@"Modelo"];
	}
	if([appDelegate.dProvincia objectForKey:@"clsProvincia_Id"]!=nil)
	{
		[adict setObject:[appDelegate.dProvincia objectForKey:@"clsProvincia_Id"] forKey:@"Provincia"];
	}
	
	if([appDelegate.dLocalidad objectForKey:@"clsZona_Id"]!=nil)
	{
		[adict setObject:[appDelegate.dLocalidad objectForKey:@"clsZona_Id"] forKey:@"Localidad"];
	}
	if([appDelegate.dCombustible objectForKey:@"Id"]!=nil)
	{
		[adict setObject:[appDelegate.dCombustible objectForKey:@"Id"] forKey:@"Combustible"];
	}

	
	if(appDelegate.desdeano!=nil)
	{
		[adict setObject:appDelegate.desdeano  forKey:@"ANOD"];
	}

	if(appDelegate.hastaano!=nil)
	{
		[adict setObject:appDelegate.hastaano  forKey:@"ANOH"];
	}
	
	
 	[WSCall getAvisos:thearray diccionario:adict nuevos:appDelegate.is_nuevo];
	[thetable reloadData];
	[self workOnBackground:NO];
	[adict removeAllObjects];
	[adict release];
	
	if([thearray count]==0)
	{
		
		UIAlertView *thealert = [[UIAlertView alloc] initWithTitle:@"Deautos.com" message:@"No se encontraron resultados para la búsqueda actual." delegate:self cancelButtonTitle:@" Realizar nueva búsqueda" otherButtonTitles:nil];
		[thealert show];
		[thealert release];
		
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	[self.navigationController popViewControllerAnimated:YES];
}


-(void) showalldata
{
	[thearray removeAllObjects];
	[thetable reloadData];
	[self workOnBackground:YES];
	atimergetdata = [NSTimer scheduledTimerWithTimeInterval: 0.1
													 target: self
												   selector: @selector (loaddata:)
												   userInfo: self
													repeats: NO];
};


-(void) loadMoredata:(id)aobj
{
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[appDelegate updateStatus];
	if (appDelegate.internetConnectionStatus==NotReachable)
	{
		//					[self workOnBackground:NO];
		[appDelegate  shownotreacheable];
		return;
	}
	
	
	NSMutableDictionary *adict = [[NSMutableDictionary alloc]init];
	avisosporpag=10;
	paginanro++;
	[adict setObject:asc_desc forKey:@"AD"];
	[adict setObject:[NSString stringWithFormat:@"%d",avisosporpag] forKey:@"AvisosxPag"];
	[adict setObject:[NSString stringWithFormat:@"%d",paginanro] forKey:@"NroPag"];
	[adict setObject:thesort forKey:@"OrderField"];
	
	
	if([appDelegate.dMarca objectForKey:@"clsMarca_Id"]!=nil)
	{
		[adict setObject:[appDelegate.dMarca objectForKey:@"clsMarca_Id"] forKey:@"Marca"];
		
	}
	
	if([appDelegate.dModelo objectForKey:@"clsModelo_Id"]!=nil)
	{
		[adict setObject:[appDelegate.dModelo objectForKey:@"clsModelo_Id"] forKey:@"Modelo"];
	}
	if([appDelegate.dProvincia objectForKey:@"clsProvincia_Id"]!=nil)
	{
		[adict setObject:[appDelegate.dProvincia objectForKey:@"clsProvincia_Id"] forKey:@"Provincia"];
	}
	
	if([appDelegate.dLocalidad objectForKey:@"clsZona_Id"]!=nil)
	{
		[adict setObject:[appDelegate.dLocalidad objectForKey:@"clsZona_Id"] forKey:@"Localidad"];
	}
	if([appDelegate.dCombustible objectForKey:@"Id"]!=nil)
	{
		[adict setObject:[appDelegate.dCombustible objectForKey:@"Id"] forKey:@"Combustible"];
	}
	
	if(appDelegate.desdeano !=nil)
	{
		[adict setObject:appDelegate.desdeano forKey:@"ANOD"]; ;
	}
	if(appDelegate.hastaano !=nil)
	{
		[adict setObject:appDelegate.hastaano forKey:@"ANOH"];;
	}
	
	
	
 	[WSCall getAvisos:thearray diccionario:adict nuevos:appDelegate.is_nuevo];
	[thetable reloadData];
	[adict removeAllObjects];
	[adict release];
	self.view.userInteractionEnabled = YES;
	[(CellMore*)thecell stop];
}




-(void)showmoredata
{
	self.view.userInteractionEnabled = NO;
	atimergetdata = [NSTimer scheduledTimerWithTimeInterval: 0.1
													 target: self
												   selector: @selector (loadMoredata:)
												   userInfo: self
													repeats: NO];
	
}


-(void) dofill
{
	[self showalldata];
	
}



@end

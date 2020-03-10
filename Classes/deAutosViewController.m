//
//  deAutosViewController.m
//  deAutos
//
//  Created by Moises Swiczar on 10/1/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "deAutosViewController.h"
#import "deAutosAppDelegate.h"
#import "WSCall.h"
@implementation deAutosViewController



// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		
		deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
		appDelegate.is_nuevo=YES;
		myresult=nil;
		achoose=nil;
		image1 = [UIImage  imageNamed:@"right.png"];
		


    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBarHidden=YES;
	[tablesearch reloadData];
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	if(!appDelegate.is_nuevo)
	{
		imagenuevo.image = [UIImage imageNamed:@"Nuevos Inactivo.png"] ;
		imageusado.image = [UIImage imageNamed:@"Usados Activo.png"] ;
	}
	else
	{
		imagenuevo.image =[UIImage imageNamed:@"Nuevos Activo.png"] ;
		imageusado.image =[UIImage imageNamed:@"Usados Inactivo.png"]  ;

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
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}



-(IBAction) clicknuevo:(id)aobj
{
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	if(!appDelegate.is_nuevo)
	{
		appDelegate.is_nuevo=YES;
		imagenuevo.image =[UIImage imageNamed:@"Nuevos Activo.png"] ;
		imageusado.image =[UIImage imageNamed:@"Usados Inactivo.png"]  ;
	}
}

-(IBAction) clickusado:(id)aobj
{
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	if(appDelegate.is_nuevo)
	{
		appDelegate.is_nuevo=NO;
		imagenuevo.image = [UIImage imageNamed:@"Nuevos Inactivo.png"] ;
		imageusado.image = [UIImage imageNamed:@"Usados Activo.png"] ;
	}
}


-(IBAction) clickbuscar:(id)aobj
{
	
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[appDelegate updateStatus];
	if (appDelegate.internetConnectionStatus==NotReachable)
	{
		[appDelegate  shownotreacheable];
		return;
	}
	
	
	if(myresult==nil)
	{
		myresult = [[ListResultScreen alloc] initWithNibName:@"ListResultScreen" bundle:nil];
	}
	
	[self.navigationController pushViewController:myresult animated:YES];
	[myresult dofill];

}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 70;
}

// This table will always only have one section.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv
{
    return 1;
}

// One row per book, the number of books is the number of rows.
- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section 
{
	return 7;
}


- (UITableViewCell *)obtainTableCellForRow:(NSInteger)row
{
	UITableViewCell *cell = nil;
	cell = [tablesearch dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"UITableViewCell"] autorelease];
		CGRect arect ;
		arect.origin.x=0;
		arect.origin.y=0;
		arect.size.height = image1.size.height;
		arect.size.width = image1.size.width;
		
		
	//	cell.textLabel.font =[UIFont systemFontOfSize:10];
	}
	return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];

	NSInteger row = [indexPath row];
	UITableViewCell *cell = [self obtainTableCellForRow:row];
	CGRect arect ;
	UIImageView* acc;
	switch (row) {
		case 0:
			if(appDelegate.dMarca==nil)
			{
				cell.textLabel.text =@"Marca";
				arect.origin.x=0;
				arect.origin.y=0;
				arect.size.height = image1.size.height;
				arect.size.width = image1.size.width;
				
				acc = [[UIImageView alloc] initWithFrame:arect];
				acc.image = image1;
				cell.accessoryView =acc;
				[acc release];
			}
			else
			{
				cell.textLabel.text = [appDelegate.dMarca objectForKey:@"clsMarca_Nombre"];
			
			}
			cell.selectionStyle = 	UITableViewCellSelectionStyleGray;
			cell.textLabel.textColor = [UIColor orangeColor];
			break;
			
		case 1:

			if(appDelegate.dMarca==nil)
			{
				cell.accessoryView =nil;
				cell.selectionStyle = 	UITableViewCellSelectionStyleNone;
			}
			else
			{
				cell.selectionStyle = 	UITableViewCellSelectionStyleGray;
				arect.origin.x=0;
				arect.origin.y=0;
				arect.size.height = image1.size.height;
				arect.size.width = image1.size.width;
				
				UIImageView* acc = [[UIImageView alloc] initWithFrame:arect];
				acc.image = image1;
				cell.accessoryView =acc;
				[acc release];
			}
			if(appDelegate.dModelo==nil)
			{
				cell.textLabel.text =@"Modelo";

			}
			else
			{
				cell.textLabel.text = [appDelegate.dModelo objectForKey:@"clsModelo_Nombre"];

			}
			cell.textLabel.textColor = [UIColor grayColor];
			break;
		case 2:

			if(appDelegate.dProvincia==nil)
			{
				cell.textLabel.text =@"Provincia";
			}
			else
			{
				cell.textLabel.text = [appDelegate.dProvincia objectForKey:@"clsProvincia_Nombre"];

			}
			arect.origin.x=0;
			arect.origin.y=0;
			arect.size.height = image1.size.height;
			arect.size.width = image1.size.width;
			
			acc = [[UIImageView alloc] initWithFrame:arect];
			acc.image = image1;
			cell.accessoryView =acc;
			[acc release];
			
			cell.selectionStyle = 	UITableViewCellSelectionStyleGray;
			cell.textLabel.textColor = [UIColor orangeColor];
			break;
		case 3:
			
			if(appDelegate.dProvincia==nil)
			{
				cell.accessoryView =nil;
				cell.selectionStyle = 	UITableViewCellSelectionStyleNone;

			}
			else
			{
				arect.origin.x=0;
				arect.origin.y=0;
				arect.size.height = image1.size.height;
				arect.size.width = image1.size.width;
				
				acc = [[UIImageView alloc] initWithFrame:arect];
				acc.image = image1;
				cell.accessoryView =acc;
				[acc release];
				cell.selectionStyle = 	UITableViewCellSelectionStyleGray;

			}
			
			if(appDelegate.dLocalidad==nil)
			{
				cell.textLabel.text =@"Localidad";

			}
			else
			{
				cell.textLabel.text = [appDelegate.dLocalidad objectForKey:@"clsZona_Nombre"];
			}
			cell.textLabel.textColor = [UIColor grayColor];
			break;
		case 4:
			if(appDelegate.dCombustible==nil)
			{
				cell.textLabel.text =@"Combustible";
			}
			else
			{
				cell.textLabel.text = [appDelegate.dCombustible objectForKey:@"Nombre"];
			}
			cell.textLabel.textColor = [UIColor orangeColor];
			cell.selectionStyle = 	UITableViewCellSelectionStyleGray;
			arect.origin.x=0;
			arect.origin.y=0;
			arect.size.height = image1.size.height;
			arect.size.width = image1.size.width;
			
			UIImageView* acc = [[UIImageView alloc] initWithFrame:arect];
			acc.image = image1;
			cell.accessoryView =acc;
			[acc release];
			

			break;
			
		case 5:
			if(appDelegate.desdeano==nil)
			{
				cell.textLabel.text =@"Año desde";
			}
			else
			{
				cell.textLabel.text = appDelegate.desdeano;
			}
			cell.textLabel.textColor = [UIColor orangeColor];
			cell.selectionStyle = 	UITableViewCellSelectionStyleGray;
			arect.origin.x=0;
			arect.origin.y=0;
			arect.size.height = image1.size.height;
			arect.size.width = image1.size.width;
			
			acc = [[UIImageView alloc] initWithFrame:arect];
			acc.image = image1;
			cell.accessoryView =acc;
			[acc release];
			break;

		case 6:
			if(appDelegate.hastaano==nil)
			{
				cell.textLabel.text =@"Año hasta";
			}
			else
			{
				cell.textLabel.text = appDelegate.hastaano;
			}
			cell.textLabel.textColor = [UIColor orangeColor];
			cell.selectionStyle = 	UITableViewCellSelectionStyleGray;
			arect.origin.x=0;
			arect.origin.y=0;
			arect.size.height = image1.size.height;
			arect.size.width = image1.size.width;
			
			acc = [[UIImageView alloc] initWithFrame:arect];
			acc.image = image1;
			cell.accessoryView =acc;
			[acc release];
			break;
			
			
			
		default:
			break;
	}
	return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];

	if (achoose==nil)
	{
		achoose =  [[BookMarked alloc] initWithNibName:@"BookMarked" bundle:nil];
	}
	
	NSInteger row = [indexPath row];
	achoose.tipo = row;
	switch (row) {
		case 1:
			if(appDelegate.dMarca!=nil)
			{
				[self.navigationController pushViewController:achoose animated:YES];
				[achoose dofill];
				[tv deselectRowAtIndexPath:indexPath	animated:YES];
				
			}
			break;
		case 3:
			if(appDelegate.dProvincia!=nil)
			{
				[self.navigationController pushViewController:achoose animated:YES];
				[achoose dofill];
				[tv deselectRowAtIndexPath:indexPath	animated:YES];
				
			}
			break;
		default:
			[self.navigationController pushViewController:achoose animated:YES];
			[achoose dofill];
			[tv deselectRowAtIndexPath:indexPath	animated:YES];
	}
	
	
	
	
	return indexPath;
}

/*
- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSInteger row = [indexPath row];
	UStore *thestore = [arrayData objectAtIndex: row];
	[thestore deletefromdb];
	if (editingStyle == UITableViewCellEditingStyleDelete) 
	{
		[thestore deletefromdb];
		[arrayData removeObjectAtIndex:row];
		[mytable reloadData];
	}
}
 */







@end

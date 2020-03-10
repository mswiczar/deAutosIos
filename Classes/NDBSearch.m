//
//  NDBSearch.m
//  Detelefoongids
//
//  Created by Moises Swiczar on 4/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NDBSearch.h"
#import "deAutosAppDelegate.h"

//static sqlite3_stmt * word_statement=nil;
//static sqlite3_stmt * place_statement=nil;

static sqlite3_stmt * marca_statement=nil;
static sqlite3_stmt * prov_statement=nil;
static sqlite3_stmt * modelos_statement=nil;
static sqlite3_stmt * localidad_statement=nil;






@implementation NDBSearch
/*
+(BOOL) fillwithword:(NSString*) aword aarray:(NSMutableArray*)aarray withdb:(sqlite3*)db
{
	NSInteger amounttosend;
	amounttosend=0;
	[aarray removeAllObjects];
	if (word_statement == nil) {
		static char *sql = "select word from words where word like ? order by word";
        if (sqlite3_prepare_v2(db, sql, -1, &word_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(db));
        }
    }
	NSString *theaux = [NSString stringWithFormat:@"%@%@",aword,@"%"];
	sqlite3_bind_text(word_statement, 1 , [theaux UTF8String],-1,SQLITE_STATIC);
	while (sqlite3_step(word_statement) == SQLITE_ROW)
	{
		amounttosend++;
		char * str= (char *)sqlite3_column_text(word_statement, 0);
		NSString *aux = [[NSString alloc]initWithCString:str];

		
		[aarray addObject:aux];
		[aux release];
		if (amounttosend==20)
		{
			break;
		}
	}
	sqlite3_reset(word_statement);
	
	return YES;
}

+(BOOL) fillwithplaces:(NSString*) aplace aarray:(NSMutableArray*)aarray withdb:(sqlite3*)db
{
	NSInteger amounttosend;
	amounttosend=0;
	
	[aarray removeAllObjects];

	if (place_statement == nil) {
		static char *sql = "select descrip from places where descrip like ? order by descrip";
        if (sqlite3_prepare_v2(db, sql, -1, &place_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(db));
        }
    }
	NSString *theaux = [NSString stringWithFormat:@"%@%@",aplace,@"%"];


	sqlite3_bind_text(place_statement, 1 , [theaux UTF8String],-1,SQLITE_STATIC);
	while (sqlite3_step(place_statement) == SQLITE_ROW)
	{
		amounttosend++;

		char * str= (char *)sqlite3_column_text(place_statement, 0);
		NSString *aux = [[NSString alloc]initWithCString:str];
		[aarray addObject:aux];
		[aux release];
		if (amounttosend==20)
		{
			break;
		}
		
	}
	sqlite3_reset(place_statement);
	
	
	return YES;
}
*/


+ (void)finalizeStatements 
{
	
	if (marca_statement) sqlite3_finalize(marca_statement);
	if (prov_statement) sqlite3_finalize(prov_statement);
	if (modelos_statement) sqlite3_finalize(modelos_statement);

	if (localidad_statement) sqlite3_finalize(localidad_statement);
	
  //  if (word_statement) sqlite3_finalize(word_statement);
  //  if (place_statement) sqlite3_finalize(place_statement);
};


+(BOOL) DBgetMarca:(NSMutableArray*)thearray 
{
	
	
	// CREATE TABLE marcas (id integer, desc varchar(128));

	[thearray removeAllObjects];
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	

	if (marca_statement == nil) {
		static char *sql = "select id , desc  from marcas order by 2";
        if (sqlite3_prepare_v2(appDelegate.database, sql, -1, &marca_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(appDelegate.database));
        }
    }
	
	NSMutableDictionary * thedict;
	NSString *aux2;
	NSMutableString *aux;
	while (sqlite3_step(marca_statement) == SQLITE_ROW)
	{
		
		char * str= (char *)sqlite3_column_text(marca_statement, 1);
		aux = [[NSMutableString alloc]initWithCString:str];
		
		[aux replaceOccurrencesOfString:@"\"" withString:@"" options:0 range:NSMakeRange(0, [aux length])];

		
		thedict = [[NSMutableDictionary alloc]init];
		[thedict setObject:aux forKey:@"clsMarca_Nombre"];
		
		aux2 = [NSString stringWithFormat:@"%d",sqlite3_column_int(marca_statement,0)];
		[thedict setObject:aux2 forKey:@"clsMarca_Id"];

		[thearray addObject:thedict];
		[aux release];
		
	}
	sqlite3_reset(marca_statement);
	
	
	return YES;
}
+(BOOL) DBgetModelo:(NSMutableArray*)thearray marca:(NSString*)marca
{
	
	
//	CREATE TABLE modelos (id integer, desc varchar(128) , id_marca integer);

	[thearray removeAllObjects];
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (modelos_statement == nil) {
		static char *sql = "select id , desc  from modelos where id_marca=? order by 2";
        if (sqlite3_prepare_v2(appDelegate.database, sql, -1, &modelos_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(appDelegate.database));
        }
    }
	
	
	
	NSMutableDictionary * thedict;
	NSString *aux2;
	NSMutableString *aux;
	sqlite3_bind_int(modelos_statement,1,[marca intValue]);

	thedict = [[NSMutableDictionary alloc]init];
	[thedict setObject:@"Todos" forKey:@"clsModelo_Nombre"];
	
	[thedict setObject:@"-1" forKey:@"clsModelo_Id"];
	
	[thearray addObject:thedict];
	
	
	
	while (sqlite3_step(modelos_statement) == SQLITE_ROW)
	{
		
		char * str= (char *)sqlite3_column_text(modelos_statement, 1);
		aux = [[NSMutableString alloc]initWithCString:str];
		
		[aux replaceOccurrencesOfString:@"\"" withString:@"" options:0 range:NSMakeRange(0, [aux length])];
		
		thedict = [[NSMutableDictionary alloc]init];
		[thedict setObject:aux forKey:@"clsModelo_Nombre"];
		
		aux2 = [NSString stringWithFormat:@"%d",sqlite3_column_int(modelos_statement,0)];
		[thedict setObject:aux2 forKey:@"clsModelo_Id"];
		
		[thearray addObject:thedict];
		[aux release];
		
	}
	sqlite3_reset(modelos_statement);
	
	return YES;

}

+(BOOL) DBgetProvincia :(NSMutableArray*)thearray
{
//	CREATE TABLE provincias (id integer, pais_id integer, desc varchar(128),orden integer);

	[thearray removeAllObjects];
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	if (prov_statement == nil) {
		static char *sql = "select id , desc from  provincias where pais_id=1 order by 2 ";
        if (sqlite3_prepare_v2(appDelegate.database, sql, -1, &prov_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(appDelegate.database));
        }
    }
	
	NSMutableDictionary * thedict;
	 NSString *aux2;
	NSMutableString *aux;
	
	thedict = [[NSMutableDictionary alloc]init];
	[thedict setObject:@"Todas" forKey:@"clsProvincia_Nombre"];
	
	[thedict setObject:@"-1" forKey:@"clsProvincia_Id"];
	
	[thearray addObject:thedict];
	
	while (sqlite3_step(prov_statement) == SQLITE_ROW)
	{
		
		char * str= (char *)sqlite3_column_text(prov_statement, 1);
		aux = [[NSMutableString alloc]initWithCString:str];
		
		[aux replaceOccurrencesOfString:@"\"" withString:@"" options:0 range:NSMakeRange(0, [aux length])];
		thedict = [[NSMutableDictionary alloc]init];
		[thedict setObject:aux forKey:@"clsProvincia_Nombre"];
		
		aux2 = [NSString stringWithFormat:@"%d",sqlite3_column_int(prov_statement,0)];
		[thedict setObject:aux2 forKey:@"clsProvincia_Id"];
		
		[thearray addObject:thedict];
		[aux release];
		
	}
	sqlite3_reset(prov_statement);
	
	
	return YES;

}

+(BOOL) DBgetLocalidad:(NSMutableArray*)thearray provincia:(NSString*)provincia
{
	// CREATE TABLE localidades (id integer, desc varchar(128) ,id_provincia integer);
	/*
	 
	 15 : <CFDictionary 0xe8c290 [0x30307a00]>{type = mutable, count = 2, capacity = 3, pairs = (
	 2 : <CFString 0xe8c520 [0x30307a00]>{contents = ""} = <CFString 0xe8c4b0 [0x30307a00]>{contents = "SANTA ROSA"}
	 3 : <CFString 0xe8c3e0 [0x30307a00]>{contents = ""} = <CFString 0xe8c3a0 [0x30307a00]>{contents = "537"}
	 */
	[thearray removeAllObjects];
	deAutosAppDelegate *appDelegate = (deAutosAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (localidad_statement == nil) {
		
		static char *sql = " select id ,  nomloc  ||', '|| nomzona  from  localidades where id_prov =?  order by 2 ";
        if (sqlite3_prepare_v2(appDelegate.database, sql, -1, &localidad_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(appDelegate.database));
        }
    }
	
	NSMutableDictionary * thedict;
	NSString *aux2;
	NSString *aux;
	
	thedict = [[NSMutableDictionary alloc]init];
	[thedict setObject:@"Todas" forKey:@"clsZona_Nombre"];
	
	[thedict setObject:@"-1" forKey:@"clsZona_Id"];
	
	[thearray addObject:thedict];
	
	sqlite3_bind_int(localidad_statement,1,[provincia intValue]);
	
	while (sqlite3_step(localidad_statement) == SQLITE_ROW)
	{
		
		char * str= (char *)sqlite3_column_text(localidad_statement, 1);
	
		aux = [[NSString  alloc] initWithUTF8String:str];
		//aux = [[NSMutableString alloc]initWithCString:str ];
		
		//[aux replaceOccurrencesOfString:@"\"" withString:@"" options:0 range:NSMakeRange(0, [aux length])];
		
		thedict = [[NSMutableDictionary alloc]init];
		[thedict setObject:aux forKey:@"clsZona_Nombre"];
		
		aux2 = [NSString stringWithFormat:@"%d",sqlite3_column_int(localidad_statement,0)];
		[thedict setObject:aux2 forKey:@"clsZona_Id"];
		
		[thearray addObject:thedict];
		[aux release];
		
	}
	sqlite3_reset(localidad_statement);
	
	return YES;
	

}
/*
 CREATE TABLE localidades (id integer, desc varchar(128) ,id_provincia integer);
 
 */



@end

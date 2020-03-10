//
//  NDBSearch.h
//  Detelefoongids
//
//  Created by Moises Swiczar on 4/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "/usr/include/sqlite3.h"


@interface NDBSearch : NSObject {

}

//+(BOOL) fillwithword:(NSString*) aword aarray:(NSMutableArray*)aarray withdb:(sqlite3 *)db;
//+(BOOL) fillwithplaces:(NSString*) aplace aarray:(NSMutableArray*)aarray withdb:(sqlite3 *)db;


+(BOOL) DBgetMarca:(NSMutableArray*)thearray;
+(BOOL) DBgetProvincia :(NSMutableArray*)thearray;

+(BOOL) DBgetModelo:(NSMutableArray*)thearray marca:(NSString*)marca;
+(BOOL) DBgetLocalidad:(NSMutableArray*)thearray provincia:(NSString*)provincia;

+ (void)finalizeStatements ;


@end

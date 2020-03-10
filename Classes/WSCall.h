//
//  WSCall.h
//  deAutos
//
//  Created by Moises Swiczar on 11/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#define TIMEOUT 45
#define URL_CAPTCHA @"http://iphonedata.deautos.com/captcha.aspx"
#import <Foundation/Foundation.h>
#import "NBanner.h"

@interface WSCall : NSObject {

}

+(BOOL) getANOD:(NSMutableArray*)thearray;
+(BOOL) getANOH:(NSMutableArray*)thearray desde:(NSInteger) desde;

+(BOOL) getMarca:(NSMutableArray*)thearray;
+(BOOL) getModelo:(NSMutableArray*)thearray marca:(NSString*)marca;
+(BOOL) getProvincia :(NSMutableArray*)thearray;
+(BOOL) getLocalidad:(NSMutableArray*)thearray provincia:(NSString*)provincia;
+(BOOL) getCombustible:(NSMutableArray*)thearray ;



+(BOOL) getAvisos:(NSMutableArray*)thearray diccionario:(NSMutableDictionary*)diccionario nuevos:(BOOL)nuevos;
+(BOOL) getContactarAviso:(NSString*)theid diccionario:(NSMutableDictionary*)diccionario nuevos:(BOOL)nuevos idcookie:(NSString*)idcookie ares:(NSString**) ares;
+(BOOL) getDetailAuto:(NSMutableArray*)thearray theaviso:(NSString*)theaviso nuevos:(BOOL)nuevos;
+(BOOL) getBannerforPosicion:(NSInteger) posicion is_nuevo:(BOOL)is_nuevo  thebanner:(NBanner*)thebanner ;
+(BOOL) getCaptcha:(NSString**)coki imagename:(NSString**)imagename ;

/*
Catalogo de Autos

o	Autos/Marca/Load/?id=
o	Autos/Marca/List/
o	Autos/Modelo/Load/?id=
o	Autos/Modelo/List/?id_Marca=
o	Autos/Load/?id=
o	Autos/List/?id_Modelo=
o	Autos/Segmento/Load/?id=
o	Autos/Segmento/List/

Acceso al callejero

o	Callejero/Provincia/Load/?id=
o	Callejero/Provincia/List/
o	Callejero/Zona/Load/?id=
o	Callejero/Zona/List/?id_provincia=
o	Callejero/Localidad/Load/?id=
o	Callejero/Localidad/List/?id_zona=

*/

@end

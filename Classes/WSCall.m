//
//  WSCall.m
//  deAutos
//
//  Created by Moises Swiczar on 11/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WSCall.h"
#import "XMLReaderObject.h"
#import "NDBSearch.h"

static NSInteger avalor=100;


@implementation WSCall

+(BOOL) getANOD:(NSMutableArray*)thearray
{
	[thearray removeAllObjects];
	
	NSString * stt;
	int ano ;
	for( ano= 2010; ano>1979; ano--)
	{
		stt = [NSString stringWithFormat:@"%d",ano];
		[thearray addObject:stt];
	}
	return YES;
}

+(BOOL) getANOH:(NSMutableArray*)thearray desde:(NSInteger) desde
{
	[thearray removeAllObjects];
	
	NSString * stt;
	int ano ;
	for( ano= 2010; ano>desde; ano--)
	{
		stt = [NSString stringWithFormat:@"%d",ano];
		[thearray addObject:stt];
	}
	return YES;
	
}



+(BOOL) getCaptcha:(NSString**)coki imagename:(NSString**)imagename 
{
	NSLog([NSString stringWithFormat:@"%@?UID=%@", URL_CAPTCHA,[[UIDevice currentDevice] uniqueIdentifier]]);
	
		NSMutableURLRequest *request;
		request = [[[NSMutableURLRequest alloc] init] autorelease];	
		[request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
		[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?UID=%@", URL_CAPTCHA,[[UIDevice currentDevice] uniqueIdentifier]]]];
		[request setHTTPMethod:@"GET"];
		[request setTimeoutInterval:25];
	
		[request setValue:@"iphonedata.deautos.com" forHTTPHeaderField:@"Host"];
		[request setValue:@"Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)" forHTTPHeaderField:@"User-Agent"];
		[request setValue:@"text/plain" forHTTPHeaderField:@"Accept"];
		[request setValue:@"en-us,en;q=0.5" forHTTPHeaderField:@"Accept-Language"];
		[request setValue:@"300" forHTTPHeaderField:@"Keep-Alive"];
		[request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
	
	

		NSURLResponse *response;
		NSError *error=nil;
		NSData *d = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
		// checking the response
		if ( (d) && (error.code == 0))
		{
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *documentsDirectory = [paths objectAtIndex:0];
			srand ( time(NULL) );
			
			double r = (   (double)rand() / ((double)(5680978)+(double)(1)) );
			int arandim  = (r * 17000);
			
			 *imagename = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d",arandim]];
			[d writeToFile:*imagename  options:0 error:&error];
	/*
			NSDictionary * thedictaaaa= [response allHeaderFields] ;
			NSArray * all = [NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:[NSURL URLWithString:@"/"]];
			for (NSHTTPCookie *cookie in all)
			{
				if ( [cookie.name isEqualToString:@"ASP.NET_SessionId"])
				{
					*coki = [NSString stringWithFormat:@"ASP.NET_SessionId=%@;HttpOnly",cookie.value];
					NSLog(*coki);
				}
				
			}
*/			
			return YES;
		}
		else
		{
			return NO;
		}
		return NO;
	}
	
	
	
	
	
	
	
	






+(BOOL) getMarca:(NSMutableArray*)thearray
{
	return [NDBSearch DBgetMarca:thearray];

	/*
	BOOL salida;
	NSString * url2call =[NSString stringWithFormat:@"http://iphonedata.deautos.com/Autos/Marcas/List/"];
	NSLog(url2call);
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
	[request setURL:[NSURL URLWithString:url2call]];
	[request setHTTPMethod:@"GET"];
	[request setTimeoutInterval:TIMEOUT];
	
	NSURLResponse *response;
	NSError *error=nil;
	NSData *d = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	if ( (d) && (error.code == 0))
	{
		// not error 	NSLog(url2call);
		NSString *myResponse = [ [NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
		NSLog(myResponse);
		
		XMLReaderObject *ret = [XMLReaderObject alloc];
		ret.ObjectName =@"clsMarca";
		ret.products = thearray;
		if ([ret parseXML:myResponse ])
		{
			salida= YES;
		}
		else
		{
			salida= NO;
		}
		[ret release];
	}
	else
	{
		// there is an error, just return NO to the caller
		salida= NO;
	}
	return salida;
	
	;
	 
	 */
	
}

+(BOOL) getModelo:(NSMutableArray*)thearray marca:(NSString*)marca
{
	return [NDBSearch DBgetModelo:thearray marca:marca];


	/*
	BOOL salida;
	NSString * url2call =[NSString stringWithFormat:@"http://iphonedata.deautos.com/Autos/Modelos/List/?id_Marca=%@",marca];
	NSLog(url2call);
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
	[request setURL:[NSURL URLWithString:url2call]];
	[request setHTTPMethod:@"GET"];
	[request setTimeoutInterval:TIMEOUT];
	
	NSURLResponse *response;
	NSError *error=nil;
	NSData *d = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	if ( (d) && (error.code == 0))
	{
		// not error 	NSLog(url2call);
		NSString *myResponse = [ [NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
		NSLog(myResponse);
		
		XMLReaderObject *ret = [XMLReaderObject alloc];
		ret.ObjectName =@"clsModelo";
		ret.products = thearray;
		if ([ret parseXML:myResponse ])
		{
			salida= YES;
		}
		else
		{
			salida= NO;
		}
		[ret release];
	}
	else
	{
		// there is an error, just return NO to the caller
		salida= NO;
	}
	return salida;
	*/
}

+(BOOL) getProvincia :(NSMutableArray*)thearray
{
	
	return [NDBSearch DBgetProvincia:thearray];


	/*
	BOOL salida;
	NSString * url2call =[NSString stringWithFormat:@"http://iphonedata.deautos.com/Callejero/Provincia/List/"];
	NSLog(url2call);
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
	[request setURL:[NSURL URLWithString:url2call]];
	[request setHTTPMethod:@"GET"];
	[request setTimeoutInterval:TIMEOUT];
	
	NSURLResponse *response;
	NSError *error=nil;
	NSData *d = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	if ( (d) && (error.code == 0))
	{
		// not error 	NSLog(url2call);
		NSString *myResponse = [ [NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
		NSLog(myResponse);
		
		XMLReaderObject *ret = [XMLReaderObject alloc];
		ret.ObjectName =@"clsProvincia";
		ret.products = thearray;
		if ([ret parseXML:myResponse ])
		{
			salida= YES;
		}
		else
		{
			salida= NO;
		}
		[ret release];
	}
	else
	{
		// there is an error, just return NO to the caller
		salida= NO;
	}
	return salida;
	*/
	
}


+(BOOL) getLocalidad:(NSMutableArray*)thearray provincia:(NSString*)provincia
{
	return [NDBSearch DBgetLocalidad:thearray provincia:provincia];
/*
	BOOL salida;
	NSString * url2call =[NSString stringWithFormat:@"http://iphonedata.deautos.com/Callejero/Zona/List/?id_provincia=%@",provincia];
	NSLog(url2call);
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
	[request setURL:[NSURL URLWithString:url2call]];
	[request setHTTPMethod:@"GET"];
	[request setTimeoutInterval:TIMEOUT];
	
	NSURLResponse *response;
	NSError *error=nil;
	NSData *d = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	if ( (d) && (error.code == 0))
	{
		// not error 	NSLog(url2call);
		NSString *myResponse = [ [NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
		NSLog(myResponse);
		
		XMLReaderObject *ret = [XMLReaderObject alloc];
		ret.ObjectName =@"clsZona";
		ret.products = thearray;
		if ([ret parseXML:myResponse ])
		{
			salida= YES;
		}
		else
		{
			salida= NO;
		}
		[ret release];
	}
	else
	{
		// there is an error, just return NO to the caller
		salida= NO;
	}
	return salida;
	*/
}


+(BOOL) getCombustible:(NSMutableArray*)thearray 
{
	NSMutableDictionary * thedict =[ [NSMutableDictionary alloc] init];
	
	[thedict setObject:@"Todos" forKey:@"Nombre"];
	[thedict setObject:@"0" forKey:@"Id"];
	[thearray addObject:thedict];

	
	thedict =[ [NSMutableDictionary alloc] init];
	[thedict setObject:@"Diesel" forKey:@"Nombre"];
	[thedict setObject:@"2" forKey:@"Id"];
	[thearray addObject:thedict];
	

	thedict =[ [NSMutableDictionary alloc] init];
	[thedict setObject:@"GNC" forKey:@"Nombre"];
	[thedict setObject:@"3" forKey:@"Id"];
	[thearray addObject:thedict];

	
	thedict =[ [NSMutableDictionary alloc] init];
	[thedict setObject:@"Nafta" forKey:@"Nombre"];
	[thedict setObject:@"1" forKey:@"Id"];
	[thearray addObject:thedict];

	
	thedict =[ [NSMutableDictionary alloc] init];
	[thedict setObject:@"ND" forKey:@"Nombre"];
	[thedict setObject:@"-1" forKey:@"Id"];
	[thearray addObject:thedict];
	
	
	
	return YES;
	
	
}





+(BOOL) getDetailAuto:(NSMutableArray*)thearray theaviso:(NSString*)theaviso nuevos:(BOOL)nuevos
{
	
	BOOL salida;
	NSString * url2call;
	if(nuevos)
	{
		url2call =[NSString stringWithFormat:@"http://iphonedata.deautos.com/nuevos/load/?id=%@",theaviso];
	}
	else
	{
		url2call =[NSString stringWithFormat:@"http://iphonedata.deautos.com/usados/load/?id=%@",theaviso];

	}
//	NSLog(url2call);
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
	[request setURL:[NSURL URLWithString:url2call]];
	[request setHTTPMethod:@"GET"];
	[request setTimeoutInterval:TIMEOUT];
	
	NSURLResponse *response;
	NSError *error=nil;
	NSData *d = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	if ( (d) && (error.code == 0))
	{
		NSString *myResponse = [ [NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
		//NSLog(myResponse);
		
		XMLReaderObject *ret = [XMLReaderObject alloc];
		
		if(nuevos)
		{
			ret.ObjectName =@"clsTblDic";
		}
		else
		{
			ret.ObjectName =@"clsTblDic";
			
		}
		
		ret.products = thearray;
		if ([ret parseXML:myResponse ])
		{
			salida= YES;
		}
		else
		{
			salida= NO;
		}
		[ret release];
	}
	else
	{
		// there is an error, just return NO to the caller
		salida= NO;
	}
	return salida;
	


}




+(BOOL) getAvisos:(NSMutableArray*)thearray diccionario:(NSMutableDictionary*)diccionario nuevos:(BOOL)nuevos
{
	
	/*
	 [diccionario objectForKey:@"Marca"];
	 [diccionario objectForKey:@"Modelo"];
	 [diccionario objectForKey:@"Combustible"];
	 [diccionario objectForKey:@"AvisosxPag"];
	 [diccionario objectForKey:@"NroPag"];
	 [diccionario objectForKey:@"OrderField"];

	 [diccionario objectForKey:@"Provincia"];
	 [diccionario objectForKey:@"Localidad"];
	 [diccionario objectForKey:@"OrderField"];
	
	 
	 &Provincia=
	 ID_Localidad=int
	 ID_Zona =int
	 Marca=%@&modelo=%@&Combustible=%@
	*/
	
	NSString * url2call;
	BOOL salida;

	if(nuevos)
	{
		url2call =[NSString stringWithFormat:@"http://iphonedata.deautos.com/Nuevos/Resultados/?ad=%@&Avisosxpag=%@&NroPag=%@&orden=%@",
						[diccionario objectForKey:@"AD"],
						[diccionario objectForKey:@"AvisosxPag"],
						[diccionario objectForKey:@"NroPag"],
						[diccionario objectForKey:@"OrderField"]
				  ];
		
		if( [diccionario objectForKey:@"Marca"]!=nil)
		{
			url2call = [NSString stringWithFormat:@"%@&Marca=%@",url2call, [diccionario objectForKey:@"Marca"]];
		}
 
		if( [diccionario objectForKey:@"Modelo"]!=nil)
		{
			url2call = [NSString stringWithFormat:@"%@&modelo=%@",url2call, [diccionario objectForKey:@"Modelo"]];
		}
		
		if( [diccionario objectForKey:@"Combustible"]!=nil)
		{
			url2call = [NSString stringWithFormat:@"%@&Combustible=%@",url2call, [diccionario objectForKey:@"Combustible"]];
		}
		if( [diccionario objectForKey:@"Provincia"]!=nil)
		{
			url2call = [NSString stringWithFormat:@"%@&Provincia=%@",url2call, [diccionario objectForKey:@"Provincia"]];
		}
		if( [diccionario objectForKey:@"Localidad"]!=nil)
		{
			url2call = [NSString stringWithFormat:@"%@&ID_Localidad=%@",url2call, [diccionario objectForKey:@"Localidad"]];
		}

		
		if( [diccionario objectForKey:@"ANOD"]!=nil)
		{
			url2call = [NSString stringWithFormat:@"%@&Aniod=%@",url2call, [diccionario objectForKey:@"ANOD"]];
		}
		
		if( [diccionario objectForKey:@"ANOH"]!=nil)
		{
			url2call = [NSString stringWithFormat:@"%@&Anioh=%@",url2call, [diccionario objectForKey:@"ANOH"]];
		}
		
		
		
		
		
	}
	else
	{
		url2call =[NSString stringWithFormat:@"http://iphonedata.deautos.com/Usados/Resultados/?ad=%@&Avisosxpag=%@&NroPag=%@&orden=%@",
						[diccionario objectForKey:@"AD"],
						[diccionario objectForKey:@"AvisosxPag"],
						[diccionario objectForKey:@"NroPag"],
						[diccionario objectForKey:@"OrderField"]
				   ];
		
		if( [diccionario objectForKey:@"Marca"]!=nil)
		{
			url2call = [NSString stringWithFormat:@"%@&Marca=%@",url2call, [diccionario objectForKey:@"Marca"]];
		}
		
		if( [diccionario objectForKey:@"Modelo"]!=nil)
		{
			url2call = [NSString stringWithFormat:@"%@&modelo=%@",url2call, [diccionario objectForKey:@"Modelo"]];
		}
		
		if( [diccionario objectForKey:@"Combustible"]!=nil)
		{
			url2call = [NSString stringWithFormat:@"%@&Combustible=%@",url2call, [diccionario objectForKey:@"Combustible"]];
		}
		if( [diccionario objectForKey:@"Provincia"]!=nil)
		{
			url2call = [NSString stringWithFormat:@"%@&Provincia=%@",url2call, [diccionario objectForKey:@"Provincia"]];
		}
		if( [diccionario objectForKey:@"Localidad"]!=nil)
		{
			url2call = [NSString stringWithFormat:@"%@&ID_Localidad=%@",url2call, [diccionario objectForKey:@"Localidad"]];
		}
		
		if( [diccionario objectForKey:@"ANOD"]!=nil)
		{
			url2call = [NSString stringWithFormat:@"%@&Aniod=%@",url2call, [diccionario objectForKey:@"ANOD"]];
		}
		
		if( [diccionario objectForKey:@"ANOH"]!=nil)
		{
			url2call = [NSString stringWithFormat:@"%@&Anioh=%@",url2call, [diccionario objectForKey:@"ANOH"]];
		}
		
	}
	
	NSLog(url2call);
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
	[request setURL:[NSURL URLWithString:url2call]];
	[request setHTTPMethod:@"GET"];
	[request setTimeoutInterval:TIMEOUT];
	
	NSURLResponse *response;
	NSError *error=nil;
	NSData *d = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	if ( (d) && (error.code == 0))
	{
		// not error 	NSLog(url2call);
		NSString *myResponse = [ [NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
		NSLog(myResponse);
		
		XMLReaderObject *ret = [XMLReaderObject alloc];
		
		if(nuevos)
		{
			ret.ObjectName =@"clsAviso0km";
		}
		else
		{
			ret.ObjectName =@"clsAvisoUsado";
		}
		
		ret.products = thearray;
		if ([ret parseXML:myResponse ])
		{
			salida= YES;
		}
		else
		{
			salida= NO;
		}
		[ret release];
	}
	else
	{
		// there is an error, just return NO to the caller
		salida= NO;
	}
	return salida;
	
}

/*
CREATE TABLE localidades (id integer, desc varchar(128) ,id_provincia integer);
CREATE TABLE marcas (id integer, desc varchar(128));
CREATE TABLE modelos (id integer, desc varchar(128) , id_marca integer);
CREATE TABLE provincias (id integer, pais_id integer, desc varchar(128),orden integer);
 
 
 
CREATE INDEX idx_loc_prov on localidades (id_provincia , desc);
CREATE INDEX idx_marcas on marcas (desc);
CREATE INDEX idx_modelos on modelos (id_marca , desc);
CREATE INDEX idx_provincias  on provincias  (pais_id,desc);
*/


+(BOOL) getContactarAviso:(NSString*)theid diccionario:(NSMutableDictionary*)diccionario nuevos:(BOOL)nuevos idcookie:(NSString*)idcookie ares:(NSString**) ares

{
/*
	 •	Id: int id del aviso buscado.
	 •	nombre: String Apellido y nombre
	 •	area: string(4) Codigo de area del telefono
	 •	cel: string(2) Codigo de celular -15-
	 •	telefono: string(8) numero telefonico
	 •	email: string
	 •	horario: string
	 •	comentario: string(300)
	 •	marca: int id marca del auto para permuta
	 •	modelo: int id modelo del auto para permuta
	 •	anio: int año del auto para permuta
	 •	km: int km del auto para permuta
	 •	captcha: string
	 •	news: 0/1
*/ 
	BOOL salida;

	NSMutableArray * thearraY;
	thearraY= [[NSMutableArray alloc] init];
	//BOOL salida;
	NSString * url2call;
	if(nuevos)
	{
		url2call =[NSString stringWithFormat:@"http://iphonedata.deautos.com/nuevos/Contactar/?UID=%@",[[UIDevice currentDevice] uniqueIdentifier]];
	}
	else
	{
		url2call =[NSString stringWithFormat:@"http://iphonedata.deautos.com/Usados/Contactar/?UID=%@",[[UIDevice currentDevice] uniqueIdentifier]];
		
	}
	

	
	NSString *string =  [[NSString alloc] initWithString:@""];
	string = [string stringByAppendingString:[NSString stringWithFormat:@"Id=%@&",[diccionario objectForKey:@"aviso_id"]]];
	string = [string stringByAppendingString:[NSString stringWithFormat:@"nombre=%@&",[diccionario objectForKey:@"TextApellido"]]];
	string = [string stringByAppendingString:[NSString stringWithFormat:@"telefono=%@&",[diccionario objectForKey:@"TextTel"]]];
	string = [string stringByAppendingString:[NSString stringWithFormat:@"email=%@&",[diccionario objectForKey:@"TextEmail"]]];
	string = [string stringByAppendingString:[NSString stringWithFormat:@"comentario=%@&",[diccionario objectForKey:@"TextComentarios"]]];
	string = [string stringByAppendingString:[NSString stringWithFormat:@"captcha=%@",[diccionario objectForKey:@"captcha"]]];


	NSNumber *length =[NSNumber numberWithUnsignedInteger:string.length];
	NSString *postLength = [length stringValue];
		
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
		[request setHTTPShouldHandleCookies:NO];

		[request setTimeoutInterval:45]; 
		[request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
		[request setURL:[NSURL URLWithString:url2call]];
		[request setHTTPMethod:@"POST"];
		[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
		[request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
		[request setValue:@"iphonedata.deautos.com" forHTTPHeaderField:@"Host"];
		[request setValue:@"Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)" forHTTPHeaderField:@"User-Agent"];
		[request setValue:@"text/plain" forHTTPHeaderField:@"Accept"];
		[request setValue:@"en-us,en;q=0.5" forHTTPHeaderField:@"Accept-Language"];
		[request setValue:@"300" forHTTPHeaderField:@"Keep-Alive"];
		[request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];	
	
		NSURLResponse *response;
		NSError *error=nil;
		NSData *d = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
		
		if ( (d) && (error.code == 0))
		{
			NSString *myResponse = [ [NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
			XMLReaderObject *ret = [XMLReaderObject alloc];
			ret.ObjectName =@"clsRespuesta";
			ret.products = thearraY;
			if ([ret parseXML:myResponse ])
			{
				if ([[[thearraY objectAtIndex:0] objectForKey:@"clsRespuesta_OK"] isEqualToString:@"false"])
				{
					salida= NO;
					*ares = [NSString stringWithFormat:@"%@",[[thearraY objectAtIndex:0] objectForKey:@"clsRespuesta_Mensaje_string"] ];
				
				}
				else
				{
				
					salida= YES;
				
				
				}
				
				
				
			}
			else
			{
				salida= NO;
			}
			[ret release];
			NSLog(myResponse);
			
			[myResponse release];
			/*
			@"clsRespuesta_OK"
			if (false</>)
			 */
				[thearraY release];
			//salida=  [myResponse integerValue];
		}
		return salida;
	

}

+(BOOL) getBannerforPosicion:(NSInteger) posicion is_nuevo:(BOOL)is_nuevo  thebanner:(NBanner*)thebanner ;

{
	NSMutableString * url2callClick;
	NSMutableString * url2callView;

	avalor++;
	if(is_nuevo)
	{	
		switch (posicion) {
			case 0:
				url2callClick =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/ei/3/4d63/111cae63fb288861?it=i&m=1&rnd=$RANDOM"];
				url2callView =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/eb/3/4d63/111cae63fb288861?o=i&m=1&rnd=$RANDOM"] ;
				break;
			case 1:
				url2callClick =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/ei/3/4d63/ff2e513b1e47b58f?it=i&amp;m=1&amp;rnd=$RANDOM"];
				url2callView =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/eb/3/4d63/ff2e513b1e47b58f?o=i&amp;m=1&amp;rnd=$RANDOM"];
				break;
			case 2:
				//<a href=""><img alt="e-planning.net ad" src=""/></a>
				url2callClick =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/ei/3/4d63/8430ead799eee084?it=i&amp;m=1&amp;rnd=$RANDOM"];
				url2callView =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/eb/3/4d63/8430ead799eee084?o=i&amp;m=1&amp;rnd=$RANDOM"];
				break;
			case 3:
			//	<a href=""><img alt="e-planning.net ad" src=""/></a>
				
				url2callClick =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/ei/3/4d63/b6aec66e231ab0a3?it=i&amp;m=1&amp;rnd=$RANDOM"];
				url2callView =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/eb/3/4d63/b6aec66e231ab0a3?o=i&amp;m=1&amp;rnd=$RANDOM"];
				break;
			default:
				url2callClick =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/ei/3/4d63/b6aec66e231ab0a3?it=i&amp;m=1&amp;rnd=$RANDOM"];
				url2callView =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/eb/3/4d63/b6aec66e231ab0a3?o=i&amp;m=1&amp;rnd=$RANDOM"];
				break;
		}
	}
	else
	{
		switch (posicion) {
			case 0:
//				<a href=""><img alt="e-planning.net ad" src=""/></a>
	
				url2callClick =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/ei/3/4d63/3621a8dab838f13a?it=i&m=1&rnd=$RANDOM"];
				url2callView =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/eb/3/4d63/3621a8dab838f13a?o=i&m=1&rnd=$RANDOM"] ;
				break;
			case 1:
				url2callClick =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/ei/3/4d63/d8d9fa5515b4f5a6?it=i&amp;m=1&amp;rnd=$RANDOM"];
				url2callView =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/eb/3/4d63/d8d9fa5515b4f5a6?o=i&amp;m=1&amp;rnd=$RANDOM"];
				break;
			case 2:
				url2callClick =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/ei/3/4d63/8430ead799eee084?it=i&amp;m=1&amp;rnd=$RANDOM"];
				url2callView =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/eb/3/4d63/8430ead799eee084?o=i&amp;m=1&amp;rnd=$RANDOM"];
				break;
			case 3:
				
				url2callClick =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/ei/3/4d63/b6aec66e231ab0a3?it=i&amp;m=1&amp;rnd=$RANDOM"];
				url2callView =[NSMutableString stringWithFormat:@"http://ads.e-planning.net/eb/3/4d63/b6aec66e231ab0a3?o=i&amp;m=1&amp;rnd=$RANDOM"];
				break;
			default:
				url2callClick =[NSString stringWithFormat:@"http://ads.e-planning.net/ei/3/4d63/b6aec66e231ab0a3?it=i&amp;m=1&amp;rnd=$RANDOM"];
				url2callView =[NSString stringWithFormat:@"http://ads.e-planning.net/eb/3/4d63/b6aec66e231ab0a3?o=i&amp;m=1&amp;rnd=$RANDOM"];
				break;
		}
	}

	avalor++;

	  [url2callClick replaceOccurrencesOfString:@"$RANDOM" withString:[NSString stringWithFormat:@"%d",avalor] options:0 range:NSMakeRange(0, [url2callClick length])];
	avalor++;

	 [url2callView replaceOccurrencesOfString:@"$RANDOM" withString:[NSString stringWithFormat:@"%d",avalor] options:0 range:NSMakeRange(0, [url2callView length])];
	
//	NSLog([NSString stringWithFormat:@"Click: %@",url2callClick]);
//	NSLog([NSString stringWithFormat:@"View: %@",url2callView]);
	
				
			thebanner.UrlClick = url2callClick;
			thebanner.UrlImage = url2callView;
	
	return YES;
	

}

				
/*
 
 Posicion 0
 <!-- e-planning v3 - Comienzo espacio DeAutos.com _ IPhone _ R_Busqueda_Nuevos -->
 <a href="http://ads.e-planning.net/ei/3/4d63/111cae63fb288861?it=i&amp;m=1&amp;rnd=$RANDOM"><img alt="e-planning.net ad" src="http://ads.e-planning.net/eb/3/4d63/111cae63fb288861?o=i&amp;m=1&amp;rnd=$RANDOM"/></a>
 <!-- e-planning v3 - Fin espacio DeAutos.com _ IPhone _ R_Busqueda_Nuevos -->
 

 <!-- e-planning v3 - Comienzo espacio DeAutos.com _ IPhone _ R_Busqueda_Usados -->
 <a href="http://ads.e-planning.net/ei/3/4d63/3621a8dab838f13a?it=i&amp;m=1&amp;rnd=$RANDOM"><img alt="e-planning.net ad" src="http://ads.e-planning.net/eb/3/4d63/3621a8dab838f13a?o=i&amp;m=1&amp;rnd=$RANDOM"/></a>
 <!-- e-planning v3 - Fin espacio DeAutos.com _ IPhone _ R_Busqueda_Usados -->
 
 Posicion 1
 
 <!-- e-planning v3 - Comienzo espacio DeAutos.com _ IPhone _ View Item Nuevos -->
 <a href="http://ads.e-planning.net/ei/3/4d63/ff2e513b1e47b58f?it=i&amp;m=1&amp;rnd=$RANDOM"><img alt="e-planning.net ad" src="http://ads.e-planning.net/eb/3/4d63/ff2e513b1e47b58f?o=i&amp;m=1&amp;rnd=$RANDOM"/></a>
 <!-- e-planning v3 - Fin espacio DeAutos.com _ IPhone _ View Item Nuevos -->
 
 <!-- e-planning v3 - Comienzo espacio DeAutos.com _ IPhone _ View Item Usados -->
 <a href="http://ads.e-planning.net/ei/3/4d63/d8d9fa5515b4f5a6?it=i&amp;m=1&amp;rnd=$RANDOM"><img alt="e-planning.net ad" src="http://ads.e-planning.net/eb/3/4d63/d8d9fa5515b4f5a6?o=i&amp;m=1&amp;rnd=$RANDOM"/></a>
 <!-- e-planning v3 - Fin espacio DeAutos.com _ IPhone _ View Item Usados -->
 
 
 Posicion 2
 
 <!-- e-planning v3 - Comienzo espacio DeAutos.com _ IPhone _ Contacto 1 -->
 <a href="http://ads.e-planning.net/ei/3/4d63/8430ead799eee084?it=i&amp;m=1&amp;rnd=$RANDOM"><img alt="e-planning.net ad" src="http://ads.e-planning.net/eb/3/4d63/8430ead799eee084?o=i&amp;m=1&amp;rnd=$RANDOM"/></a>
 <!-- e-planning v3 - Fin espacio DeAutos.com _ IPhone _ Contacto 1 -->
 
 Posicion 3
 
 <!-- e-planning v3 - Comienzo espacio DeAutos.com _ IPhone _ Contacto 2 -->
 <a href="http://ads.e-planning.net/ei/3/4d63/b6aec66e231ab0a3?it=i&amp;m=1&amp;rnd=$RANDOM"><img alt="e-planning.net ad" src="http://ads.e-planning.net/eb/3/4d63/b6aec66e231ab0a3?o=i&amp;m=1&amp;rnd=$RANDOM"/></a>
 <!-- e-planning v3 - Fin espacio DeAutos.com _ IPhone _ Contacto 2 -->
 
 
 
 */



@end

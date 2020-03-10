//
//  NBanner.h
//  Detelefoongids
//
//  Created by Moises Swiczar on 5/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NBanner : NSObject {
	NSString *UrlImage;
	NSString *UrlClick;
	NSString *Imagefileindevice; 
}
@property (nonatomic,copy) NSString *UrlImage;
@property (nonatomic,copy) NSString *UrlClick;
@property (nonatomic,copy) NSString *Imagefileindevice;

@end

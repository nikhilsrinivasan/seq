//
//  Foursquare.h
//  Seq
//
//  Created by Neel Mouleeswaran on 8/1/14.
//  Copyright (c) 2014 bitpass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Foursquare : NSObject

+ (NSString *)getVenueIDForSearchQuery:(NSString *)query;
+ (NSString *)getUserIDForSearchQuery:(NSString *)query;

@end

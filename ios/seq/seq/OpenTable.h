//
//  OpenTable.h
//  Seq
//
//  Created by Neel Mouleeswaran on 8/2/14.
//  Copyright (c) 2014 bitpass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenTable : NSObject

+ (NSString *)getRestaurantCodeForSearchQuery:(NSString *)query;

@end

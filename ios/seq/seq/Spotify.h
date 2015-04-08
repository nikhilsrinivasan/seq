//
//  Spotify.h
//  Seq
//
//  Created by Neel Mouleeswaran on 8/2/14.
//  Copyright (c) 2014 bitpass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Spotify : NSObject

+ (NSString *)getArtistURIForQuery:(NSString *)query;

+ (NSString *)getTrackURIForQuery:(NSString *)query;

@end

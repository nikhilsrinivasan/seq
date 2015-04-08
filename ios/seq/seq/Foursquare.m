//
//  Foursquare.m
//  Seq
//
//  Created by Neel Mouleeswaran on 8/1/14.
//  Copyright (c) 2014 bitpass. All rights reserved.
//

#import "Foursquare.h"

@implementation Foursquare

+ (NSString *)getVenueIDForSearchQuery:(NSString *)query {
    
    query = [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString *urlString = @"https://api.foursquare.com/v2/venues/search?client_id=ID0M2P2LLYGILAVBFKPPIRXBEQQKGNX0BY0OA3ARA0CZ5OFS&client_secret=MEIB4RRW3OFJXKL2FLMETRQM3TZ1LCXSH3HIZ5FXE3T0XQEA&v=20130815&near=mountain+view&query=";
    
    urlString = [urlString stringByAppendingString:query];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:nil];
    
    NSString *ret;
    
    @try {
        ret = [[[[json objectForKey:@"response"]objectForKey:@"venues"]objectAtIndex:0]objectForKey:@"id"];
    }
    @catch (NSException * e) {
        ret = @"failed";
    }
    
    return ret;

}

+ (NSString *)getUserIDForSearchQuery:(NSString *)query {
    
    NSString *urlString = @"https://api.foursquare.com/v2/users/search?client_id=ID0M2P2LLYGILAVBFKPPIRXBEQQKGNX0BY0OA3ARA0CZ5OFS&client_secret=MEIB4RRW3OFJXKL2FLMETRQM3TZ1LCXSH3HIZ5FXE3T0XQEA&v=20130815&near=mountain+view&query=";
    
    urlString = [urlString stringByAppendingString:query];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:nil];
    
    
    return [[[[json objectForKey:@"response"]objectForKey:@"users"]objectAtIndex:0]objectForKey:@"id"];
    
}

@end

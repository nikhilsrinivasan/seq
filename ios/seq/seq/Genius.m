//
//  Genius.m
//  Seq
//
//  Created by Neel Mouleeswaran on 8/3/14.
//  Copyright (c) 2014 bitpass. All rights reserved.
//

#import "Genius.h"

@implementation Genius

+ (NSString *)getArtistIDForQuery:(NSString *)query {
    
    query = [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString *urlString = @"http://api.rapgenius.com/search?q=";
    
    urlString = [urlString stringByAppendingString:query];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:nil];
        
    NSLog(@"json = %@", [[[[[[json objectForKey:@"response"] objectForKey:@"hits"] objectAtIndex:0] objectForKey:@"result"] objectForKey:@"primary_artist"] objectForKey:@"id"]);
    
    return [[[[[[json objectForKey:@"response"] objectForKey:@"hits"] objectAtIndex:0] objectForKey:@"result"] objectForKey:@"primary_artist"] objectForKey:@"id"];
    
}

@end

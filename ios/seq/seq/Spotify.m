//
//  Spotify.m
//  Seq
//
//  Created by Neel Mouleeswaran on 8/2/14.
//  Copyright (c) 2014 bitpass. All rights reserved.
//

#import "Spotify.h"

@implementation Spotify

+ (NSString *)getArtistURIForQuery:(NSString *)query {
    
    query = [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString *urlString = @"http://ws.spotify.com/search/1/artist.json?q=";
    
    urlString = [urlString stringByAppendingString:query];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:nil];
    
    NSLog(@"%@", [[[[json objectForKey:@"response"]objectForKey:@"artists"]objectAtIndex:0]objectForKey:@"href"]);
    
    NSLog(@"json = %@", [json allKeys]);

    return [[[json objectForKey:@"artists"]objectAtIndex:0]objectForKey:@"href"];
    
}

+ (NSString *)getTrackURIForQuery:(NSString *)query {
    
    query = [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString *urlString = @"http://ws.spotify.com/search/1/artist.json?q=";
    
    urlString = [urlString stringByAppendingString:query];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:nil];
    
    NSLog(@"%@", [[[[json objectForKey:@"response"]objectForKey:@"artists"]objectAtIndex:0]objectForKey:@"href"]);
    
    return [[[json objectForKey:@"artists"]objectAtIndex:0]objectForKey:@"href"];
    
}



@end

//
//  OpenTable.m
//  Seq
//
//  Created by Neel Mouleeswaran on 8/2/14.
//  Copyright (c) 2014 bitpass. All rights reserved.
//

#import "OpenTable.h"

@implementation OpenTable

+ (NSString *)getRestaurantCodeForSearchQuery:(NSString *)query {
    // https://opentable.herokuapp.com/api/restaurants?name=reposado&zip=94301
    
    NSString *urlString = @"https://opentable.herokuapp.com/api/restaurants?zip=94041&name=";
    
    urlString = [urlString stringByAppendingString:query];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:nil];
    
    
    NSLog(@"json = %@", [[json objectForKey:@"restaurants"] objectAtIndex:0]);
    
    return [[[[json objectForKey:@"restaurants"] objectAtIndex:0] objectForKey:@"id"]stringValue];
    
}

@end

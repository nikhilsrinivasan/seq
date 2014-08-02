//
//  Airbnb.m
//  Seq
//
//  Created by Neel Mouleeswaran on 8/2/14.
//  Copyright (c) 2014 bitpass. All rights reserved.
//

#import "Airbnb.h"

@implementation Airbnb

+ (NSArray *)getAirbnbRoomsForLocation:(NSString *)location {
    
    NSString *urlString = @"https://www.kimonolabs.com/api/85khwhec?apikey=iKHZruWfsa8Qg2bIVzHnq0Mk8KyAX8e1&kimpath2=";
    
    urlString = [urlString stringByAppendingString:location];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:nil];
    
    
    NSLog(@"json = %@", json);
    
    return nil;
    
}

@end

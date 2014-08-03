//
//  AppSwitch.m
//  Seq
//
//  Created by Neel Mouleeswaran on 8/1/14.
//  Copyright (c) 2014 bitpass. All rights reserved.
//

#import "AppSwitch.h"

@implementation AppSwitch


# pragma mark Foursquare
+ (void)launchFoursquareWithVenueID:(NSString *)venueID {
    
    NSString *urlString = [@"foursquare://venues/" stringByAppendingString:venueID];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
    else {
        NSString *appStoreLink = @"itms-apps://itunes.apple.com/us/app/foursquare/id306934924?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreLink]];
    }
    
}

+ (void)launchFoursquareWithUserID:(NSString *)userID {
    
    NSString *urlString = [@"foursquare://users/" stringByAppendingString:userID];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
    else {
        NSString *appStoreLink = @"itms-apps://itunes.apple.com/us/app/foursquare/id306934924?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreLink]];
    }
    
}

#pragma mark Uber
+ (void)launchUber {
    NSURL *url = [NSURL URLWithString:@"uber:/"];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
    else {
        NSString *appStoreLink = @"itms-apps://itunes.apple.com/us/app/uber/id368677368?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreLink]];
    }
}

#pragma mark Lyft
+ (void)launchLyft {
    
    NSURL *url = [NSURL URLWithString:@"fb275560259205767://"];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
    else {
        NSString *appStoreLink = @"itms-apps://itunes.apple.com/us/app/lyft/id529379082?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreLink]];
    }
    
}

#pragma mark Yelp
+ (void)launchYelpWithSearchQuery:(NSString *)query {
    
    NSString *urlString = @"yelp:///search?terms=";
    urlString = [urlString stringByAppendingString:query];
    NSURL *url = [NSURL URLWithString:urlString];
    
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
    else {
        NSString *appStoreLink = @"itms-apps://itunes.apple.com/us/app/yelp/id284910350?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreLink]];
    }
    
}

#pragma mark Google Maps
+ (void)launchGoogleMapsWithSearchQuery:(NSString *)query {
    
    NSString *urlString = @"comgooglemaps://?q=";
    urlString = [urlString stringByAppendingString:query];
    NSURL *url = [NSURL URLWithString:urlString];
    
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
    else {
        NSString *appStoreLink = @"itms-apps://itunes.apple.com/us/app/google-maps/id585027354?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreLink]];
    }
    
}

#pragma mark Apple Maps
+ (void)launchAppleMapsWithSearchQuery:(NSString *)query {
    
    NSString *urlString = @"http://maps.apple.com/?q=";
    urlString = [urlString stringByAppendingString:query];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[UIApplication sharedApplication] openURL:url];
    
}

#pragma mark Expedia
+ (void)launchExpediaTrips {
    
    NSString *urlString = @"expda://trips/";
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[UIApplication sharedApplication] openURL:url];
    
}

#pragma mark OpenTable
+ (void)launchOpenTableWithRestaurantCode:(NSString *)restaurantCode {
    
    NSString *urlString = [NSString stringWithFormat:@"fb123876194314735otiphone:/https://mobile-api.opentable.com/api/v2/restaurant/%@", restaurantCode];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[UIApplication sharedApplication] openURL:url];
}


#pragma mark Airbnb
+ (void)launchAirbnbWithRoomID:(NSString *)roomID {
    
    NSString *urlString = @"airbnb://rooms/";
    urlString = [urlString stringByAppendingString:roomID];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[UIApplication sharedApplication] openURL:url];
    
}

@end

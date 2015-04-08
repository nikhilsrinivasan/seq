//
//  AppSwitch.h
//  Seq
//
//  Created by Neel Mouleeswaran on 8/1/14.
//  Copyright (c) 2014 bitpass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSwitch : NSObject

# pragma mark Foursquare
+ (void)launchFoursquareWithVenueID:(NSString *)venueID;

+ (void)launchFoursquareWithUserID:(NSString *)userID;

#pragma mark Uber
+ (void)launchUber;

#pragma mark Lyft
+ (void)launchLyft;

#pragma mark Yelp
+ (void)launchYelpWithSearchQuery:(NSString *)query;

#pragma mark Google Maps
+ (void)launchGoogleMapsWithSearchQuery:(NSString *)query;

#pragma mark Apple Maps
+ (void)launchAppleMapsWithSearchQuery:(NSString *)query;

+ (void)launchAirbnbWithRoomID:(NSString *)roomID;

+ (void)launchOpenTableWithRestaurantCode:(NSString *)restaurantCode;

+ (void)launchSpotifyWithArtistID:(NSString *)artistURI;

+ (void)launchSpotifyWithTrackID:(NSString *)trackURI;

+ (void)launchGeniusWithArtistID:(NSString *)artistID;

+ (void)launchHipmunkFlightSearch;

+ (void)launchHipmunkHotelSearch;

@end

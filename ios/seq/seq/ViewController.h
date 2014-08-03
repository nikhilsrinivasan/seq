//
//  ViewController.h
//  Seq
//
//  Created by Neel Mouleeswaran on 8/1/14.
//  Copyright (c) 2014 bitpass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    NSMutableDictionary *contexts;
    NSArray *matchedContexts;
    
    CLLocationManager *locationManager;
    
    NSString *roomID; // airbnb
    NSString *venueID; // foursquare
    //NSString *artistURI; // spotify
    //NSString *artistID; // genius
        
}
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

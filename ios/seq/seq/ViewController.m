//
//  ViewController.m
//  Seq
//
//  Created by Neel Mouleeswaran on 8/1/14.
//  Copyright (c) 2014 bitpass. All rights reserved.
//

#import "Helpers.h"
#import "AppSwitch.h"
#import "ViewController.h"

static float rowHeight;

static float latitude;
static float longitude;

@interface ViewController ()

@end

@implementation ViewController
@synthesize searchBar;
@synthesize tableView;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self initContexts];
    [self setupLocation];
    
    [super viewDidLoad];
    
    tableView.alpha = 0;
    self.tableView.separatorColor = [UIColor clearColor];
    
   // [tableView setScrollEnabled:NO];
    
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    
    rowHeight = 50.0f;
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];
    
    [searchBar setBackgroundColor:[UIColor colorWithRed:52/255.0 green:126/255.0 blue:170/255.0 alpha:0.44]];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupLocation {
    // locationManager update as location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
}

-(void) locationManager: (CLLocationManager *)manager didUpdateToLocation: (CLLocation *) newLocation
           fromLocation: (CLLocation *) oldLocation {
    
    longitude =newLocation.coordinate.longitude;
    latitude=newLocation.coordinate.latitude;
    
    //NSLog(@"dLongitude : %f", longitude);
    //NSLog(@"dLatitude : %f", latitude);
    
}

-(void)initContexts {
    
    contexts = [[NSMutableDictionary alloc]init];
    
    NSArray *food = [[NSArray alloc]initWithObjects:@"yelp", nil];
    NSArray *ride = [[NSArray alloc]initWithObjects:@"lyft", @"uber", nil];
    NSArray *stay = [[NSArray alloc]initWithObjects:@"airbnb", @"hipmunk-hotels", nil];
    NSArray *flight = [[NSArray alloc] initWithObjects:@"hipmunk-flights", nil];
    
    NSArray *map = [[NSArray alloc ]initWithObjects:@"maps", @"google-maps", @"foursquare", nil];

    NSArray *artist = [[NSArray alloc ]initWithObjects:@"spotify", @"rdio", @"genius", nil];
    
    NSArray *track = [[NSArray alloc ]initWithObjects:@"spotify-track", @"rdio-track", nil];
    
    [contexts setObject:food forKey:@"food"];
    [contexts setObject:ride forKey:@"ride"];
    [contexts setObject:map forKey:@"map"];
    [contexts setObject:stay forKey:@"stay"];
    [contexts setObject:artist forKey:@"artist"];
    [contexts setObject:track forKey:@"track"];
    [contexts setObject:flight forKey:@"flight"];
    
    matchedContexts = [[NSArray alloc]init];
    
    
    roomID = @"";
    venueID = @"";
    
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    //rowHeight = 50.0f;
    
    tableView.alpha = 1;
    
    matchedContexts = [[NSArray alloc]init];

    [self refreshTable];
    
}

-(int)findUberCellIndexPath:(int)numRows {
    
    //NSLog(@"# rows in sec: %d", [tableView numberOfRowsInSection:0]);
    
    for(int i = 0; i < numRows; i++) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        //NSLog(@"reuse = %@", [cell reuseIdentifier]);
        
        if([[cell reuseIdentifier] isEqualToString:@"uber"]) {
            //NSLog(@"uber = %d", i);
            return i;
        }
    }
    
    return -1;
}

-(void)refreshTable {
    
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    //[tableView reloadData];
    tableView.backgroundView = nil;
    tableView.backgroundColor = [UIColor clearColor];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if([[searchBar text]length] == 0) {
        [self initContexts];
        
        [self refreshTable];
        
    }
    
    else if([[searchBar text]characterAtIndex:([[searchBar text]length] - 1)] == ' ' ){
        
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            NSArray *newMatchedContexts = [self seq_context_query:searchText];
            
            if([newMatchedContexts isEqualToArray:matchedContexts]) ;
            
            else {
                
                matchedContexts = [[NSArray alloc] initWithArray:newMatchedContexts];
                
                [self refreshTable];
            }
       // });
    }
}

-(int)preFetchResults {
    
    // prefetch foursquare venue id
    if([matchedContexts containsObject:@"map"]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            venueID = [Foursquare getVenueIDForSearchQuery:[searchBar text]];
            //NSLog(@"fetched %@", venueID);
        });
    }
    
    // prefetch airbnb room id
    if([matchedContexts containsObject:@"stay"]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            roomID = [[Airbnb getAirbnbRoomsForLocation:[searchBar text]]objectAtIndex:0];
            //NSLog(@"fetched %@", roomID);
        });
        
        
    }
    
    int numItems = 0;
    
    for(int i = 0; i < matchedContexts.count; i++) {
        numItems += [[contexts objectForKey:[matchedContexts objectAtIndex:i] ]count];
    }
    
    //NSLog(@"contexts = %@", matchedContexts);
    //NSLog(@"size = %d", numItems);
    
    return numItems;

}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    int numRows = [self preFetchResults];
    
    //NSLog(@"attempting change");
    
    
    //NSLog(@"index = %d", index);
  //
    
   // [[[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]]detailTextLabel]setText:description];
    
    [tableView reloadData];
    
   // tableView.rowHeight = 75.0f;

   // [self.tableView reloadRowsAtIndexPaths:[tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (NSIndexPath *)keyForIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath class] == [NSIndexPath class]) {
        return indexPath;
    }
    return [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self initContexts];
    
    [self refreshTable];
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    if([[searchBar text]length] == 0) {
        [self initContexts];
        
        [self refreshTable];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int numItems = 0;
    
    for(int i = 0; i < matchedContexts.count; i++) {
        numItems += [[contexts objectForKey:[matchedContexts objectAtIndex:i] ]count];
    }
    
    //NSLog(@"contexts = %@", matchedContexts);
    //NSLog(@"size = %d", numItems);
    
    return numItems;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = nil;
    [tableView setSeparatorInset:UIEdgeInsetsZero];

   // [tableView setScrollEnabled:NO];
    
    NSMutableArray *contextApps = [[NSMutableArray alloc]init];
    for(int i = 0; i < matchedContexts.count; i++) {
        [contextApps addObjectsFromArray:[contexts objectForKey:[matchedContexts objectAtIndex:i]]];
    }
    
    NSString *appName = [contextApps objectAtIndex:[indexPath row]];
    
    UITableViewCell *cell;
    
    //NSLog(@"%@", appName);
    
    //cell = [tableView dequeueReusableCellWithIdentifier:appName];
    
    //if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:appName];
    
        [[cell textLabel]setText:[self cellTextForAppName:appName]];
        [[cell detailTextLabel]setText:[self cellDetailTextForAppName:appName]];
        
        [[cell textLabel]setTextColor:[UIColor whiteColor]];
        [[cell detailTextLabel]setTextColor:[UIColor whiteColor]];

        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor colorWithRed: 0/255.0 green: 0/255.0 blue: 0/255.0 alpha: 0.25];

        cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:17];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Avenir" size:13];
    
        [[cell imageView]setImage:[UIImage imageNamed:appName]];
        
        cell.clipsToBounds = YES;
        
        //UILabel *label = [[UILabel alloc]init];
    //}
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *appName = cell.reuseIdentifier;
    
    [self openSchemeForAppName:appName withQuery:[searchBar text]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ////NSLog(@"curr height = %f", rowHeight);
    return rowHeight;
}

-(NSString *)cellDetailTextForAppName:(NSString *)appName {
    
    if([appName isEqualToString:@"yelp"]) {
        //return [NSString stringWithFormat:@"Find reviews for %@", [searchBar text]];
        return @"Find restaurant reviews on yelp";
    }
    
    else if([appName isEqualToString:@"opentable"]) {
        return @"Book this restaurant in opentable";
    }
    
    else if([appName isEqualToString:@"lyft"]) {
        return @"Get there with Lyft";
    }
    
    else if([appName isEqualToString:@"uber"]) {
        NSString *eta = [self getUberETA];
        return [NSString stringWithFormat:@"Ready for pickup in %@ minutes", eta];
    }
    
    else if([appName isEqualToString:@"apple-maps"]) {
        return @"Get directions with Apple Maps";
    }
    
    else if([appName isEqualToString:@"google-maps"]) {
        return @"Get directions with Google Maps";
    }
    
    else if([appName isEqualToString:@"airbnb"]) {
        return @"Find a place to stay with Airbnb";
    }
    
    else if([appName isEqualToString:@"foursquare"]) {
        return @"Open this place in Foursquare";
    }
    
    else if([appName isEqualToString:@"hipmunk-hotels"]) {
        return @"Book a hotel with Hipmunk";
    }
    
    else if([appName isEqualToString:@"hipmunk-flights"]) {
        return @"Book a flight with Hipmunk";
    }
    
    else if([appName isEqualToString:@"spotify"]) {
        return @"Listen to this artist on Spotify";
    }
    
    else if([appName isEqualToString:@"rdio"]) {
        return @"Listen to this artist on Rdio";
    }
    
    else if([appName isEqualToString:@"genius"]) {
        return @"Find annotated lyrics and more on Genius";
    }

    else ;
    
    return nil;
    
}

-(NSString *)cellTextForAppName:(NSString *)appName {
    
    if([appName isEqualToString:@"yelp"]) {
        return @"Yelp";
    }
    
    else if([appName isEqualToString:@"opentable"]) {
        return @"OpenTable";
    }
    
    else if([appName isEqualToString:@"lyft"]) {
        return @"Lyft";
    }
    
    else if([appName isEqualToString:@"uber"]) {
        return @"Uber";
    }
    
    else if([appName isEqualToString:@"maps"]) {
        return @"Maps";
    }
    
    else if([appName isEqualToString:@"google-maps"]) {
        return @"Google Maps";
    }
    
    else if([appName isEqualToString:@"airbnb"]) {
        return @"Airbnb";
    }
    
    else if([appName isEqualToString:@"foursquare"]) {
        return @"Foursquare";
    }
    
    else if([appName isEqualToString:@"spotify"]) {
        return @"Spotify";
    }
    
    else if([appName isEqualToString:@"rdio"]) {
        return @"Rdio";
    }
    
    else if([appName isEqualToString:@"genius"]) {
        return @"Genius";
    }
    
    else if([appName isEqualToString:@"hipmunk-hotels"]) {
        return @"Hipmunk";
    }
    
    else if([appName isEqualToString:@"hipmunk-flights"]) {
        return @"Hipmunk";
    }
    

    else ;
    
    return nil;
    
    
}

- (void)openSchemeForAppName:(NSString *)appName withQuery:(NSString *)query {
    
    //NSLog(@"opening scheme for [%@]", appName);
    //NSLog(@"with query [%@]", query);
    
    if([appName isEqualToString:@"yelp"]) {
        [AppSwitch launchYelpWithSearchQuery:query];
    }
    
    else if([appName isEqualToString:@"opentable"]) {
        
        NSString *restaurantCode = [OpenTable getRestaurantCodeForSearchQuery:query];
        [AppSwitch launchOpenTableWithRestaurantCode:restaurantCode];
        
    }
    
    else if([appName isEqualToString:@"lyft"]) {
        [AppSwitch launchLyft];
    }
    
    else if([appName isEqualToString:@"uber"]) {
        [AppSwitch launchUber];
    }
    
    else if([appName isEqualToString:@"maps"]) {
        [AppSwitch launchAppleMapsWithSearchQuery:query];
    }
    
    else if([appName isEqualToString:@"google-maps"]) {
        [AppSwitch launchGoogleMapsWithSearchQuery:query];
    }
    
    else if([appName isEqualToString:@"foursquare"]) {
        //NSLog(@"venue id = %@", venueID);
        [AppSwitch launchFoursquareWithVenueID:venueID];
    }
    
    else if([appName isEqualToString:@"airbnb"]) {
        //NSLog(@"room id = %@", roomID);
        [AppSwitch launchAirbnbWithRoomID:roomID];
    }
    
    else if([appName isEqualToString:@"spotify"]) {
        NSString *artistID = [Spotify getArtistURIForQuery:query];
        [AppSwitch launchSpotifyWithArtistID:artistID];
    }
    
    else if([appName isEqualToString:@"rdio"]) {
        //
    }
    
    else if([appName isEqualToString:@"genius"]) {
        NSString *artistID = [Genius getArtistIDForQuery:query];
        [AppSwitch launchGeniusWithArtistID:artistID];
    }
    
    else if([appName isEqualToString:@"hipmunk-hotels"]) {
        [AppSwitch launchHipmunkHotelSearch];
    }
    
    else if([appName isEqualToString:@"hipmunk-flights"]) {
        [AppSwitch launchHipmunkFlightSearch];
    }
    
    else ;

}

-(NSString *)getUberETA {
    
    NSString *urlString = [NSString stringWithFormat:@"http://104.131.208.31:5000/nearest_uber?latitude=%f&longitude=%f", latitude, longitude];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
   // //NSLog(@"url = %@", url);
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:nil];
    
   // //NSLog(@"json = %@", json);
    
    return [json objectForKey:@"eta"];
    
}

- (NSArray *) seq_context_query:(NSString *)query {
    
    NSString *urlString = @"http://seqnlp.herokuapp.com/?q=";
    urlString = [urlString stringByAppendingString:[query stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSLog(@"response = %@", json);
    
    return [json objectForKey:@"contexts"];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end

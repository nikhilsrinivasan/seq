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

static NSString *searchText;

@interface ViewController ()

@end

@implementation ViewController
@synthesize searchBar;
@synthesize tableView;

- (void)viewDidLoad
{
    
    [self initContexts];
    
    [super viewDidLoad];
    
    tableView.alpha = 0.8;
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initContexts {
    contexts = [[NSMutableDictionary alloc]init];
    
    NSArray *food = [[NSArray alloc]initWithObjects:@"yelp", @"opentable", nil];
    NSArray *ride = [[NSArray alloc]initWithObjects:@"lyft", @"uber", nil];
    NSArray *stay = [[NSArray alloc]initWithObjects:@"airbnb", nil];
    NSArray *map = [[NSArray alloc ]initWithObjects:@"apple-maps", @"google-maps", @"foursquare", nil];
    
    [contexts setObject:food forKey:@"food"];
    [contexts setObject:ride forKey:@"ride"];
    [contexts setObject:map forKey:@"map"];
    [contexts setObject:stay forKey:@"stay"];
    
    matchedContexts = [[NSArray alloc]initWithObjects:@"food", @"ride", @"map", @"stay", nil];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    NSArray *contexts = [self seq_context_query:searchText];
    matchedContexts = [[NSArray alloc] initWithArray:contexts];
    
    
    searchText = [searchBar text];
    NSLog(@"%@", [searchBar text]);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int numItems = 0;
    
    for(int i = 0; i < matchedContexts.count; i++) {
        numItems += [[contexts objectForKey:[matchedContexts objectAtIndex:i] ]count];
    }
    
    NSLog(@"numitems = %d", numItems);
    
    return numItems;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    NSMutableArray *contextApps = [[NSMutableArray alloc]init];
    for(int i = 0; i < matchedContexts.count; i++) {
        [contextApps addObjectsFromArray:[contexts objectForKey:[matchedContexts objectAtIndex:i]]];
    }
    
    NSString *appName = [contextApps objectAtIndex:[indexPath row]];
    
    
    [[cell textLabel]setText:[self cellTextForAppName:appName]];
    [[cell detailTextLabel]setText:[self cellDetailTextForAppName:appName]];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = backView;
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *appName = [[cell textLabel]text];
    
    [self openSchemeForAppName:appName withQuery:[searchBar text]];
    
}

-(NSString *)cellDetailTextForAppName:(NSString *)appName {
    
    if([appName isEqualToString:@"yelp"]) {
        //return [NSString stringWithFormat:@"Find reviews for %@", [searchBar text]];
        return @"Find reviews on yelp";
    }
    
    else if([appName isEqualToString:@"opentable"]) {
        return @"Book this restaurant in opentable";
    }
    
    else if([appName isEqualToString:@"lyft"]) {
        return @"Get here with Lyft";
    }
    
    else if([appName isEqualToString:@"uber"]) {
        return @"Get here with Uber";
    }
    
    else if([appName isEqualToString:@"apple-maps"]) {
        return @"Get directions with Apple maps";
    }
    
    else if([appName isEqualToString:@"google-maps"]) {
        return @"Get directions with google maps";
    }
    
    else if([appName isEqualToString:@"airbnb"]) {
        return @"Find a place to stay with airbnb";
    }
    
    else if([appName isEqualToString:@"foursquare"]) {
        return @"Open this place in foursquare";
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
    
    else if([appName isEqualToString:@"apple-maps"]) {
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
    
    
    else ;
    
    return nil;
    
    
}

- (void)openSchemeForAppName:(NSString *)appName withQuery:(NSString *)query {
    
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
    
    else if([appName isEqualToString:@"apple-maps"]) {
        [AppSwitch launchAppleMapsWithSearchQuery:query];
    }
    
    else if([appName isEqualToString:@"google-maps"]) {
        [AppSwitch launchGoogleMapsWithSearchQuery:query];
    }
    
    else if([appName isEqualToString:@"foursquare"]) {
        
        NSString *venueID = [Foursquare getVenueIDForSearchQuery:query];
        
        [AppSwitch launchFoursquareWithVenueID:venueID];
    }
    
    else if([appName isEqualToString:@"airbnb"]) {
        NSArray *rooms = [Airbnb getAirbnbRoomsForLocation:query];
        [AppSwitch launchAirbnbWithRoomID:[rooms objectAtIndex:0]];
    }
    
    
    else ;

}

- (NSArray *) seq_context_query:(NSString *)query {
    
    NSString *urlString = @"http://seqnlp.herokuapp.com/?q=";
    urlString = [urlString stringByAppendingString:query];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    return [json objectForKey:@"contexts"];
    
}

+ (NSString *)getSearchBarText {
    return searchText;
}


@end

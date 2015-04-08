//
//  ViewController.h
//  seq
//
//  Copyright (c) 2014 Bitpass, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate ,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

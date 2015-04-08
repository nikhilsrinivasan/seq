//
//  ViewController.m
//  seq
//
//  Copyright (c) 2014 Bitpass, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tableView;
@synthesize searchBar;

- (void)viewDidLoad
{
    
    // Light content status bar
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self setupTableView];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark view setup
// Status bar light content
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

// Set up tableView
- (void)setupTableView {
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
}

#pragma mark tableView delegate + datasource methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"seqCell"];
    
    if(cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"seqCell"];
    
    [[cell textLabel]setText:@"test"];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark searchBar

@end

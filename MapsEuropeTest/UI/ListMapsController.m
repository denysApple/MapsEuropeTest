//
//  ViewController.m
//  MapsEuropeTest
//
//  Created by Denys on 24.06.2023.
//

#import "ListMapsController.h"
#import <UIKit/UIKit.h>
#import "UIColors.h"


@implementation ListMapsController


- (instancetype)init {
    self = [super init];
    self.tableView = [[UITableView alloc] initWithFrame: self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.title = @"Download maps";
    self.navigationController.navigationBar.prefersLargeTitles = true;
    self.navigationController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    self.navigationController.view.backgroundColor = [UIColors mainColor];
    self.tableView.backgroundColor = [UIColors backgroundColor];
    
    self.mapsManager = [[MapsManager alloc] init];
    [self.mapsManager fetchMaps];
    [self.tableView reloadData];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.mapsManager.maps.count;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.mapsManager.maps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Row %@", self.mapsManager.maps[indexPath.row]];
    
    return cell;
}

@end

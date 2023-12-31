//
//  ListRegionsController.m
//  MapsEuropeTest
//
//  Created by Denys on 28.06.2023.
//

#import "ListRegionsController.h"
#import <UIKit/UIKit.h>
#import "UIColors.h"
#import "CapitalizeFirstLetter.h"
#import "MapCell.h"


@implementation ListRegionsController

- (instancetype)initWithRegion:(Region *)region networkManager:(NetworkManager *)networkManager{
    self = [super init];
    if (self) {
        _selectedRegion = region;
        _networkManager = networkManager;
    }
    self.tableView = [[UITableView alloc] initWithFrame: self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.title = [self.selectedRegion.name stringByCapitalizingFirstLetter];
    self.navigationController.navigationBar.prefersLargeTitles = true;
    self.navigationController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    self.navigationController.view.backgroundColor = [UIColors mainColor];
    self.tableView.backgroundColor = [UIColors backgroundColor];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.selectedRegion.subregions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MapCell *cell = [tableView dequeueReusableCellWithIdentifier:MapCellIdentifier];
    Region *region = self.selectedRegion.subregions[indexPath.row];
    if (cell == nil) {
        cell = [[MapCell alloc] initWithRegion:region networkManager:_networkManager];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Region *region = self.selectedRegion.subregions[indexPath.row];
    if (region.subregions.count > 0) {
        ListRegionsController *viewController = [[ListRegionsController alloc] initWithRegion:region networkManager:_networkManager];
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        
    }
}

@end

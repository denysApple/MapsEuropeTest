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


@implementation ListRegionsController

- (instancetype)initWithRegion:(Region *)region {
    self = [super init];
    if (self) {
        self.selectedRegion = region;
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
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *regionName = self.selectedRegion.subregions[indexPath.row].name;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [regionName stringByCapitalizingFirstLetter]];
    
    return cell;
}

@end

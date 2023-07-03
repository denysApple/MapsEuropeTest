//
//  ViewController.m
//  MapsEuropeTest
//
//  Created by Denys on 24.06.2023.
//

#import "ListCountriesController.h"
#import "ListRegionsController.h"
#import <UIKit/UIKit.h>
#import "UIColors.h"
#import "CapitalizeFirstLetter.h"
#import "MapCell.h"


@implementation ListCountriesController

UILabel *progressLeftLabel;
UILabel *progressRightLabel;

- (instancetype)init {
    self = [super init];
    self.networkManager = [[NetworkManager alloc] init];
    self.view.backgroundColor = UIColor.whiteColor;
    self.tableView = [[UITableView alloc] initWithFrame: self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];
    
    self.title = @"Download maps";
    self.navigationController.navigationBar.prefersLargeTitles = true;
    self.navigationController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    self.navigationController.view.backgroundColor = [UIColors mainColor];
    self.tableView.backgroundColor = [UIColors backgroundColor];
    
    // Set constraints
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:160],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
    ]];
    [self setMemoryView];
    
    [self deviceStorageInformation];
    self.mapsManager = [[MapsManager alloc] init];
    [self.mapsManager fetchMaps];
    return self;
}

- (void)setMemoryView {
    // Create progress view
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.translatesAutoresizingMaskIntoConstraints = NO;
    self.progressView.backgroundColor = UIColors.backgroundColor;
    self.progressView.progressTintColor = UIColors.mainColor;

    [self.view addSubview:self.progressView];
    self.progressView.clipsToBounds = true;
    self.progressView.layer.cornerRadius = 13;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.progressView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:25],
        [self.progressView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
        [self.progressView.heightAnchor constraintEqualToConstant:27],
        [self.progressView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20]
    ]];
    
    // Add the label
    progressLeftLabel = [[UILabel alloc] init];
    progressLeftLabel.textAlignment = NSTextAlignmentCenter;
    progressLeftLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:progressLeftLabel];
    progressLeftLabel.translatesAutoresizingMaskIntoConstraints = NO;
    progressLeftLabel.text = @"Device Memory";

    [NSLayoutConstraint activateConstraints:@[
        [progressLeftLabel.leadingAnchor constraintEqualToAnchor:self.progressView.leadingAnchor],
        [progressLeftLabel.topAnchor constraintEqualToAnchor:self.progressView.topAnchor constant:-20]
    ]];
    
    progressRightLabel = [[UILabel alloc] init];
    progressRightLabel.textAlignment = NSTextAlignmentCenter;
    progressRightLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:progressRightLabel];
    progressRightLabel.translatesAutoresizingMaskIntoConstraints = NO;
    progressRightLabel.text = @"Free 0 GB";
    progressRightLabel.textAlignment = NSTextAlignmentRight;

    [NSLayoutConstraint activateConstraints:@[
        [progressRightLabel.trailingAnchor constraintEqualToAnchor:self.progressView.trailingAnchor],
        [progressRightLabel.topAnchor constraintEqualToAnchor:self.progressView.topAnchor constant:-20]
    ]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
}

- (void)deviceStorageInformation {
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemFreeSize];
        NSNumber *totalFileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        
        double totalSpace = [totalFileSystemSizeInBytes doubleValue];
        double freeSpace = [freeFileSystemSizeInBytes doubleValue];
        double freeGbs = freeSpace / (double)1073741824;
        double usedSpace = totalSpace - freeSpace;
        
        // Calculate used space percentage
        float usedSpacePercent = usedSpace / totalSpace;

        // Update progress view
        [self.progressView setProgress:usedSpacePercent animated:YES];
        progressRightLabel.text = [NSString stringWithFormat:@"Free %.2f GB", freeGbs];
        
    } else {
        // Handle error
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.mapsManager.regions.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Region *superRegion = self.mapsManager.regions[section];
    return superRegion.subregions.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Region *region = self.mapsManager.regions[section];
    return [NSString stringWithFormat:@"%@", [region.displayName stringByCapitalizingFirstLetter]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MapCell *cell = [tableView dequeueReusableCellWithIdentifier:MapCellIdentifier];
    Region *superRegion = self.mapsManager.regions[indexPath.section];
    Region *region = superRegion.subregions[indexPath.row];
    if (cell == nil) {
        cell = [[MapCell alloc] initWithRegion:region networkManager:_networkManager];
    } else {
        [cell updateUI:region];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Region *superRegion = self.mapsManager.regions[indexPath.section];
    Region *region = superRegion.subregions[indexPath.row];
    if (region.subregions.count > 0) {
        ListRegionsController *viewController = [[ListRegionsController alloc] initWithRegion:region networkManager:_networkManager];
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        
    }
}

@end

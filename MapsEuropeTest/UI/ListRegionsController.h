//
//  ListRegionsController.h
//  MapsEuropeTest
//
//  Created by Denys on 28.06.2023.
//

#import <UIKit/UIKit.h>
#import "MapsManager.h"
#import "NetworkManager.h"

@interface ListRegionsController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) Region *selectedRegion;
@property (nonatomic, strong) NetworkManager *networkManager;

- (instancetype)initWithRegion:(Region *)region networkManager:(NetworkManager *)networkManager;

@end

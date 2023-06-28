//
//  ListRegionsController.h
//  MapsEuropeTest
//
//  Created by Denys on 28.06.2023.
//

#import <UIKit/UIKit.h>
#import "MapsManager.h"

@interface ListRegionsController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) Region *selectedRegion;

- (instancetype)initWithRegion:(Region *)region;

@end

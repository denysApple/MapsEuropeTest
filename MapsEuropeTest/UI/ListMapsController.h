//
//  ViewController.h
//  MapsEuropeTest
//
//  Created by Denys on 24.06.2023.
//

#import <UIKit/UIKit.h>
#import "MapsManager.h"

@interface ListMapsController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) MapsManager *mapsManager;

@end


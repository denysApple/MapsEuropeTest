//
//  ViewController.h
//  MapsEuropeTest
//
//  Created by Denys on 24.06.2023.
//

#import <UIKit/UIKit.h>
#import "MapsManager.h"
#import "NetworkManager.h"
#import "StorageService.h"

@interface ListCountriesController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIProgressView *progressView;
@property (nonatomic, strong) MapsManager *mapsManager;
@property (nonatomic, strong) NetworkManager *networkManager;

@end


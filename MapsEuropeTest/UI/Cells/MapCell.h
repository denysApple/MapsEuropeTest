//
//  MapCell.h
//  MapsEuropeTest
//
//  Created by Denys on 28.06.2023.
//

#import <UIKit/UIKit.h>
#import "MapCell.h"
#import "Region.h"
#import "NetworkManager.h"
#import "StorageService.h"

extern NSString * const MapCellIdentifier;

@interface MapCell : UITableViewCell

@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) UIImageView *leftImageView;
@property (strong, nonatomic) UILabel *mainLabel;
@property (strong, nonatomic) UIButton *rightImageView;
@property (nonatomic, strong) Region *selectedRegion;
@property (nonatomic, strong) NetworkManager *networkManager;

- (instancetype)initWithRegion:(Region *)region networkManager:(NetworkManager *)networkManager;
-(void)updateUI:(Region *)region;
-(void)showDownloaded;

@end

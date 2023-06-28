//
//  MapCell.h
//  MapsEuropeTest
//
//  Created by Denys on 28.06.2023.
//

#import <UIKit/UIKit.h>
#import "MapCell.h"
#import "Region.h"

extern NSString * const MapCellIdentifier;

@interface MapCell : UITableViewCell

@property (strong, nonatomic) UIImageView *leftImageView;
@property (strong, nonatomic) UILabel *mainLabel;
@property (strong, nonatomic) UIImageView *rightImageView;
@property (nonatomic, strong) Region *selectedRegion;

- (instancetype)initWithRegion:(Region *)region;
-(void)updateUI:(Region *)region;

@end

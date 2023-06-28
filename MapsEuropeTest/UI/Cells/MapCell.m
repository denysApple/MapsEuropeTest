//
//  MapCell.m
//  MapsEuropeTest
//
//  Created by Denys on 28.06.2023.
//

#import <Foundation/Foundation.h>
#import "MapCell.h"
#import "CapitalizeFirstLetter.h"

NSString * const MapCellIdentifier = @"MapCellIdentifier";

@implementation MapCell

- (instancetype)initWithRegion:(id)region {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MapCellIdentifier];
    _selectedRegion = region;
    if (self) {
        [self setupUI];
    }
    [self updateUI:region];
    return self;
}

- (void)setupUI {
    self.leftImageView = [[UIImageView alloc] init];
    self.mainLabel = [[UILabel alloc] init];
    self.rightImageView = [[UIImageView alloc] init];
    
    self.leftImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.mainLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.rightImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.mainLabel];
    [self.contentView addSubview:self.rightImageView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.leftImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:15],
        [self.leftImageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.leftImageView.widthAnchor constraintEqualToConstant:40],
        [self.leftImageView.heightAnchor constraintEqualToConstant:40],
        
        [self.mainLabel.leadingAnchor constraintEqualToAnchor:self.leftImageView.trailingAnchor constant:15],
        [self.mainLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.mainLabel.trailingAnchor constraintEqualToAnchor:self.rightImageView.leadingAnchor constant:-15],
        
        [self.rightImageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-15],
        [self.rightImageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.rightImageView.widthAnchor constraintEqualToConstant:40],
        [self.rightImageView.heightAnchor constraintEqualToConstant:40]
    ]];
}

-(void)updateUI:(Region *)region {
    self.leftImageView.image = [UIImage imageNamed:@"ic_custom_map"];
    self.mainLabel.text = [NSString stringWithFormat:@"%@", [region.displayName stringByCapitalizingFirstLetter]];
    if (region.subregions.count > 0) {
        self.rightImageView.image = [UIImage imageNamed:@"ic_custom_chevron"];
    } else {
        self.rightImageView.image = nil;
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
//    [self updateUI:sele];
}

@end

//
//  MapCell.m
//  MapsEuropeTest
//
//  Created by Denys on 28.06.2023.
//

#import <Foundation/Foundation.h>
#import "MapCell.h"
#import "CapitalizeFirstLetter.h"
#import "UIColors.h"

NSString * const MapCellIdentifier = @"MapCellIdentifier";

@implementation MapCell

- (instancetype)initWithRegion:(Region *)region networkManager:(NetworkManager *)networkManager {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MapCellIdentifier];
    if (self) {
        _selectedRegion = region;
        _networkManager = networkManager;
        [self setupUI];
    }
    [self updateUI:region];
    return self;
}

- (void)setupUI {
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.translatesAutoresizingMaskIntoConstraints = NO;
    self.progressView.backgroundColor = UIColors.backgroundColor;
    self.progressView.progressTintColor = UIColors.mainColor;

    [self.contentView addSubview:self.progressView];
    self.progressView.clipsToBounds = true;
    self.progressView.layer.cornerRadius = 2;
    
    self.leftImageView = [[UIImageView alloc] init];
    self.mainLabel = [[UILabel alloc] init];
    self.rightImageView = [[UIButton alloc] init];
    
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
    [self.rightImageView addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.progressView.topAnchor constraintEqualToAnchor:self.mainLabel.bottomAnchor constant: 3],
        [self.progressView.leadingAnchor constraintEqualToAnchor:self.mainLabel.leadingAnchor],
        [self.progressView.heightAnchor constraintEqualToConstant:5],
        [self.progressView.trailingAnchor constraintEqualToAnchor:self.rightImageView.leadingAnchor constant:-7],
        [self.progressView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-3]
    ]];
    [self.progressView setHidden:YES];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.rightImageView setEnabled:YES];
}

- (void)buttonClicked:(UIButton *)sender {
    NSURL *url = _selectedRegion.url;
    if (![_networkManager.storageManager.urls containsObject:url] && _selectedRegion.subregions.count <= 0 && url != nil && _networkManager.isBusy == false) {
        [self.progressView setHidden:NO];
        NSLog(@"Clicked to download %@", _selectedRegion.url);
        [_networkManager downloadFileFromURL:url withProgress:^(double progress) {
            // This block is called to update the progress of the download.
            // 'progress' is a value between 0.0 and 1.0 representing the progress of the download.
            // You can use this to update a progress bar or other UI element.
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.rightImageView setImage:nil forState:UIControlStateNormal];
                [self.progressView setHidden:NO];
                NSLog(@"progress %f", progress);
                self.progressView.progress = progress;
            });
        } completion:^(NSURL *location, NSError *error) {
            // This block is called when the download is complete.
            // 'location' is the URL where the downloaded file can be found.
            // 'error' is an NSError object that will be non-nil if an error occurred.
            [self.progressView setHidden:YES];
            [self showDownloaded];
            if (error) {
                NSLog(@"Download failed with error: %@", error.localizedDescription);
            } else {
                NSLog(@"Download complete. File located at: %@", location);
            }
        }];
    }
}

-(void)updateUI:(Region *)region {
    NSURL *url = _selectedRegion.url;
    _selectedRegion = region;
    self.leftImageView.image = [UIImage imageNamed:@"ic_custom_map"];
    self.mainLabel.text = [NSString stringWithFormat:@"%@", [region.displayName stringByCapitalizingFirstLetter]];
    if ([_networkManager.storageManager.urls containsObject:url]) {
        [self showDownloaded];
    } else if (region.subregions.count > 0) {
        [self.rightImageView setImage:[UIImage imageNamed:@"ic_custom_chevron"] forState:UIControlStateNormal];
        [self.rightImageView setEnabled:NO];
        
    } else if ([region.map.lowercaseString isEqualToString:@"yes"] || [region.type isEqualToString:@"map"] ) {
        [self.rightImageView setImage:[UIImage imageNamed:@"ic_custom_dowload"] forState:UIControlStateNormal];
        
    } else {
        [self.rightImageView setImage:nil forState:UIControlStateNormal];
    }
}

-(void)showDownloaded {
    [self.rightImageView setImage:[UIImage systemImageNamed:@"checkmark"] forState:UIControlStateNormal];
    [self.rightImageView setEnabled:NO];
}

@end

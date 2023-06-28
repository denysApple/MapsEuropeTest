//
//  Region.h
//  MapsEuropeTest
//
//  Created by Denys on 25.06.2023.
//
#import <Foundation/Foundation.h>

@interface Region : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *map;
@property (nonatomic, strong) NSString *translate;

@property (nonatomic, strong) NSString *innerDownloadSuffix;
@property (nonatomic, strong) NSString *innerDownloadPrefix;
@property (nonatomic, strong) NSString *downloadPrefix;
@property (nonatomic, strong) NSString *downloadSuffix;

@property (nonatomic, strong) NSString *boundary;
@property (nonatomic, strong) NSString *polyExtract;
@property (nonatomic, strong) NSMutableArray<Region *> *subregions;
@property (nonatomic, strong) NSString *lang;
@property (nonatomic, strong) NSString *wiki;
@property (nonatomic, strong) NSString *roads;
@property (nonatomic, strong) NSString *left_hand_navigation;

//CUSTOM VARS
@property (nonatomic, strong) NSDictionary *source;
@property (nonatomic, strong) NSString *displayName;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
- (void)addSubregion:(Region *)region;

- (NSURL *)url;

@end

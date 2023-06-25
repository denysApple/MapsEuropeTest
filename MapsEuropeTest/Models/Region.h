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
@property (nonatomic, strong) NSString *translate;
@property (nonatomic, strong) NSString *innerDownloadSuffix;
@property (nonatomic, strong) NSString *boundary;
@property (nonatomic, strong) NSString *polyExtract;
@property (nonatomic, strong) NSMutableArray<Region *> *subregions;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
- (void)addSubregion:(Region *)region;

@end

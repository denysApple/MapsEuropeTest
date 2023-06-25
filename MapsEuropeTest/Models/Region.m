//
//  Region.m
//  MapsEuropeTest
//
//  Created by Denys on 25.06.2023.
//

#import <Foundation/Foundation.h>
#import "Region.h"

@implementation Region

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        _type = attributes[@"type"];
        _name = attributes[@"name"];
        _translate = attributes[@"translate"];
        _innerDownloadSuffix = attributes[@"inner_download_suffix"];
        _boundary = attributes[@"boundary"];
        _polyExtract = attributes[@"poly_extract"];
        _subregions = [NSMutableArray new];
    }
    return self;
}

- (void)addSubregion:(Region *)region {
    [self.subregions addObject:region];
}

@end

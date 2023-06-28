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
        _translate = attributes[@"translate"];
        if (_translate != NULL && [_translate rangeOfString:@"en="].location != NSNotFound) {
            // Split the string on the ';' character
            NSArray *components = [_translate componentsSeparatedByString:@";"];

            // Split the first component on the '=' character
            NSArray *nameComponents = [components[0] componentsSeparatedByString:@"="];

            // Get the second part as the name
//            NSLog(@"nameComponents %@", nameComponents);
            _displayName = nameComponents[1];
        } else {
            _displayName = attributes[@"name"];
            _name = attributes[@"name"];
        }
        _innerDownloadSuffix = attributes[@"inner_download_suffix"];
        _boundary = attributes[@"boundary"];
        _polyExtract = attributes[@"poly_extract"];
        _subregions = [NSMutableArray new];
    } else {
        NSLog(@"%@", attributes);
        int* new = 1;
    }
    return self;
}

- (void)addSubregion:(Region *)region {
    [self.subregions addObject:region];
}

@end

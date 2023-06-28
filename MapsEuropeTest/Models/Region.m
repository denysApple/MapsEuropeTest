//
//  Region.m
//  MapsEuropeTest
//
//  Created by Denys on 25.06.2023.
//

#import <Foundation/Foundation.h>
#import "Region.h"
#import "CapitalizeFirstLetter.h"

@implementation Region

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        _source = attributes;
        _type = attributes[@"type"];
        if (attributes[@"map"] == nil) {
            _map = @"yes";
        } else {
            _map = attributes[@"map"];
        }
        _translate = attributes[@"translate"];
        NSArray *components = [_translate componentsSeparatedByString:@";"];
        if (_translate != nil && [_translate rangeOfString:@"en="].location != NSNotFound && components.count > 0) {
            NSArray *nameComponents = [components[0] componentsSeparatedByString:@"="];
            _displayName = nameComponents[1];
        } else {
            _displayName = attributes[@"name"];
        }
        _name = attributes[@"name"];
        
        _innerDownloadPrefix = attributes[@"inner_download_prefix"];
        _innerDownloadSuffix = attributes[@"inner_download_suffix"];
        
        _downloadPrefix = attributes[@"download_prefix"];
        _downloadSuffix = attributes[@"download_suffix"];
        if ([_innerDownloadPrefix isEqualToString:@"$name"]) {
            _innerDownloadPrefix = attributes[@"name"];;
        }
        if ([_innerDownloadSuffix isEqualToString:@"$name"]) {
            _innerDownloadSuffix = attributes[@"name"];;
        }
        if ([_downloadPrefix isEqualToString:@"$name"]) {
            _downloadPrefix = attributes[@"name"];;
        }
        if ([_downloadSuffix isEqualToString:@"$name"]) {
            _downloadSuffix = attributes[@"name"];;
        }
        
        _boundary = attributes[@"boundary"];
        _polyExtract = attributes[@"poly_extract"];
        _lang = attributes[@"lang"];
        _wiki = attributes[@"wiki"];
        _roads = attributes[@"roads"];
        _subregions = [NSMutableArray new];
    } else {
        NSLog(@"%@", attributes);
    }
    return self;
}

- (void)addSubregion:(Region *)region {
    if (![self.subregions containsObject:region]) {
        [self.subregions addObject:region];
    }
}

- (NSURL *)url {
    NSString *mapName = @"";
    NSString *prefix = @"";
    NSString *suffix = @"";
    if (_downloadPrefix != nil) {
        prefix = _downloadPrefix;
    } else if (_innerDownloadPrefix != nil && _innerDownloadPrefix != _name) {
        prefix = _innerDownloadPrefix;
    }
    if (_downloadSuffix != nil) {
        suffix = _downloadSuffix;
    } else if (_innerDownloadSuffix != nil && _innerDownloadSuffix != _name) {
        suffix = _innerDownloadSuffix;
    }
    if (prefix > 0 && suffix.length > 0) {
        mapName = [NSString stringWithFormat:@"%@_%@_%@", prefix, _name, suffix];
    } else if (prefix.length > 0) {
        mapName = [NSString stringWithFormat:@"%@_%@", prefix, _name];
    } else if (suffix.length > 0) {
        mapName = [NSString stringWithFormat:@"%@_%@", _name, suffix];
    } else {
        mapName = [NSString stringWithFormat:@"%@", _name];
    }
    NSString *string = [NSString stringWithFormat:@"http://download.osmand.net/download.php?standard=yes&file=%@_2.obf.zip", [mapName stringByCapitalizingFirstLetter]];
    return [NSURL URLWithString:string];
}

@end

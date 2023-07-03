//
//  StorageService.m
//  MapsEuropeTest
//
//  Created by Denys on 03.07.2023.
//

#import <Foundation/Foundation.h>
#import "StorageService.h"

static NSString *const kStoredURLsKey = @"StoredURLsKey";

@implementation StorageService

- (instancetype)init {
    self = [super init];
    [self loadURLs];
    return self;
}

- (void)saveURLs:(NSArray<NSURL *> *)urls {
    NSMutableArray *urlStrings = [NSMutableArray arrayWithCapacity:urls.count];
    for (NSURL *url in urls) {
        [urlStrings addObject:url.absoluteString];
    }
    [[NSUserDefaults standardUserDefaults] setObject:urlStrings forKey:kStoredURLsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self updateUrls];
}

- (void)saveURL:(NSURL *)url {
    NSMutableArray *urls = [[self loadURLs] mutableCopy];
    [urls addObject:url];
    [self saveURLs:urls];
}

- (NSArray<NSURL *> *)loadURLs {
    NSArray *urlStrings = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredURLsKey];
    
    if (urlStrings) {
        NSMutableArray *urls = [NSMutableArray arrayWithCapacity:urlStrings.count];
        for (NSString *urlString in urlStrings) {
            NSURL *url = [NSURL URLWithString:urlString];
            if (url) {
                [urls addObject:url];
            }
        }
        _urls = urls;
        return urls;
    } else {
        _urls = @[];
        return @[];
    }
}

-(void)updateUrls {
    NSArray *urls = [self loadURLs];
    self.urls = urls;
}

@end

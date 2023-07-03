//
//  StorageService.h
//  MapsEuropeTest
//
//  Created by Denys on 03.07.2023.
//

#import <Foundation/Foundation.h>

@interface StorageService : NSObject

@property (nonatomic, strong) NSArray<NSURL *> *urls;

- (void)saveURLs:(NSArray<NSURL *> *)urls;
- (void)saveURL:(NSURL *)url;
- (NSArray<NSURL *> *)loadURLs;

@end

//
//  NetworkService.m
//  MapsEuropeTest
//
//  Created by Denys on 24.06.2023.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"

@implementation NetworkManager

- (instancetype)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSOperationQueue *delegateQueue = [[NSOperationQueue alloc] init];
        delegateQueue.name = @"com.mapsEuropeTestTask.networkqueue";
        delegateQueue.maxConcurrentOperationCount = 1;
        
        self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:delegateQueue];
    }
    return self;
}

- (void)downloadFileFromURL:(NSURL *)url withProgress:(void(^)(double progress))progressBlock completion:(void(^)(NSURL *location, NSError *error))completionBlock {
    self.progressBlock = progressBlock;
    self.completionBlock = completionBlock;

    // Create download task
    NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithURL:url];
    
    // Start download task
    [downloadTask resume];
}

#pragma mark - NSURLSessionDownloadDelegate methods

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    if (self.progressBlock) {
        double progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressBlock(progress);
        });
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    if (self.completionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completionBlock(location, nil);
        });
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error && self.completionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completionBlock(nil, error);
        });
    }
}

@end

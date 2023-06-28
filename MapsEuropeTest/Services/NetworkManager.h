// NetworkManager.h
#import <Foundation/Foundation.h>
#import "Region.h"

@interface NetworkManager : NSObject <NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, assign) BOOL isBusy;
@property (nonatomic, copy) void(^progressBlock)(double progress);
@property (nonatomic, copy) void(^completionBlock)(NSURL *location, NSError *error);

- (void)downloadFileFromURL:(NSURL *)url withProgress:(void(^)(double progress))progressBlock completion:(void(^)(NSURL *location, NSError *error))completionBlock;

@end

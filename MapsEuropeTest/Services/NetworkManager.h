// NetworkService.h
#import <Foundation/Foundation.h>

@interface NetworkService : NSObject <NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, copy) void(^progressBlock)(double progress);
@property (nonatomic, copy) void(^completionBlock)(NSURL *location, NSError *error);
// Method to download file
- (void)downloadFileFromURL:(NSURL *)url withProgress:(void(^)(double progress))progressBlock completion:(void(^)(NSURL *location, NSError *error))completionBlock;

@end

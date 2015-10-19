//
//  LZDownLoadRequest.m
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZDownLoadRequest.h"


@interface LZDownLoadRequest ()<NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, assign) CGFloat total;
@property (nonatomic, strong) NSData *resumeData;
@property (nonatomic, assign) int64_t totalWrite;
@end

@implementation LZDownLoadRequest

- (void)downloadRequest:(NSString *)path delegate:(id<LZDownloadRequestDelegate>)delegate{
    self.delegate = delegate;
    self.total = 8227324;
    self.totalWrite = 0;
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *pathURL = [NSURL URLWithString:path];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:queue];
    self.session = session;
    
    NSURLSessionDownloadTask *downloadTask =[session downloadTaskWithURL:pathURL];
    self.downloadTask = downloadTask;
    [downloadTask resume];
}

- (void)downloadRequestPause{
    
    [self.downloadTask cancelByProducingResumeData:^(NSData *resumeData) {
        self.resumeData = resumeData;
    }];
}

- (void)downloadRequestRsume{
    
    self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
    [self.downloadTask resume];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    self.totalWrite = self.totalWrite + bytesWritten;
    self.progress = self.totalWrite / self.total * 100;
    NSLog(@"downloadtask: %d", downloadTask == self.downloadTask);
    if ([self.delegate respondsToSelector:@selector(downloadRequestDidRecieveData:)]) {
        [self.delegate downloadRequestDidRecieveData:self];
    }
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"download path: %@", location.path);
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"猜猜这首歌叫啥名.mp3"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:path error:nil];
    self.filePath = path;
    if ([self.delegate respondsToSelector:@selector(downloadRequestDidFinish:)]) {
        [self.delegate downloadRequestDidFinish:self];
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}
@end

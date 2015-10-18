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
@end

@implementation LZDownLoadRequest

- (void)downloadRequest:(NSString *)path delegate:(id<LZDownloadRequestDelegate>)delegate{
    self.delegate = delegate;
    self.total = 8227324;
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *pathURL = [NSURL URLWithString:path];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
//    self.session = session;
    
    NSURLSessionDownloadTask *downloadTask =[session downloadTaskWithURL:pathURL];
//    self.downloadTask = downloadTask;
    [downloadTask resume];
}



- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    self.progress = totalBytesWritten / self.total * 100;
    
    if ([self.delegate respondsToSelector:@selector(downloadRequestDidRecieveData:)]) {
        [self.delegate downloadRequestDidRecieveData:self];
    }
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    if ([self.delegate respondsToSelector:@selector(downloadRequestDidFinish:)]) {
        [self.delegate downloadRequestDidFinish:self];
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}
@end

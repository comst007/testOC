//
//  LZDownLoadRequest.h
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class LZDownLoadRequest;

@protocol LZDownloadRequestDelegate <NSObject>

- (void)downloadRequestDidRecieveData:(LZDownLoadRequest *)downloadRequest;

- (void)downloadRequestDidFinish:(LZDownLoadRequest *)downloadReques;

@end


@interface LZDownLoadRequest : NSObject

@property (nonatomic, copy) NSString *filePath;

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, weak) id<LZDownloadRequestDelegate> delegate;

- (void)downloadRequest:(NSString *)path delegate:(id<LZDownloadRequestDelegate>)delegate;

- (void)downloadRequestPause;

- (void)downloadRequestRsume;

@end

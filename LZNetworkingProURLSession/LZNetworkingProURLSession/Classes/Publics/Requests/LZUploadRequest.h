//
//  LZUploadRequest.h
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/20.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LZUploadRequest ;

typedef void (^uploadCompletionHandler)(LZUploadRequest *uploadRequest);



@interface LZUploadRequest : NSObject


@property (nonatomic, strong) NSData* data;
@property (nonatomic, strong) NSHTTPURLResponse *httpResponse;
@property (nonatomic, strong) NSError *requestError;


- (void)uploadRequestWithData:(NSData *)uploadData mimeType:(NSString *)fileType completionHandler:(uploadCompletionHandler)handle;

@end

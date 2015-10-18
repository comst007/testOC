//
//  LZLoginRequest.h
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZLoginRequest;

typedef void (^loginCompletionHandler)(LZLoginRequest *loginrequest);

@interface LZLoginRequest : UIView

@property (nonatomic, strong) NSData *responseData;
@property (nonatomic, strong) NSHTTPURLResponse *httpResponse;
@property (nonatomic, strong) NSError *connectionError;

- (void)loginRequestWithUsername:(NSString *)username password:(NSString *)password completionHandler:(loginCompletionHandler)handle;

@end

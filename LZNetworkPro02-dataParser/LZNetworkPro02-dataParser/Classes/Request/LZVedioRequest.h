//
//  LZVedioRequest.h
//  LZNetworkPro02-dataParser
//
//  Created by comst on 15/10/14.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^requestCompleteBock)(NSData *recvData, NSError *error);

@interface LZVedioRequest : NSObject
- (void)sendVedioRequest:(NSString *)urlString completeHandler:(requestCompleteBock)handleBlock;
@end

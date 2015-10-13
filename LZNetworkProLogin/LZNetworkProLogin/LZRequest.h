//
//  LZRequest.h
//  LZNetworkProLogin
//
//  Created by comst on 15/10/14.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZRequest : NSObject

- (void)sendRequest:(NSString *)username password:(NSString *)password;
@end

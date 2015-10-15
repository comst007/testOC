//
//  LZRequest.h
//  LZNetworkingProSecurity
//
//  Created by comst on 15/10/16.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^loginCompleteBlock)(NSURLResponse *response, NSData *data);

@interface LZRequest : NSObject

- (void)loginRequestWithName:(NSString *)username password:(NSString *)password completionHandler:(loginCompleteBlock)handler;
@end

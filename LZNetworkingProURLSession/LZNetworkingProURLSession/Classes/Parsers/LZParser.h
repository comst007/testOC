//
//  LZParser.h
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/19.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZUserInfo.h"
@interface LZParser : NSObject

- (LZUserInfo *)parseUserinfoFromJsonData:(NSData *)source;

@end

//
//  NSString+LZCoding.h
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LZCoding)

- (NSString *)encodeToBase64String;

- (NSString *)decodeFromBase64String;
@end

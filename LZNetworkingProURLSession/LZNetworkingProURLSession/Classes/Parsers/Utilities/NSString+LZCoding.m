//
//  NSString+LZCoding.m
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "NSString+LZCoding.h"

@implementation NSString (LZCoding)

- (NSString *)encodeToBase64String{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    data = [data base64EncodedDataWithOptions:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)decodeFromBase64String{
    NSData *base64Data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [[NSData alloc] initWithBase64EncodedData:base64Data options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
@end

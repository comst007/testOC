//
//  LZMultipartForm.h
//  LZNetworkingPro03Upload
//
//  Created by comst on 15/10/14.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//
#define kLZBoundary  @"com.comst1314"
#import <Foundation/Foundation.h>

@interface LZMultipartForm : NSObject
@property (nonatomic, strong, readonly) NSData *httpBody;
@property (nonatomic, strong, readonly) NSString *httpBoundary;

- (void)addFile:(NSString *)filePath forField:(NSString *)field;

- (void)addArg:(NSString *)arg forField:(NSString *)field;
- (void)addData:(NSData *)data mimeType:(NSString *)type  forField:(NSString *)field ;
@end

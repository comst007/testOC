//
//  LZMultipartForm.m
//  LZNetworkingPro03Upload
//
//  Created by comst on 15/10/14.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMultipartForm.h"
#import "NSString+LZMIMETYPE.h"
#define kStartFrom  @"--"
#define kEndFrom    @"--"
#define kNewLine     @"\r\n"
#define encodeData(str) [(str) dataUsingEncoding:NSUTF8StringEncoding]

@interface LZMultipartForm ()

@property (nonatomic, strong) NSMutableData *bodyData;

@property (nonatomic, assign) BOOL  needLine;
@end
@implementation LZMultipartForm

- (NSData *)httpBody{
    NSMutableData *dataM = [NSMutableData data];
    [dataM appendData:self.bodyData];
    [dataM appendData:encodeData(kNewLine)];
    [dataM appendData:encodeData(kStartFrom)];
    [dataM appendData:encodeData(self.httpBoundary)];
    //[dataM appendData:encodeData(kEndFrom)];
    //[dataM appendData:encodeData(kNewLine)];
    return dataM;
}

- (NSMutableData *)bodyData{
    if (!_bodyData) {
        _bodyData = [[NSMutableData alloc] init];
    }
    return _bodyData;
}

- (NSString *)httpBoundary{
    return kLZBoundary;
}
/**
 *  -----------------------------11831781002123239127544245290
 Content-Disposition: form-data; name="userfile"; filename="hello.txt"
 Content-Type: text/plain
 
 hello world
 
 Welcome to CopyLess
 Welcome to CopyLess
 Welcome to CopyLess hello world
 hello world
 hello world
 hello world
 hello world
 hello world
 hello world
 hello world
 
 
 
 床前明月关
 床前明月关
 床前明月关
 床前明月关
 床前明月关
 hello world
 hello world
 床前明月关床前明月关
 床前明月关
 床前明月关床前明月关
 床前明月关床前明月关
 床前明月关
 -----------------------------11831781002123239127544245290--
 *
 *  @param filePath server端参数名
 *  @param field    要上传的文件名
 */

- (void)addFile:(NSString *)filePath forField:(NSString *)field{
    

    NSData *fileContent = [[NSData alloc] initWithContentsOfFile:filePath];
 
    
    [self addData:fileContent mimeType:[filePath mimeType] forField:field];
}

- (void)addData:(NSData *)data mimeType:(NSString *)type  forField:(NSString *)field{
    
    if (self.needLine == NO) {
        self.needLine = YES;
    }else{
        [self.bodyData appendData:encodeData(kNewLine)];
    }
    [self.bodyData appendData:encodeData(kStartFrom)];
    [self.bodyData appendData:encodeData(self.httpBoundary)];
    [self.bodyData appendData:encodeData(kNewLine)];
    
    NSString *postLine1 = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\" ", @"post.data"];
    [self.bodyData appendData:encodeData(postLine1)];
    [self.bodyData appendData:encodeData(kNewLine)];
    
    NSString *postLine2 = [NSString stringWithFormat: @"Content-Type: %@", type];
    
    [self.bodyData appendData:encodeData(postLine2)];
    [self.bodyData appendData:encodeData(kNewLine)];
    [self.bodyData appendData:encodeData(kNewLine)];
   
    [self.bodyData appendData:data];
}
- (void)addArg:(NSString *)arg forField:(NSString *)field{
    
    if (self.needLine == NO) {
        self.needLine = YES;
    }else{
        [self.bodyData appendData:encodeData(kNewLine)];
    }
    [self.bodyData appendData:encodeData(kStartFrom)];
    [self.bodyData appendData:encodeData(self.httpBoundary)];
    [self.bodyData appendData:encodeData(kNewLine)];
    
    NSString *postLine = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"", field ];
    [self.bodyData appendData:encodeData(postLine)];
    [self.bodyData appendData:encodeData(kNewLine)];
    [self.bodyData appendData:encodeData(kNewLine)];
    [self.bodyData appendData:encodeData(arg)];
    
}
@end

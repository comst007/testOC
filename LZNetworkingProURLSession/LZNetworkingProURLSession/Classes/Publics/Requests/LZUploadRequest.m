//
//  LZUploadRequest.m
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/20.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZUploadRequest.h"
#import "LZMultipartForm.h"
#import "NSString+LZMIMETYPE.h"
@implementation LZUploadRequest


- (void)uploadRequestWithData:(NSData *)uploadData mimeType:(NSString *)fileType completionHandler:(uploadCompletionHandler)handle{
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *URLString = @"http://120.24.236.135/Comst/post/upload.php";
    
   
    
    NSURL *URL = [NSURL URLWithString:URLString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    request.HTTPMethod = @"POST";
    
    LZMultipartForm *form = [[LZMultipartForm alloc] init];
    
   
    
    [form addData:uploadData mimeType:fileType forField:@"userfile"];
    
    NSString *headValue = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", form.httpBoundary];
    [request setValue:headValue forHTTPHeaderField:@"Content-Type"];
    
    
    
    
    NSURLSessionUploadTask  *uploadTask = [session uploadTaskWithRequest:request fromData:[form httpBody] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.data = data;
        self.requestError = error;
        self.httpResponse = (NSHTTPURLResponse *)response;
        
        handle(self);
    }];
    
    [uploadTask resume];
}

@end

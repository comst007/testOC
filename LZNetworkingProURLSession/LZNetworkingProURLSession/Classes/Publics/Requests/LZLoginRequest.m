//
//  LZLoginRequest.m
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZLoginRequest.h"
#import "NSString+LZCoding.h"
@implementation LZLoginRequest

- (void)loginRequestWithUsername:(NSString *)username password:(NSString *)password completionHandler:(loginCompletionHandler)handle{
    NSString *urlString = @"http://120.24.236.135/Comst/login2.php";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *loginURL = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *loginRequest = [[NSMutableURLRequest alloc] initWithURL:loginURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
    loginRequest.HTTPMethod = @"POST";
    
    NSString *postString = [NSString stringWithFormat:@"username=%@&password=%@", [username encodeToBase64String] , [password encodeToBase64String]];
    
    loginRequest.HTTPBody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionDataTask  *loginTask = [[NSURLSession sharedSession] dataTaskWithRequest:loginRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.httpResponse = (NSHTTPURLResponse *)response;
        self.connectionError = error;
        self.responseData = data;
        handle(self);
    }];
    
    
    [loginTask resume];
}
@end

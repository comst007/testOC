//
//  LZRequest.m
//  LZNetworkingProSecurity
//
//  Created by comst on 15/10/16.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZRequest.h"

@implementation LZRequest
- (void)loginRequestWithName:(NSString *)username password:(NSString *)password completionHandler:(loginCompleteBlock)handler{
    NSString *urlString = @"http://120.24.236.135/Comst/login2.php";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *loginURL = [[NSURL alloc] initWithString:urlString];
    
    NSMutableURLRequest *requestM = [[NSMutableURLRequest alloc] initWithURL:loginURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
    
    requestM.HTTPMethod = @"POST";
    NSString *bodyString = [NSString stringWithFormat:@"username=%@&password=%@", username, password];
    requestM.HTTPBody = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:requestM queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError == nil) {
            handler(response, data);
        }
        
    }];
}
@end

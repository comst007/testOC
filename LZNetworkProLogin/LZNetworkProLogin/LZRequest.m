//
//  LZRequest.m
//  LZNetworkProLogin
//
//  Created by comst on 15/10/14.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//
/**
 *  http://120.24.236.135/Comst/login.php?username=helllo&password=fff
 *
 *  @return <#return value description#>
 */
#import "LZRequest.h"

@implementation LZRequest

- (void)sendRequest:(NSString *)username password:(NSString *)password{
    NSString *urlString = @"http://120.24.236.135/Comst/login.php";
    urlString = [NSString stringWithFormat:@"%@?username=%@&password=%@", urlString, username, password];
    NSURL *requestURL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:requestURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (connectionError == nil && httpResponse.statusCode == 200) {
           
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", dict);
        }
    }];
}
@end

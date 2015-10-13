//
//  LZVedioRequest.m
//  LZNetworkPro02-dataParser
//
//  Created by comst on 15/10/14.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZVedioRequest.h"

@implementation LZVedioRequest

- (void)sendVedioRequest:(NSString *)urlString completeHandler:(requestCompleteBock)handleBlock{
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *requestURL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:requestURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (connectionError == nil && httpResponse.statusCode == 200 ) {
            handleBlock(data, nil);
        }else{
            NSError *error = [NSError errorWithDomain:@"vedioRequest" code:1 userInfo:nil];
            handleBlock(nil, error);
        }
    }];
}

@end

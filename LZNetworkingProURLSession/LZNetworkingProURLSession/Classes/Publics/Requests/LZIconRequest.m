//
//  LZIconRequest.m
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/19.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZIconRequest.h"


@implementation LZIconRequest

- (void)headIconRequest:(NSString *)urlString completionHandler:(iconRequestCompletionBlock)handle{
    
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *headIconURL = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *loadHeadIocnTask =  [[NSURLSession sharedSession] dataTaskWithURL:headIconURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.httpResponse = (NSHTTPURLResponse *)response;
        self.requestError = error;
        if (self.requestError== nil && [self.httpResponse statusCode] == 200) {
            self.headIconImage = [[UIImage alloc] initWithData:data];
        }
        handle(self);
    }];
    
    [loadHeadIocnTask resume];
    
}

@end

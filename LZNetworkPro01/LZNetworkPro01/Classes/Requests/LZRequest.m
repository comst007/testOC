//
//  LZRequest.m
//  LZNetworkPro01
//
//  Created by comst on 15/10/12.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZRequest.h"

@interface LZRequest ()<NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *recvData;
@end
@implementation LZRequest


- (void)sendRequest:(NSString *)urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:20];
    
    /**
     *  异步请求
     *
     *
     */
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


/**
 *  synchronize request
 */

- (void)synRequest:(NSString *)urlString{
    
    /**
     *  同步请求
     */
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:20];
    NSURLResponse *reponse;
    NSData *responseData;
    responseData =  [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:nil];
    NSLog(@"reponse: %@", reponse);
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"responseString: %@", responseString);
}


/**
 *  异步队列请求
 */

- (void)asynRequest:(NSString *)urlString{
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:20];
    
    /**
     *  异步队列请求
     */
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSHTTPURLResponse *responseHttp = (NSHTTPURLResponse *)response;
        NSLog(@"response: %@", responseHttp);
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"responseString: %@", responseString);
    }];
}

#pragma mark - NSURLConnectiondataDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"coonect failed: %@", [error localizedDescription]);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response: %@", response);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        self.recvData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.recvData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"finish -----");
}
@end

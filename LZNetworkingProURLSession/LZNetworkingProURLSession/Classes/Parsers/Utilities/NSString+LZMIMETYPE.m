//
//  NSString+LZMIMETYPE.m
//  LZNetworkingPro03Upload
//
//  Created by comst on 15/10/14.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "NSString+LZMIMETYPE.h"

@implementation NSString (LZMIMETYPE)

- (NSString *)mimeType{
    
    NSString *urlString = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL fileURLWithPath:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    return response.MIMEType;
}
@end

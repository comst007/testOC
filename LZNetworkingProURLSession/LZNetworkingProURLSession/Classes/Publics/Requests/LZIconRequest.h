//
//  LZIconRequest.h
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/19.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class LZIconRequest;

typedef void (^iconRequestCompletionBlock)(LZIconRequest * iconRequest);



@interface LZIconRequest : NSObject

@property (nonatomic, strong) UIImage *headIconImage;
@property (nonatomic, strong) NSHTTPURLResponse *httpResponse;
@property (nonatomic, strong) NSError *requestError;



- (void)headIconRequest:(NSString *)urlString completionHandler:(iconRequestCompletionBlock)handle ;

@end

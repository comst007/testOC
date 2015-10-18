//
//  LZGlobal.h
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZGlobal : NSObject
@property (nonatomic, copy) NSString *username;
+ (instancetype)sharedglobal;
@end

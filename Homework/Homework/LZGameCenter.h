//
//  LZGameCenter.h
//  Homework
//
//  Created by comst on 15/9/17.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZGameCenter : NSObject

- (instancetype)initWithFishNumber:(NSUInteger)count;

- (instancetype)init;

+ (instancetype)gameWithFishNumber:(NSUInteger)count;

- (NSUInteger)catchFish;
@end

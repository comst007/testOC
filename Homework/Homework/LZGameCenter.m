//
//  LZGameCenter.m
//  Homework
//
//  Created by comst on 15/9/17.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZGameCenter.h"
#import "LZFish.h"
@interface LZGameCenter ()
@property (nonatomic, copy) NSMutableArray *fishPool ;
@end
@implementation LZGameCenter

- (NSMutableArray *)fishPool{
    if (_fishPool == nil) {
        _fishPool = [NSMutableArray array];
    }
    return _fishPool;
}


- (instancetype)initWithFishNumber:(NSUInteger)count{
    
    self = [super init];
    if (self) {
        for (NSUInteger i = 0; i < count; i++) {
            NSString *fishName = [NSString stringWithFormat:@"fish - %ld", i];
            LZFish *newFish = [LZFish fishWithName:fishName andWeight:arc4random_uniform(10) + 1 andGender:arc4random() % 2 ? LZAnimalGenderMale:LZAnimalGenderFemale andColor:@"black"];
            [self.fishPool addObject:newFish];
        }
    }
    return self;
}

- (instancetype)init{
    return [self initWithFishNumber:100];
}

+ (instancetype)gameWithFishNumber:(NSUInteger)count{
    return [[self alloc] init];
}

- (NSUInteger)catchFish{
    if (self.fishPool.count == 0) {
        return 0 ;
    }
    NSUInteger count = arc4random() % (self.fishPool.count + 1);
    for (NSUInteger i = 0; i < count; i++) {
        [self.fishPool removeObjectAtIndex:0];
    }
    
    return count;
}
@end

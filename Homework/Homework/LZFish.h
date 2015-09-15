//
//  LZFish.h
//  Homework
//
//  Created by comst on 15/9/16.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZAnimal.h"

@interface LZFish : LZAnimal

@property (nonatomic, strong) NSString *color;

- (instancetype)init;
- (instancetype)initWithName:(NSString *)name andWeight:(float)weight andGender:(LZAnimalGender)gender andColor:(NSString *)color;
+ (instancetype)fishWithName:(NSString *)name andWeight:(float)weight andGender:(LZAnimalGender)gender andColor:(NSString *)color;
- (void)act;
@end

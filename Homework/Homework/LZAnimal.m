//
//  LZAnimal.m
//  Homework
//
//  Created by comst on 15/9/15.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZAnimal.h"

@implementation LZAnimal

- (instancetype)init
{
    return [self initWithName:@"" andWeight:0 andGender:LZAnimalGenderMale];
}

- (instancetype)initWithName:(NSString *)name andWeight:(float)weight andGender:(LZAnimalGender)gender{
    
    self = [super init];
    
    if (self) {
        self.name = name;
        self.gender = gender;
        self.weight = weight;
    }
    return  self;
}

+ (instancetype)animalWithName:(NSString *)name andWeight:(float)weight andGender:(LZAnimalGender)gender{
    return [[self alloc] initWithName:name andWeight:weight andGender:gender];
}

- (void)speak{
    NSLog(@"animal speak!, %@", self);
}

- (NSString *)description{
    return  [NSString stringWithFormat:@"animal- name:%@, weight: %6.2f, gender: %@", self.name, self.weight, self.gender ? @"female" : @"male"];
}

- (void)act{
    
}
@end

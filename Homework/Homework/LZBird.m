//
//  LZBird.m
//  Homework
//
//  Created by comst on 15/9/15.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZBird.h"

@implementation LZBird

- (instancetype)init{
    
    return [self initWithName:@"" andWeight:0.0 andGender:LZAnimalGenderMale andColor:@""];
}

- (instancetype)initWithName:(NSString *)name andWeight:(float)weight andGender:(LZAnimalGender)gender andColor:(NSString *)color{
    self = [super initWithName:name andWeight:weight andGender:LZAnimalGenderMale];
    
    if (self) {
        self.color = color;
    }
    return self;
}

+ (instancetype)birdWithName:(NSString *)name andWeight:(float)weight andGender:(LZAnimalGender)gender andColor:(NSString *)color{
    
    return [[self alloc] initWithName:name andWeight:weight andGender:gender andColor:color];
}

- (void)act{
    NSLog(@"The bird is flying in the sky, %@", self);
}

- (NSString *)description{
    return [NSString stringWithFormat:@"bird - name: %@, weight: %.2f, gender: %@, color: %@", self.name, self.weight, self.gender ? @"female":@"male", self.color];
}
@end

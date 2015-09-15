//
//  LZAnimal.h
//  Homework
//
//  Created by comst on 15/9/15.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LZAnimalGender){
    LZAnimalGenderMale = 0,
    LZAnimalGenderFemale
};

@interface LZAnimal : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) float weight;

@property (nonatomic, assign) LZAnimalGender gender;

- (instancetype)init;

- (instancetype)initWithName:(NSString *)name andWeight:(float)weight andGender:(LZAnimalGender)gender;

+ (instancetype)animalWithName:(NSString *)name andWeight:(float)weight andGender:(LZAnimalGender)gender;

- (void)speak;

- (void)act;
@end

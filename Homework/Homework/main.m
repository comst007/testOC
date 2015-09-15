//
//  main.m
//  Homework
//
//  Created by comst on 15/9/15.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZAnimal.h"
#import "LZBird.h"
#import "LZFish.h"

const static NSInteger count = 10 ;
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        LZAnimal *animal1 = [[LZAnimal alloc] initWithName:@"kaka" andWeight:10.0 andGender:LZAnimalGenderMale];
        [animal1 speak];
        
        LZAnimal *animal2 = [[LZAnimal alloc] init];
        [animal2 speak];
        
        LZAnimal *animal3 = [LZAnimal animalWithName:@"Max" andWeight:6.0 andGender:LZAnimalGenderFemale];
        
        [animal3 speak];
        
        LZBird *bird1 = [[LZBird alloc] init];
        [bird1 act];
        
        LZBird *bird2 = [[LZBird alloc] initWithName:@"lisa" andWeight:1.2 andGender:LZAnimalGenderFemale andColor:@"yellow"];
        [bird2 act];
        
        LZBird *bird3 = [LZBird birdWithName:@"kuka" andWeight:3.3 andGender:LZAnimalGenderMale andColor:@"green"];
        [bird3 act];
        
        LZFish *fish1 = [[LZFish alloc] init];
        [fish1 act];
        
        LZFish *fish2 = [[LZFish alloc] initWithName:@"xiaoming" andWeight:3.5 andGender:LZAnimalGenderMale andColor:@"dark"];
        [fish2 act];
        
        LZFish *fish3 = [LZFish fishWithName:@"king" andWeight:5.5 andGender:LZAnimalGenderMale andColor:@"gold"];
        
        [fish3 act];
        
        NSMutableArray *arrayOFBirdsAndFishes = [NSMutableArray array];
        NSArray *arrayOfColor = @[@"red", @"orange", @"yellow", @"geen", @"glod", @"blue", @"purple", @"gray"];
        for (NSInteger i = 0; i < count; i ++) {
            NSString *birdName = [NSString stringWithFormat:@"Bird-%ld", i];
            NSString *fishName = [NSString stringWithFormat:@"fish-%ld", i];
            
            LZBird *newBird = [LZBird birdWithName:birdName andWeight:arc4random() % 3 + 1 andGender:arc4random() %2 ? LZAnimalGenderMale : LZAnimalGenderFemale andColor:arrayOfColor[arc4random() % arrayOfColor.count]];
            
            [arrayOFBirdsAndFishes addObject:newBird];
            
            LZFish *newFish = [LZFish fishWithName:fishName andWeight:arc4random() % 10 + 1 andGender:arc4random() % 2 ? LZAnimalGenderFemale : LZAnimalGenderMale andColor:arrayOfColor[arc4random() % arrayOfColor.count]];
            
            [arrayOFBirdsAndFishes addObject:newFish];
            
        }
        
        //1
        /*
        [arrayOFBirdsAndFishes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            LZAnimal *animal = (LZAnimal *)obj;
            [animal act];
        }];
         */
        
        //2
        //[arrayOFBirdsAndFishes makeObjectsPerformSelector:@selector(act) withObject:nil];
        
        //3
        for (LZAnimal *animal in arrayOFBirdsAndFishes) {
            [animal act];
        }
        
    }
    return 0;
}

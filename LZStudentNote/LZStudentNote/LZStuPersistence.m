//
//  LZStuPersistence.m
//  LZStudentNote
//
//  Created by comst on 15/10/25.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZStuPersistence.h"


@interface LZStuPersistence ()

@property (nonatomic, strong) NSMutableArray *listOfStudents;

@end

@implementation LZStuPersistence

- (NSString *)path{
    
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *filePath = [dir stringByAppendingPathComponent:@"stu.data"];
    
    return filePath;
}


- (NSArray *)findAll{
    
     self.listOfStudents = [NSKeyedUnarchiver unarchiveObjectWithFile:[self path]];
    
    return self.listOfStudents;
    
}

- (void)save{
    
    [NSKeyedArchiver archiveRootObject:self.listOfStudents toFile:[self path]];
    
}

- (void)addStudent:(LZStudent *)student{
    [self.listOfStudents addObject:student];
    [self save];
}

- (void)deleteStudent:(LZStudent *)student{
    
    for (LZStudent *stu in self.listOfStudents) {
        
        if ([stu isEqual:student ]) {
            
            [self.listOfStudents removeObject:stu];
            
            break;
        }
    }
    
    [self save];
}

- (NSArray *)searchByName:(NSString *)name{
    
    NSMutableArray *res = [NSMutableArray array];
    
    for (LZStudent *stu in self.listOfStudents) {
        
        if ([stu.name containsString:name]) {
            
            [res addObject:stu];
            
        }
    }
    
    return res;
}

- (void)updateStudent:(LZStudent *)student phone:(NSString *)phone{
    
    for (LZStudent *stu in self.listOfStudents) {
        
        if ([stu isEqual:student]) {
            
            stu.phone = phone;
            
            break;
            
        }
    }
    
    [self save];
}
@end

//
//  LZStuManager.h
//  LZStudentNote
//
//  Created by comst on 15/10/25.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZStudent.h"
#import "LZStuPersistence.h"
@interface LZStuManager : NSObject
@property (nonatomic, copy) NSString *name;
+ (instancetype)sharedstuManager;

- (NSArray *)allStudents;

- (void)addStudent:(LZStudent *)newStudent;

- (void)updateStudent:(LZStudent *)student phone:(NSString *)phone;

- (NSArray *)searchStudent:(NSString *)name;

- (void)deleteStudent:(LZStudent *)student;

@end

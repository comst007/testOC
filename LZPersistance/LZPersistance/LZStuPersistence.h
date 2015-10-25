//
//  LZStuPersistence.h
//  LZStudentNote
//
//  Created by comst on 15/10/25.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZStudent.h"
@interface LZStuPersistence : NSObject


- (NSArray *)findAll;

- (void)save;

- (void)addStudent:(LZStudent *)student;

- (void)deleteStudent:(LZStudent *)student;

- (NSArray *)searchByName:(NSString *)name;

- (void)updateStudent:(LZStudent *)student phone:(NSString *)phone;
@end

//
//  LZStudent.h
//  LZStudentNote
//
//  Created by comst on 15/10/25.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
@interface LZStudent : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;

- (BOOL)isEqual:(LZStudent *)student;

- (NSArray *)list;

- (void)test;
@end

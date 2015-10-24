//
//  LZStuManager.m
//  LZStudentNote
//
//  Created by comst on 15/10/25.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZStuManager.h"


//指向全局唯一的实例对象
static LZStuManager *instance = nil;

@interface LZStuManager ()

@property (nonatomic, strong) LZStuPersistence *stuPersistence;



@end

@implementation LZStuManager


- (NSArray *)allStudents{
    
    return [self.stuPersistence findAll];
    
}

- (NSArray *)searchStudent:(NSString *)name{
    
    return [self.stuPersistence searchByName:name];
}

- (void)deleteStudent:(LZStudent *)student{
    
    [self.stuPersistence deleteStudent:student];
}

- (void)updateStudent:(LZStudent *)student phone:(NSString *)phone{
    
    [self updateStudent:student phone:phone];
    
}


- (void)addStudent:(LZStudent *)newStudent{
    
    [self.stuPersistence addStudent:newStudent];
    
}
//保证单例对象无论创建多少次，永远都只有一份，多线程下要保证只有一个线程可以创建成功
+ (instancetype) allocWithZone:(struct _NSZone *)zone{
    
    //该方法只会执行一次，所以可以保障只会创建一个实例
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
        instance.stuPersistence = [[LZStuPersistence alloc] init];
    });
    
    return instance;
}



//用于返回单例对象的实例
+ (instancetype)sharedstuManager{
    
    return [[self alloc] init ];
}

//对象在copy的过程中也只会返回同一个实例
- (id)copy{
    
    return instance;
}

// 如果是MRC还需要实现跟对象引用计数相关的几个方法

#if !__has_feature(objc_arc)

- (oneway void)release{
    //甚么也不做
}

- (instancetype)autorelease{
    return instance;
}

- (instancetype)retain{
    return instance;
}

- (NSUInteger)retainCount{
    return 1;
}

#endif
@end



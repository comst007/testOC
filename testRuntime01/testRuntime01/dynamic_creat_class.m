//
//  main.m
//  testRuntime01
//
//  Created by comst on 15/10/2.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZPerson.h"
#import <objc/message.h>
#import <objc/runtime.h>


/*
 1. 动态创建一个类 LZStudent(继承自NSObject)
 2. 动态添加实例变量 name
 3. 动态添加成员方法 show
 */

static void show(id self, SEL _cmd){
    NSLog(@"show");
}

int test(int argc, const char * argv[]) {
    @autoreleasepool {
        //创建一个类，继承自NSobject
        Class LZStudent =   objc_allocateClassPair([NSObject class], "LZStudent", 0);
        
        BOOL isOk;
        //向该类添加一个实例变量 NSString *_name
        isOk = class_addIvar(LZStudent, "_name", sizeof(NSString *), log2(sizeof(id)), @encode(NSString));
        
        if (!isOk) {
            NSLog(@"addivar fail");
        }
        //想该类添加一个实例方法。
        isOk = class_addMethod(LZStudent, NSSelectorFromString(@"show"), (IMP)show, "v@:");
        
        if (!isOk) {
            NSLog(@"addMethod fail");
        }
        objc_registerClassPair(LZStudent);
        
        unsigned int count ;
        Ivar *arr = class_copyIvarList(LZStudent, &count);
        //打印类变量的个数
        NSLog(@"variable count: %u", count);
        //打印变量的名字和类型
        for (NSInteger i = 0; i < count; i ++) {
            const char* ivarName = ivar_getName(arr[i]);
            const char* ivarType = ivar_getTypeEncoding(arr[i]);
            NSLog(@"name: %s, type: %s", ivarName, ivarType);
        }
        
        
        id obj = [[LZStudent alloc] init];
        [obj performSelector:NSSelectorFromString(@"show")];
    }
    
    return 0;
}

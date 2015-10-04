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
@interface LZDog: NSObject{
    NSInteger _age;
}

@end

@implementation LZDog

- (instancetype)initWithAge:(NSInteger) age{
    
    self = [super init];
    if (self) {
        _age = age;
    }
    return self;
}

@end
    


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        LZDog *dog1 = [[LZDog alloc] initWithAge:0x123456780a0b0c0d];
        
        LZDog *dog2 = [[LZDog alloc] initWithAge:0xaabbccdd12345678];
        //get the objec size
        NSInteger objcSize = class_getInstanceSize([LZDog class]);
        
        //打印对象的内存数据
        NSData *dog1Data = [NSData dataWithBytes:(__bridge void*)dog1 length:objcSize];
        
        NSData *dog2Data = [NSData dataWithBytes:(__bridge void*)dog2 length:objcSize];
        
        //查看对象内存
        NSLog(@"dog1: %@", dog1Data);
        NSLog(@"dog2: %@", dog2Data);
        //打印类地址
        NSLog(@"class address:%p", [LZDog class]);
        
        //查看类内存
        id dogClass = objc_getClass("LZDog");
        NSInteger classSize = class_getInstanceSize([dogClass class]);
        
        NSData *classData = [NSData dataWithBytes:(__bridge void*)dogClass length:classSize];
        
        NSLog(@"dogclass: %@", classData);
        
        //打印父类（NSobject）地址
        NSLog(@"superclass address: %p", [LZDog superclass]);
        
        
        
    }
   
    return 0;
}

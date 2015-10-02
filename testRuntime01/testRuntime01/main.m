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
NSString *greeting(id self, SEL _cmd){
    return [NSString stringWithFormat:@"Hello World!"];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Class  dyClass = objc_allocateClassPair([NSObject class], "DynamicClass", 0);
        
        Method desMethod = class_getInstanceMethod([NSObject class], @selector(description));
        
        const char *types = method_getTypeEncoding(desMethod);
        
        class_addMethod(dyClass, @selector(greeting), (IMP)greeting, types);
        
        objc_registerClassPair(dyClass);
        
        id obj = [[dyClass alloc] init ];
        
        //[obj performSelector:NSSelectorFromString(@"greeting")];
        //objc_msgSend(obj, NSSelectorFromString(@"greeting"));
        
        //NSLog(@"-----%@", objc_msgSend(obj, NSSelectorFromString(@"greeting")));
        NSLog(@"%@", [obj performSelector:NSSelectorFromString(@"greeting")]);
        
    }
   
    return 0;
}

void testDynamicMethod(){
    
    
#pragma  clang diagnostic push
#pragma  clang diagnostic ignored "-Warc-performSelector-leaks"
    LZPerson *p = [[LZPerson alloc] init];
    
    SEL sel = NSSelectorFromString(@"show");
    [p performSelector:sel];
#pragma clang diagnostic pop
    
}

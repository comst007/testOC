//
//  LZPerson.m
//  testRuntime01
//
//  Created by comst on 15/10/2.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZPerson.h"
#import <objc/runtime.h>

void dynamicFunc(id self, SEL aSel ){
    NSLog(@"dynamic method");
}
@implementation LZPerson

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSString *seletor = NSStringFromSelector(sel);
    if ([seletor isEqualToString:@"show"]) {
        class_addMethod([self class], sel, (IMP)dynamicFunc, "v@:");
        
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
@end

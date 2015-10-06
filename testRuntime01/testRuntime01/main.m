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

static void dynamicResolveMethodIMP(id self, SEL _cmd){
    NSLog(@"dynamicResolveMethodIMP");
}
@interface LZMouse : NSObject

- (void)fastforwardMessage;
- (void)forwardMessage;
@end

@implementation LZMouse

- (void)fastforwardMessage{
    NSLog(@"LZMouse %s", __func__);
    
}

- (void)forwardMessage{
    NSLog(@"LZMouse %s", __func__);
}

@end

@interface LZCat : NSObject

@property (nonatomic, strong) LZMouse *mouse;

- (void)normalMessage;


@end

@implementation LZCat

- (void)normalMessage{
    NSLog(@"%s", __func__);

}

+ (BOOL)resolveInstanceMethod:(SEL)sel{

    NSString *selector = NSStringFromSelector(sel);

    if ([selector isEqualToString:@"dynamicResolveMessage"]) {
        BOOL isOk ;

    isOk               = class_addMethod([LZCat class], sel, (IMP)dynamicResolveMethodIMP, "v@:");
        if (!isOk) {
            NSLog(@"addmethod fail");
            return [super resolveInstanceMethod:sel];
        }
        return YES;
    }

    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector{

    NSString *selector = NSStringFromSelector(aSelector);

    if ([selector isEqualToString:@"fastforwardMessage"]) {
        return self.mouse;
    }

    return [super forwardingTargetForSelector:aSelector];
}


- (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSString *selector = NSStringFromSelector(anInvocation.selector);

    if ([selector isEqualToString:@"forwardMessage"]) {
        [anInvocation invokeWithTarget:self.mouse];
        return;
    }
    [super forwardInvocation:anInvocation];
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{


    return [NSMethodSignature signatureWithObjCTypes:"v@:"];

}
@end

@interface LZCat (LZCat_cat)

- (void)dynamicResolveMessage;

- (void)fastforwardMessage;

- (void)forwardMessage;
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {

    LZCat *acat        = [[LZCat alloc] init];

    acat.mouse         = [[LZMouse alloc] init];
        //正常的消息发送，在类的虚函数表了可以搜索得到
        [acat normalMessage];

        //动态方法决议
        [acat dynamicResolveMessage];


        //  快速消息转发
        [acat fastforwardMessage];


        //正常消息转发,修改target
        [acat forwardMessage];
    }

    return 0;
}

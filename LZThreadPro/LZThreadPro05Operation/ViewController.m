//
//  ViewController.m
//  LZThreadPro05Operation
//
//  Created by comst on 15/10/8.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self blockOperation5];
}

- (void)invocationOperation{
    
    NSMethodSignature *methodsignature = [[self class] instanceMethodSignatureForSelector:@selector(invocationMethod)];
    NSLog(@"signature: %@", methodsignature);
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodsignature];
    invocation.selector = @selector(invocationMethod);
    invocation.target = self;
    
//    NSInvocationOperation *invocationOp = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationMethod ) object:nil];
    NSInvocationOperation *invocationOp = [[NSInvocationOperation alloc] initWithInvocation:invocation];
    
    NSOperationQueue *opQueue = [[NSOperationQueue alloc] init];
    
    [opQueue addOperation:invocationOp];
}

- (void)invocationMethod{
    [NSThread sleepForTimeInterval:3];
    NSLog(@"%@", [NSThread currentThread]);
}

- (void)blockOperation{
    NSBlockOperation *blockOp = [NSBlockOperation blockOperationWithBlock:^{
        
        [NSThread sleepForTimeInterval:3];
        NSLog(@"%@", [NSThread currentThread]);
        
    }];
    
    NSOperationQueue *opQueue = [[NSOperationQueue alloc] init];
    
    [opQueue addOperation:blockOp];
    [opQueue addOperationWithBlock:^{
        
        NSLog(@"%@", [NSThread currentThread]);
    }];
    
}

- (void)blockOperation2{
    NSOperationQueue *opQueue = [[NSOperationQueue alloc] init];
    
    for (NSInteger i = 0; i < 10; i ++) {
        [opQueue addOperationWithBlock:^{
            
            NSLog(@"%@ ---%li", [NSThread currentThread], i);
        }];
        if (i == 6) {
            [opQueue setSuspended:YES];
        }
    }
    NSLog(@"-----------");
    [opQueue setSuspended:NO];
}

- (void)blockOperation3{
    NSOperationQueue *opQueue = [[NSOperationQueue alloc] init];
    opQueue.maxConcurrentOperationCount = 1;
    for (NSInteger i = 0; i < 10; i ++) {
        [opQueue addOperationWithBlock:^{
            
            NSLog(@"%@ ---%li", [NSThread currentThread], i);
        }];
      
    }

}

- (void)blockOperation4{
    
    NSOperationQueue *opQueue = [[NSOperationQueue alloc] init];
    for (NSInteger i = 0; i < 10; i ++) {
        NSBlockOperation *blokOp = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"%@ ---%li", [NSThread currentThread], i);
        }];
        blokOp.queuePriority = i / 10.0 ;
        
        [opQueue addOperation:blokOp];
        
    }
    
}

- (void)blockOperation5{
    
    NSOperationQueue *opQueue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task1: %@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task2: %@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task3: %@", [NSThread currentThread]);
    }];
    
    [op3 addDependency:op2];
    [op3 addDependency:op1];
    
    [opQueue addOperation:op3];
    [opQueue addOperation:op2];
    [opQueue addOperation:op1];
}

@end

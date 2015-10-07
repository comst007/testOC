//
//  ViewController.m
//  LZThreadPro04GCD
//
//  Created by comst on 15/10/7.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self mainAsyn];
}

/**
 *  串行队列 同步执行， 不会创建辅助线程
 */
- (void)serialSyn{
    
    NSLog(@"%s, %@", __func__, [NSThread currentThread]);
    
    dispatch_queue_t serialQue = dispatch_queue_create("serialque", DISPATCH_QUEUE_SERIAL);
    
    for (NSInteger i = 0; i < 10; i ++) {
        dispatch_sync(serialQue, ^{
            
            NSLog(@"currentThread: %@", [NSThread currentThread]);
            NSLog(@"i = %li", i);
            [NSThread sleepForTimeInterval:1];
            
        });
    }
}

/**
 *  串行队列 异步执行，会创建一个辅助线程
 */
- (void)serialAsyn{
    
    NSLog(@"%s, %@", __func__, [NSThread currentThread]);
    
    dispatch_queue_t serialQue = dispatch_queue_create("serialque", DISPATCH_QUEUE_SERIAL);
    
    for (NSInteger i = 0; i < 10; i ++) {
        dispatch_async(serialQue, ^{
            
          
            
            
                NSLog(@"currentThread: %@", [NSThread currentThread]);
                NSLog(@"i = %li", i);
                [NSThread sleepForTimeInterval:1];
        
           
            
        });
    }
    
}

/**
 *  并发队列 同步执行，不会创建辅助线程
 */
- (void)concurrentSyn{
    dispatch_queue_t concurrentQue = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    for (NSInteger i = 0; i < 10; i ++) {
        dispatch_sync(concurrentQue, ^{
           
            NSLog(@"currentThread: %@", [NSThread currentThread]);
            NSLog(@"i = %li", i);
            [NSThread sleepForTimeInterval:1];
            
        });
    }
}

/**
 *  并发队列，异步执行， 会创建多个辅助线程
 */
- (void)concurrentAsyn{
    
    dispatch_queue_t concurrentQue = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    for (NSInteger i = 0; i < 10; i ++) {
        
        dispatch_async(concurrentQue, ^{
            
            @synchronized(self){
                
                NSLog(@"currentThread: %@", [NSThread currentThread]);
                NSLog(@"i = %li", i);
                [NSThread sleepForTimeInterval:1];
                
            }
            
        });
    }
    
}

/**
 *  主队列，向该队列添加的任务只有主线程执行
     主队列同步执行会造成死锁
 */

- (void)mainSyn{
    
    NSLog(@"currentThread: %@", [NSThread currentThread]);
    
    dispatch_queue_t mainQue = dispatch_get_main_queue();
    
    for (NSInteger i = 0 ; i < 10; i ++) {
        
        dispatch_sync(mainQue, ^{
            
            NSLog(@"%@, %li", [NSThread currentThread], i);
            
        });
    }
}

/**
 *  主队列异步执行，不会阻塞
 */
- (void)mainAsyn{
    
    
    NSLog(@"currentThread: %@", [NSThread currentThread]);
    
    dispatch_queue_t mainQue = dispatch_get_main_queue();
    
    for (NSInteger i = 0 ; i < 10; i ++) {
        
        dispatch_async(mainQue, ^{
            
            NSLog(@"%@, %li", [NSThread currentThread], i);
            [NSThread sleepForTimeInterval:1];
        });
    }
    
}
@end

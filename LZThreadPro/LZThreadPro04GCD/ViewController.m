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
    [self dispatchOnce];
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

/**
 *  全局队列 同步执行。 全局队列属于并发队列。同步执行不会创建辅助线程
 */
- (void)globalSyn{
    
    NSLog(@"currentThread: %@", [NSThread currentThread]);
    
    dispatch_queue_t globalQue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0);
    
    for (NSInteger i = 0 ; i < 10; i ++) {
        
        dispatch_sync(globalQue, ^{
            
            NSLog(@"%@, %li", [NSThread currentThread], i);
            [NSThread sleepForTimeInterval:1];
        });
    }
    
}

/**
 *  全局队列，异步执行，会创建多个辅助线程
 */
- (void)globalAsyn{
    
    NSLog(@"currentThread: %@", [NSThread currentThread]);
    
    dispatch_queue_t globalQue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0);
    
    for (NSInteger i = 0 ; i < 10; i ++) {
        
        dispatch_async(globalQue, ^{
            
            NSLog(@"%@, %li", [NSThread currentThread], i);
            [NSThread sleepForTimeInterval:1];
        });
    }
    
}


/**
 *  dispatch_after 延迟执行
 */

- (void)dispatchAfter{
    NSLog(@"delay 10 seconds ");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"delayed action");
        
    });
}

/**
 *  dispatch_group 
    计算 1 + 2 + 3 + 4 + .........+100的和。可以这样计算 （1 + 2 + ...+ 9） + (10 + 11 + ...+ 19) + ....+（90 + ...+99）,每十个加数一组，相同时计算出这十组的和，然后再将这十组的和累加就可以得到这100个数的和
 */
- (void)dispatchGroup{
    NSLog(@"1 + 2 + 3 + ... + 100 = ");
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0);
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    __block NSInteger sum1 = 0;
    __block NSInteger sum2 = 0;
    __block NSInteger sum3 = 0;
    __block NSInteger sum4 = 0;
    __block NSInteger sum5 = 0;
    __block NSInteger sum6 = 0;
    __block NSInteger sum7 = 0;
    __block NSInteger sum8 = 0;
    __block NSInteger sum9 = 0;
     __block NSInteger sum10 = 0;
    __block NSInteger sumTotal = 0;
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger j = 1; j < 11; j ++) {
            sum1 += j;
        }
        
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger j = 11; j < 21; j ++) {
            sum2 += j;
        }
        
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger j = 21; j < 31; j ++) {
            sum3 += j;
        }
        
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger j = 31; j < 41; j ++) {
            sum4 += j;
        }
        
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger j = 41; j < 51; j ++) {
            sum5 += j;
        }
        
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger j = 51; j < 61; j ++) {
            sum6 += j;
        }
        
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger j = 61; j < 71; j ++) {
            sum7 += j;
        }
        
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger j = 71; j < 81; j ++) {
            sum8 += j;
        }
        
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger j = 81; j < 91; j ++) {
            sum9 += j;
        }
        
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger j = 91; j < 101; j ++) {
            sum10 += j;
        }
        
    });
    
    dispatch_group_notify(group, mainQ, ^{
        
        sumTotal = sum1 + sum2 + sum3 + sum4 + sum5 + sum6 + sum7 + sum8 + sum9 + sum10;
        NSLog(@"%li", sumTotal);
    });
    
    
    
    
}


/**
 *   dispatch_barrier_async
 *   读者写者问题：同一时间可以有多个读者，但不能有多个写者，如果某一时刻有多个读者，这时过来一个写者，写者要等待读者执行完毕后才能访问文件，写者后面的读者（或写者）也要等到改写着执行完才能访问文件
 */

- (void)dispatchbarrierAsync{
    
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0);
    for (NSInteger i = 0; i < 10; i ++) {
        
        dispatch_barrier_async(queue, ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"reader... %li", i);
            
        });
    }
    
    dispatch_barrier_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"writer...");
        
    });
    
    for (NSInteger i = 10; i < 20; i ++) {
        
        dispatch_barrier_async(queue, ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"reader...%li", i);
            
        });
    }
    NSLog(@"---------------");
}

/**
 *  dispatch_once 
 *  可以保证代码只执行一遍
 */

- (void)dispatchOnce{
    
    static dispatch_once_t once;
    
    for (NSInteger i = 0 ; i < 10 ; i ++) {
        dispatch_once(&once, ^{
            
            NSLog(@"print only 1 time");
        });
    }
}

/**
 *  dispatch_io_create
 */
@end

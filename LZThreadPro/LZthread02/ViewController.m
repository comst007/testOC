//
//  ViewController.m
//  LZthread02
//
//  Created by comst on 15/10/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#define kItemCountMax  20
@interface ViewController ()
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, strong) NSCondition *cond_pro;//
@property (nonatomic, strong) NSCondition *cond_con;
@property (nonatomic, assign) NSInteger itemCount;//车间中产品数量，最大值为20；
@end


/**
 *  生产者消费者
    1. 随机产生N个生产者，M个消费者， 有一个可以存放P件物品的车间。
    2. 只有当车间不满的时候生产者才可以生产产品，否则生产者休眠等待直到车间不满。
    3. 只有车间不空的时候消费者才可以消费产品，否则消费者休眠等待直到车间不空。
    4. 生产者和消费者要互斥访问车间
 */
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSInteger producerCount = arc4random_uniform(10) + 1;
    NSInteger consumerCount = arc4random_uniform(10) + 1;
    
    self.itemCount = 10;
    [self lock];
    [self cond_con];
    [self cond_pro];
    
    for (NSInteger i = 0; i < consumerCount; i ++) {
        NSThread *threadProducer = [[NSThread alloc] initWithTarget:self selector:@selector(proMain) object:nil];
        [threadProducer start];
    }
    
    for (NSInteger i = 0; i < producerCount; i ++) {
        NSThread *threadConsumer = [[NSThread alloc] initWithTarget:self selector:@selector(conMain) object:nil];
        [threadConsumer start];
    }
    
    
}

- (NSLock *)lock{
    
    if (!_lock) {
        _lock = [[NSLock alloc] init];
    }
    return _lock;
}

- (NSCondition *)cond_con{
    if (!_cond_con) {
        _cond_con = [[NSCondition alloc] init];
    }
    return _cond_con;
}


- (NSCondition *)cond_pro{
    if (!_cond_pro) {
        _cond_pro = [[NSCondition alloc] init];
    }
    return _cond_pro;
}

/**
 *  生产者。
    如果还有产品，消费产品，否则休眠等待
 */
- (void)proMain{
    while (YES) {
        
        
        [self.lock lock];
        while (self.itemCount >= kItemCountMax) {
            [self.cond_pro lock];
            [self.cond_pro wait];
            [self.cond_pro unlock];
        }
        
        self.itemCount = self.itemCount + 1;
        
        NSLog(@"producer: total: %li",  self.itemCount);
        
        //通知消费者消费产品
        if (self.itemCount == 1) {
            [self.cond_con lock];
            [self.cond_con broadcast];
             [self.cond_con unlock];
        }
        
        [self.lock unlock];
        [NSThread sleepForTimeInterval:arc4random_uniform(3)];
        
    }
    
}

- (void)conMain{
    while (YES) {

        [self.lock lock];
        
        while (self.itemCount == 0) {
            [self.cond_con lock];
            [self.cond_con wait];
            [self.cond_con unlock];
        }
        
        self.itemCount = self.itemCount - 1 ;
        
        NSLog(@"consumer: left: %li", self.itemCount);
        
        //通知生产者生产产品
        if (self.itemCount == 0) {
            [self.cond_pro lock];
            [self.cond_pro broadcast];
            [self.cond_pro unlock];
        }
        
        [self.lock unlock];
        
        [NSThread sleepForTimeInterval:arc4random_uniform(3)];
        
    }
}

@end

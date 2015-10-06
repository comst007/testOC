//
//  ViewController.m
//  LZThreadPro
//
//  Created by comst on 15/10/6.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"main:%@", [NSThread currentThread]);
    
    NSThread *newthd = [[NSThread alloc] initWithTarget:self selector:@selector(thdRunloop) object:nil];
    
    [newthd start];
    
    [self performSelector:@selector(threadMain) onThread:newthd withObject:nil waitUntilDone:YES];
    
}
/*
 voidcreateCustomSource()
 {
 CFRunLoopSourceContext context = {0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};
 CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
 CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
 while (pageStillLoading) {
 NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
 CFRunLoopRun();
 [pool release];
 }
 CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
 CFRelease(source);
 }
 */


- (void)thdRunloop{
    CFRunLoopSourceContext context = {0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};
    CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    CFRunLoopRun();
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    CFRelease(source);
    
}

- (void)threadMain{
    [NSThread sleepForTimeInterval:3];
    NSLog(@"%@", [NSThread currentThread]);
}

/**
 *  creat new thread
 */
- (void)newThread1{
    NSThread *newthread = [[NSThread alloc] initWithTarget:self selector:@selector(threadMain) object:nil];
    NSLog(@"main:%@", [NSThread currentThread]);
    
    [newthread start];
    
    //    [[NSThread mainThre];
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
}


- (void)newThread2{
 
    [self performSelectorInBackground:@selector(threadMain) withObject:nil];
}

- (void)newThread3{
 
    [NSThread detachNewThreadSelector:@selector(threadMain) toTarget:self withObject:nil];
}


@end

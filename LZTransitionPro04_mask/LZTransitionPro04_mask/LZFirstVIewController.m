//
//  LZFirstVIewController.m
//  LZTransitionPro04_mask
//
//  Created by comst on 15/11/30.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZFirstVIewController.h"
#import "LZSecondViewController.h"
#import "LZPushTransition.h"
@interface LZFirstVIewController ()<UINavigationControllerDelegate>

@end
@implementation LZFirstVIewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.pushButton.layer.cornerRadius = self.pushButton.bounds.size.width * 0.5;
    
    self.pushButton.layer.masksToBounds = YES;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if ([toVC isKindOfClass:[LZSecondViewController class]]) {
        return [[LZPushTransition alloc] init];
    }
    return nil;
}
@end

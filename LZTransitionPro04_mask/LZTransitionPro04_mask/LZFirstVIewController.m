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
#import "LZPopTransition.h"
@interface LZFirstVIewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interativeTransition;

@end
@implementation LZFirstVIewController

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
   
    
    self.interativeTransition = [[UIPercentDrivenInteractiveTransition alloc] init];

    
    self.pushButton.layer.cornerRadius = self.pushButton.bounds.size.width * 0.5;
    
    self.pushButton.layer.masksToBounds = YES;
}



- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if ([toVC isKindOfClass:[LZSecondViewController class]]) {
        return [[LZPushTransition alloc] init];
    }
    if ([toVC isKindOfClass:[LZFirstVIewController class]]) {
        return [[LZPopTransition alloc] init];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if ([animationController isKindOfClass:[LZPopTransition class]]) {
        
        return self.interativeTransition;
    }
    return nil;
}
@end

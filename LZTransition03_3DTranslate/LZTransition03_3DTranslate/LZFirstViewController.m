//
//  LZFirstViewController.m
//  LZTransition03_3DTranslate
//
//  Created by comst on 15/11/30.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZFirstViewController.h"
#import "LZSecondViewController.h"
#import "LZPushTransition.h"
#import "LZPopTransition.h"
@interface LZFirstViewController ()<UINavigationControllerDelegate>

@end
@implementation LZFirstViewController


- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.navigationController.delegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if ([toVC isKindOfClass:[LZSecondViewController class]]) {
        return [[LZPushTransition alloc] init];
    }
    if ([toVC isKindOfClass:[LZFirstViewController class]]) {
        return [[LZPopTransition alloc] init];
    }
    return nil;
}
@end

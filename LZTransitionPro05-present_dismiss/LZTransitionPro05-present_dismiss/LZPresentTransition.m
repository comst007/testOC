//
//  LZPresentTransition.m
//  LZTransitionPro05-present_dismiss
//
//  Created by comst on 15/12/1.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZPresentTransition.h"
#import "LZFirstViewContrller.h"
#import "LZSecondViewController.h"

@implementation LZPresentTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return 0.75;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    LZFirstViewContrller *fromVC = (LZFirstViewContrller *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    LZSecondViewController *toVC = (LZSecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = fromVC.view;
    UIView * toView = toVC.view;
    
    //toView.alpha = 0;
    fromView.layer.anchorPoint = CGPointMake(0, 0.5);
    fromView.layer.position = CGPointMake(0, CGRectGetMidY([UIScreen mainScreen].bounds));
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];
//    
//    NSLog(@"formView: %@", fromView);
//    NSLog(@"toView: %@", toView);
//    for (UIView *view in containerView.subviews) {
//        NSLog(@"%@", view);
//    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        //toView.alpha = 1;
        fromView.layer.transform = CATransform3DRotate(fromView.layer.transform, - M_PI_2, 0, 1, 0);
        
    } completion:^(BOOL finished) {
        
        fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        fromView.layer.position = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
        fromView.layer.transform = CATransform3DIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
}
@end

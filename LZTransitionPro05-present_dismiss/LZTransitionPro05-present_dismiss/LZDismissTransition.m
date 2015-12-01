//
//  LZDismissTransition.m
//  LZTransitionPro05-present_dismiss
//
//  Created by comst on 15/12/1.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZDismissTransition.h"
#import "LZFirstViewContrller.h"
#import "LZSecondViewController.h"

@implementation LZDismissTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return 0.75;
    
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    LZFirstViewContrller *ToVC = (LZFirstViewContrller *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    LZSecondViewController *fromVC = (LZSecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = fromVC.view;
    UIView *toView = ToVC.view;
    
    
    
    toView.layer.transform = CATransform3DRotate(toView.layer.transform, - M_PI_2, 0, 1, 0);
    toView.layer.anchorPoint = CGPointMake(0, 0.5);
    toView.layer.position = CGPointMake(0, CGRectGetMidY([UIScreen mainScreen].bounds));
    toView.frame = [transitionContext finalFrameForViewController:ToVC];
    [containerView addSubview:toView];
    
    CGFloat duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration animations:^{
        
        //fromView.alpha = 0;
        
        toView.layer.transform = CATransform3DIdentity;
        
//        toView.layer.transform = CATransform3DRotate(toView.layer.transform, M_PI_2, 0, 1, 0);
        
    } completion:^(BOOL finished) {
        
       
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.position = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
        //fromView.alpha = 1;
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}
@end

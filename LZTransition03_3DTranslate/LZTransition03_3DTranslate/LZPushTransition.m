//
//  LZPushTransition.m
//  LZTransition03_3DTranslate
//
//  Created by comst on 15/11/30.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZPushTransition.h"
#import "LZFirstViewController.h"
#import "LZSecondViewController.h"

@implementation LZPushTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return  0.75;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    LZFirstViewController *fromVC = (LZFirstViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    LZSecondViewController *toVC = (LZSecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    fromView.frame = [transitionContext initialFrameForViewController:fromVC];
    toView.frame = [transitionContext initialFrameForViewController:fromVC];
    toView.alpha = 0;
    
    [containerView addSubview:toView];
    
    fromView.layer.anchorPoint = CGPointMake(0, 0.5);
    fromView.layer.position = CGPointMake(0, CGRectGetMidY([UIScreen mainScreen].bounds));
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        toView.alpha = 1;
        fromView.layer.transform = CATransform3DRotate(containerView.layer.transform, - M_PI_2, 0, 1, 0);
        
    } completion:^(BOOL finished) {
        
        fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        fromView.transform = CGAffineTransformIdentity;
        fromView.layer.position = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
        
        [transitionContext completeTransition:YES];
        
    }];
}
@end

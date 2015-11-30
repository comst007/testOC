//
//  LZPopTransition.m
//  LZTransition03_3DTranslate
//
//  Created by comst on 15/11/30.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZPopTransition.h"
#import "LZFirstViewController.h"
#import "LZSecondViewController.h"

@implementation LZPopTransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    LZFirstViewController * toVC = (LZFirstViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    LZSecondViewController *fromVC = (LZSecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    
    
    toView.frame = [transitionContext initialFrameForViewController:fromVC];
    
    toView.layer.anchorPoint = CGPointMake(0, 0.5);
    toView.layer.position = CGPointMake(0, CGRectGetMidY([UIScreen mainScreen].bounds));
    [containerView addSubview:toView];
    
    toView.layer.transform = CATransform3DRotate(toView.layer.transform, - M_PI_2, 0, 1, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        toView.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.position = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}
@end

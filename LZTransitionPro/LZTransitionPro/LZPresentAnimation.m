//
//  LZPresentAnimation.m
//  LZTransitionPro
//
//  Created by comst on 15/11/29.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZPresentAnimation.h"

@implementation LZPresentAnimation
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect fromRect = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    CGRect toRect = [transitionContext finalFrameForViewController:toVC];
    
    toVC.view.frame = fromRect;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        toVC.view.frame = toRect;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
@end

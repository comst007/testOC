//
//  LZPopTransition.m
//  LZTransitionPro02_Push_Pop
//
//  Created by comst on 15/11/30.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZPopTransition.h"
#import "LZFirstViewController.h"
#import "LZCustomCell.h"
#import "LZSecondViewController.h"

@implementation LZPopTransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.75;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    LZFirstViewController *toVC = (LZFirstViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    LZSecondViewController  *fromVC = (LZSecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    
    
    LZCustomCell *cell = (LZCustomCell *)[toVC collectionView:toVC.collectionView cellForItemAtIndexPath:toVC.selectIndexPath];
    
    cell.iconImageview.alpha = 0;
    
    UIView *snapView = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    snapView.frame = [containerView convertRect:fromVC.imageView.frame fromView:fromVC.imageView.superview];
    snapView.backgroundColor = [UIColor clearColor];
    
    fromVC.imageView.alpha = 0;
    
    CGRect toRect = toVC.imageViewFrame;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        
        snapView.frame = toRect;
        toVC.view.alpha = 1;
        
        
    } completion:^(BOOL finished) {
        [snapView removeFromSuperview];
        fromVC.imageView.alpha = 1;
        cell.iconImageview.alpha = 1;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
}
@end

//
//  LZPushTransition.m
//  LZTransitionPro02_Push_Pop
//
//  Created by comst on 15/11/30.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZPushTransition.h"
#import "LZFirstViewController.h"
#import "LZSecondViewController.h"
#import "LZCustomCell.h"

@implementation LZPushTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return 1.75;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    LZFirstViewController *fromVC = (LZFirstViewController *)[transitionContext  viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    LZSecondViewController *toVC = (LZSecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];

    NSIndexPath *selectIndexPath = [[fromVC.collectionView indexPathsForSelectedItems] firstObject];
    fromVC.selectIndexPath = selectIndexPath;
    
    LZCustomCell *cell = (LZCustomCell *)[fromVC collectionView:fromVC.collectionView cellForItemAtIndexPath:selectIndexPath];
    
    
    
    UIView *snapView = [cell.iconImageview snapshotViewAfterScreenUpdates:NO];
    snapView.frame = [containerView convertRect:cell.iconImageview.frame fromView:cell.iconImageview.superview];
    fromVC.imageViewFrame = snapView.frame;
    cell.iconImageview.hidden = YES;
    
    
    CGRect toVCRect = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = toVCRect;
    
    
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapView];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1;
        
        snapView.frame = [containerView convertRect:toVC.imageView.frame fromView:toVC.view];;
        
    } completion:^(BOOL finished) {
        
        
        toVC.imageView.hidden = NO;
        cell.iconImageview.hidden = NO;
        [snapView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}
@end

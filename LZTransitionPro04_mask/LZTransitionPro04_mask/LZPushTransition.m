//
//  LZPushTransition.m
//  LZTransitionPro04_mask
//
//  Created by comst on 15/12/1.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZPushTransition.h"
#import "LZFirstVIewController.h"
#import "LZSecondViewController.h"
#import <UIKit/UIKit.h>

@interface LZPushTransition ()
@property (nonatomic, strong) id<UIViewControllerContextTransitioning>  context;
@end
@implementation LZPushTransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return 0.75;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.context = transitionContext;
    LZFirstVIewController *fromVC = (LZFirstVIewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    LZSecondViewController *toVC = (LZSecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    [containerView addSubview:toView];
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:fromVC.pushButton.frame];
    
    CGFloat radius = sqrt(fromVC.pushButton.frame.origin.x * fromVC.pushButton.frame.origin.x +  (CGRectGetMaxY(fromView.bounds) - fromVC.pushButton.frame.origin.y) * (CGRectGetMaxY(fromView.bounds) - fromVC.pushButton.frame.origin.y) );
    
    CGRect finalRect = CGRectInset(fromVC.pushButton.frame, -radius, -radius);
    
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:finalRect];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    toView.layer.mask = shapeLayer;
    
    CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskAnimation.fromValue = (__bridge id)(startPath.CGPath);
    maskAnimation.toValue = (__bridge id)(finalPath.CGPath);
    maskAnimation.duration = [self transitionDuration:transitionContext];
    maskAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskAnimation.delegate = self;
    [shapeLayer addAnimation:maskAnimation forKey:@"maskAnimation"];
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.context completeTransition:YES];
     LZSecondViewController *toVC = (LZSecondViewController *)[self.context viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.layer.mask = nil;
    
}
@end

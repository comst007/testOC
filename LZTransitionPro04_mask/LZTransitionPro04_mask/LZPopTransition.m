//
//  LZPopTransition.m
//  LZTransitionPro04_mask
//
//  Created by comst on 15/12/1.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZPopTransition.h"
#import "LZFirstVIewController.h"
#import "LZSecondViewController.h"

@interface LZPopTransition ()

@property (nonatomic, strong) id<UIViewControllerContextTransitioning>  context;
@end
@implementation LZPopTransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return 0.75;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    self.context = transitionContext;
    
    LZFirstVIewController *toVC = (LZFirstVIewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    LZSecondViewController *fromVC = (LZSecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    [containerView addSubview:toView];
    [containerView addSubview:fromView];
    
    CGRect startRect = fromVC.popButton.frame;
    CGFloat x = [UIScreen mainScreen].bounds.size.width - fromVC.popButton.frame.origin.x;
    CGFloat y = [UIScreen mainScreen].bounds.size.height - fromVC.popButton.frame.origin.y;
    CGFloat radius = sqrt(x * x + y * y);
    
    CGRect endRect = CGRectInset(startRect, -radius, -radius);
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:startRect];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:endRect];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    fromView.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id)(endPath.CGPath);
    animation.toValue = (__bridge id)(startPath.CGPath);
    animation.delegate = self;
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:animation forKey:@"maskAnimation"];
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    LZSecondViewController *fromVC = (LZSecondViewController *)[self.context viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromVC.view.layer.mask = nil;
    
    [self.context completeTransition:![self.context transitionWasCancelled]];
}
@end

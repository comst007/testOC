//
//  LZSecondViewController.m
//  LZTransitionPro02_Push_Pop
//
//  Created by comst on 15/11/30.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZSecondViewController.h"
#import "LZFirstViewController.h"
#import "LZPopTransition.h"

@interface LZSecondViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentTransition;
@end
@implementation LZSecondViewController

- (void)viewDidLoad{
    
    self.navigationController.delegate = self;
    
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    gesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gesture];
    
}

- (void)panGestureRecognized:(UIScreenEdgePanGestureRecognizer *)gesture{
    CGFloat distance =  [gesture translationInView:self.view].x;
    CGFloat percent = distance / self.view.bounds.size.width ;
    
    if ([gesture state] == UIGestureRecognizerStateBegan) {
        
        self.percentTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        [self.percentTransition updateInteractiveTransition:percent];
        
    }else if ([gesture state] == UIGestureRecognizerStateChanged){
        
        [self.percentTransition updateInteractiveTransition:percent];
        
    }else if ([gesture state] == UIGestureRecognizerStateEnded || [gesture state] == UIGestureRecognizerStateCancelled){
        if (percent >= 0.5) {
            [self.percentTransition finishInteractiveTransition];
        }else{
            [self.percentTransition cancelInteractiveTransition];
        }
        self.percentTransition = nil ;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if ([toVC isKindOfClass:[LZFirstViewController class]]) {
        
        return [[LZPopTransition alloc] init];
    }
    
    
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    
    if ([animationController isKindOfClass:[LZPopTransition class]]) {
        return self.percentTransition;
    }
    return nil;
}
@end

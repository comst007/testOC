//
//  LZSecondViewController.m
//  LZTransitionPro04_mask
//
//  Created by comst on 15/11/30.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZSecondViewController.h"
#import "LZFirstVIewController.h"
#import "LZPushTransition.h"
#import "LZPopTransition.h"

@interface LZSecondViewController ()<UINavigationControllerDelegate>

@end
@implementation LZSecondViewController

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
        self.popButton.layer.cornerRadius = 25;
    self.popButton.layer.masksToBounds = YES;
    
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(pangestureRecognized:)];
    gesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gesture];
    
}

- (IBAction)popButtonClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pangestureRecognized:(UIPanGestureRecognizer *)gesture{
    
    CGPoint distance = [gesture translationInView:self.view];
    CGFloat percent = distance.x /self.view.bounds.size.width ;
    
     UIGestureRecognizerState state =  [gesture state];
    
    if (state == UIGestureRecognizerStateBegan) {
        self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (state == UIGestureRecognizerStateChanged){
        
        [self.interactiveTransition updateInteractiveTransition:percent];
    }else if (state == UIGestureRecognizerStateCancelled || state == UIGestureRecognizerStateEnded){
        if (percent >= 0.5) {
            [self.interactiveTransition  finishInteractiveTransition];
        }else{
            [self.interactiveTransition cancelInteractiveTransition];
        }
        
        self.interactiveTransition = nil;
        
    }
    
    
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if ([toVC isKindOfClass:[LZSecondViewController class]]) {
        return [[LZPushTransition alloc] init];
    }
    if ([toVC isKindOfClass:[LZFirstVIewController class]]) {
        return [[LZPopTransition alloc] init];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if ([animationController isKindOfClass:[LZPopTransition class]]) {
        
        return self.interactiveTransition;
    }
    return nil;
}
@end

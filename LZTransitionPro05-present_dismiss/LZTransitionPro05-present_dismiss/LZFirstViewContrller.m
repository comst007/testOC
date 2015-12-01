//
//  LZFirstViewContrller.m
//  LZTransitionPro05-present_dismiss
//
//  Created by comst on 15/12/1.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZFirstViewContrller.h"
#import "LZSecondViewController.h"
#import "LZPresentTransition.h"
#import "LZDismissTransition.h"

@interface LZFirstViewContrller ()<LZSecondViewControllerProtocal, UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) LZSecondViewController *toVC;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *presentInteractiveTransition;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *dismissInteractiveTransition;

@end

@implementation LZFirstViewContrller

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
//    self.transitioningDelegate = self;
//    self.modalTransitionStyle = UIModalPresentationCustom;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(rightPanGesture:)];
    gesture.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:gesture];
    
}

- (void)rightPanGesture:(UIScreenEdgePanGestureRecognizer *)gesture{
    
    CGPoint distance = [gesture translationInView:[UIApplication sharedApplication].keyWindow];
   
    
    
    CGFloat percent = - distance.x / [UIScreen mainScreen].bounds.size.width ;
//     NSLog(@"%@, ---- %f", NSStringFromCGPoint(distance), percent);
    
    UIGestureRecognizerState state = [gesture state];
    
    if (state == UIGestureRecognizerStateBegan) {
        
        self.presentInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        LZSecondViewController *toVC = [self viewControllerFromSB];
        self.toVC = toVC;
        toVC.transitioningDelegate = self;
        toVC.dismissDelegate = self;
        [self presentViewController:toVC animated:YES completion:nil];
        
        
    } else if (state == UIGestureRecognizerStateChanged){
        
        [self.presentInteractiveTransition updateInteractiveTransition:percent];
        
    }else if (state == UIGestureRecognizerStateCancelled || state == UIGestureRecognizerStateEnded){
        
        if (percent >= 0.5) {
            [self.presentInteractiveTransition finishInteractiveTransition];
        }else{
            [self.presentInteractiveTransition cancelInteractiveTransition];
        }
        self.presentInteractiveTransition = nil;
    }
    
    
}

- (LZSecondViewController *)viewControllerFromSB{
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    LZSecondViewController *toVC = [SB instantiateViewControllerWithIdentifier:@"LZSecondVC"];
    
    return toVC;
}

- (IBAction)presentButtonClick:(UIButton *)sender {
    
    
    
    LZSecondViewController *toVC = [self viewControllerFromSB];
    toVC.dismissDelegate = self;
    
    toVC.transitioningDelegate = self;
    [self presentViewController:toVC animated:YES completion:^{
         
    }];
}

- (void)secondViewControllerDidDismiss:(LZSecondViewController *)viewController{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    if ([presenting isKindOfClass:[LZFirstViewContrller class]]) {
        return [[LZPresentTransition alloc] init];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    return [[LZDismissTransition alloc] init];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    
    return self.presentInteractiveTransition;
}
@end

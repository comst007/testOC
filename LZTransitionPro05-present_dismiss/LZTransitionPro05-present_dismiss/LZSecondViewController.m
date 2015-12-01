//
//  LZSecondViewController.m
//  LZTransitionPro05-present_dismiss
//
//  Created by comst on 15/12/1.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZSecondViewController.h"
#import "LZFirstViewContrller.h"
#import "LZPresentTransition.h"
@interface LZSecondViewController ()<UIViewControllerTransitioningDelegate>

@end
@implementation LZSecondViewController


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.view.backgroundColor = [UIColor redColor];
//    self.transitioningDelegate = self;
//    self.modalTransitionStyle = UIModalPresentationCustom;
}
- (IBAction)dismissButtonClick:(UIButton *)sender {
    
    if (self.dismissDelegate && [self.dismissDelegate respondsToSelector:@selector(secondViewControllerDidDismiss:)]) {
        [self.dismissDelegate secondViewControllerDidDismiss:self];
    }
}


@end

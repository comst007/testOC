//
//  LZModalViewController.m
//  LZTransitionPro
//
//  Created by comst on 15/11/29.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZModalViewController.h"

@interface LZModalViewController ()

@end

@implementation LZModalViewController
- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.4 green:0.7 blue:0.2 alpha:0.8];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor cyanColor];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"dismiss" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)btnClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(modalViewcontrollerDidDismiss:)]) {
        [self.delegate modalViewcontrollerDidDismiss:self];
    }
}

@end

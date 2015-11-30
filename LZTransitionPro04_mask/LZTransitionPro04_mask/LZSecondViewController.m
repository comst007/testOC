//
//  LZSecondViewController.m
//  LZTransitionPro04_mask
//
//  Created by comst on 15/11/30.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZSecondViewController.h"

@implementation LZSecondViewController

- (void)viewDidLoad{
    
    self.popButton.layer.cornerRadius = 25;
    self.popButton.layer.masksToBounds = YES;
    
}

- (IBAction)popButtonClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end

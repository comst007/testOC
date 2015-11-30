//
//  ViewController.m
//  LZTransitionPro
//
//  Created by comst on 15/11/29.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZModalViewController.h"
#import "LZPresentAnimation.h"
@interface ViewController ()<LZModalViewControllerDelegate, UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) LZPresentAnimation *presentAnimation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.modalTransitionStyle = UIModalPresentationCustom;

    self.presentAnimation = [[LZPresentAnimation alloc] init];
    
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    button.center = self.view.center;
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    
    [button addTarget:self action:@selector(buttonCLick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonCLick{
    
    
    LZModalViewController *modalVC = [[LZModalViewController alloc] init];
    modalVC.transitioningDelegate = self;
    modalVC.delegate = self;
    [self presentViewController:modalVC animated:YES completion:nil];
    
    
}
- (void)modalViewcontrollerDidDismiss:(LZModalViewController *)modalVC{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return self.presentAnimation;
}
@end

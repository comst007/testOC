//
//  LZSecondViewController.h
//  LZTransitionPro05-present_dismiss
//
//  Created by comst on 15/12/1.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZSecondViewController;

@protocol LZSecondViewControllerProtocal <NSObject>

- (void)secondViewControllerDidDismiss:(LZSecondViewController *)viewController;

@end

@interface LZSecondViewController : UIViewController

@property (nonatomic, weak) id<LZSecondViewControllerProtocal>  dismissDelegate;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;


- (IBAction)dismissButtonClick:(UIButton *)sender;


@end

//
//  LZModalViewController.h
//  LZTransitionPro
//
//  Created by comst on 15/11/29.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZModalViewController;

@protocol LZModalViewControllerDelegate <NSObject>

- (void)modalViewcontrollerDidDismiss:(LZModalViewController *)modalVC;

@end

@interface LZModalViewController : UIViewController

@property (nonatomic, weak) id<LZModalViewControllerDelegate> delegate;

@end

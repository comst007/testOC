//
//  LZUserInfoViewController.m
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZUserInfoViewController.h"
#import "LZDownLoadRequest.h"
#import "LZGlobal.h"
#import "LZDownloadButton.h"
#import "LZIconRequest.h"
#import "MBProgressHUD.h"
@interface LZUserInfoViewController ()
@property (nonatomic, strong) LZDownLoadRequest *request;
@property (weak, nonatomic) IBOutlet UILabel *aboutSelfLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headiconImageview;
@property (weak, nonatomic) IBOutlet LZDownloadButton *downloadButton;
@property (nonatomic, assign) BOOL isProgressing;
@end

@implementation LZUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [LZGlobal sharedglobal].userinfo.username;
    [UIView animateWithDuration:1.0 animations:^{
        self.view.alpha = 1.0;
    }];
    self.aboutSelfLabel.text = [LZGlobal sharedglobal].userinfo.aboutself;
    
    LZIconRequest *iconRequest = [[LZIconRequest alloc] init];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [iconRequest headIconRequest:[LZGlobal sharedglobal].userinfo.headiconURL completionHandler:^(LZIconRequest *iconRequest) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            if (iconRequest.headIconImage != nil) {
                self.headiconImageview.image = iconRequest.headIconImage;
            }else{
                
                MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:self.view];
                alert.minShowTime = 2;
                alert.mode = MBProgressHUDModeText;
                alert.labelText = @"headIcon 加载失败";
                self.hidesBottomBarWhenPushed = YES;
                [self.view addSubview:alert];
                [alert show:YES];
                [alert hide:YES afterDelay:2];
            }
            
        });
        
    }];
    
    
}

- (void)animationDidStart:(CAAnimation *)anim{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

}
@end

//
//  LZUserInfoViewController.m
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZUserInfoViewController.h"
#import "LZDownLoadRequest.h"
@interface LZUserInfoViewController () <LZDownloadRequestDelegate>
@property (nonatomic, strong) LZDownLoadRequest *request;
@end

@implementation LZUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)downloadRequestDidRecieveData:(LZDownLoadRequest *)downloadRequest{
    NSLog(@"-----%lf", downloadRequest.progress);
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSString *path = @"http://120.24.236.135/Comst/hello.c";
//    LZDownLoadRequest *request = [[LZDownLoadRequest alloc] init];
//    self.request = request;
//    [request downloadRequest:path delegate:self];

}
@end

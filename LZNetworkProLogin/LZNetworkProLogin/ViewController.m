//
//  ViewController.m
//  LZNetworkProLogin
//
//  Created by comst on 15/10/14.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZRequest.h"
@interface ViewController ()
@property (nonatomic, strong) LZRequest *request;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.request sendRequest:@"comst123" password:@"123456"];
    
}

- (LZRequest *)request{
    if (!_request) {
        _request = [[LZRequest alloc] init];
    }
    return _request;
}

@end

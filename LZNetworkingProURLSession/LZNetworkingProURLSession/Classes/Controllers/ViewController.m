//
//  ViewController.m
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZLoginRequest.h"
#import "MBProgressHUD.h"
#import "KeychainItemWrapper.h"
#import "LZGlobal.h"
#import "LZParser.h"
#import "AppDelegate.h"
#define kKeychainID @"comst1314.com.201510081230"
#define kRememberPassword @"remeberpassword"
#define kUsername @"username"
#define kUserpassword @"password"
@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *userpasswordTextfield;
@property (weak, nonatomic) IBOutlet UISwitch *passwordSwitch;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) LZLoginRequest *loginRequest;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton.layer.cornerRadius = self.loginButton.frame.size.height * 0.5;
    self.loginButton.layer.masksToBounds = YES;
    // Do any additional setup after loading the view, typically from a nib.
    self.passwordSwitch.on = [[[NSUserDefaults standardUserDefaults] valueForKey:kRememberPassword] boolValue];
    
    if (self.passwordSwitch.isOn) {
        KeychainItemWrapper *item = [[KeychainItemWrapper alloc] initWithIdentifier:kKeychainID accessGroup:nil];
        
        [item setObject:@"urlseesionlogin" forKey:(__bridge id)(kSecAttrAccount)];
        [item setObject:(__bridge id)(kSecAttrAccessibleWhenUnlocked) forKey:(__bridge id)(kSecAttrAccessible)];
        NSString  *dataString = [item objectForKey:(__bridge id)(kSecValueData)];
        
        NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *userDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.usernameTextfield.text = userDict[kUsername];
        self.userpasswordTextfield.text = userDict[kUserpassword];
    }
}



- (IBAction)loginClick:(UIButton *)sender {
    
    if (self.loginRequest) {
        return;
    }
    
    
    NSString *username = @"zhangsan" ; //self.usernameTextfield.text;
    NSString *password = @"zhang" ; // self.userpasswordTextfield.text;
    if ([username length] == 0 || [password length] == 0) {
        MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:self.view];
        alert.mode = MBProgressHUDModeText;
        alert.minShowTime = 1;
        alert.removeFromSuperViewOnHide = YES;
        alert.labelText = @"用户名和密码不能为空！";
        [self.view addSubview:alert];
        
        [alert show:YES];
        
        [alert hide:YES afterDelay:1];
    }
    
     __weak typeof(self) weakSelf = self;
    
    LZLoginRequest *loginRequest = [[LZLoginRequest alloc] init];
    self.loginRequest = loginRequest;
    
    [loginRequest loginRequestWithUsername:username password:password completionHandler:^(LZLoginRequest *loginrequest) {
        
        weakSelf.loginRequest  = nil;
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:loginRequest.responseData options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *userDict = @{kUsername:username, kUserpassword:password};
        NSData *userData = [NSJSONSerialization dataWithJSONObject:userDict options:NSJSONWritingPrettyPrinted error:nil];
        
        if ([responseDic[@"userId"] integerValue] == 1) {
            
            KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:kKeychainID accessGroup:nil];
            
            [keychainItem setObject:@"urlseesionlogin" forKey:(__bridge id)(kSecAttrAccount)];
            [keychainItem setObject:(__bridge id)(kSecAttrAccessibleWhenUnlocked) forKey:(__bridge id)(kSecAttrAccessible)];
            NSString *dataString = [[NSString alloc] initWithData:userData encoding:NSUTF8StringEncoding];
            [keychainItem setObject:dataString forKey:(__bridge id)(kSecValueData)];
            
            
            LZParser *parser = [[LZParser alloc] init];
            [LZGlobal sharedglobal].userinfo = [parser parseUserinfoFromJsonData:loginRequest.responseData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
                transformAnimation.fromValue = @(0);
                transformAnimation.toValue = @(M_PI * 0.5);
                transformAnimation.delegate = self;
                transformAnimation.duration = 1;
                transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                [self.view.layer addAnimation:transformAnimation forKey:@"rotationAnimation"];
                
                CABasicAnimation *alpahAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
                alpahAnimation.fromValue = @1;
                alpahAnimation.delegate = self;
                alpahAnimation.duration = 0.8;
                alpahAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                
                [self.view.layer addAnimation:alpahAnimation forKey:@"alphaAnimation"];
//
//                CAAnimationGroup *groupAnimation = [[CAAnimationGroup alloc] init];
//                
//                groupAnimation.animations = @[transformAnimation, alpahAnimation];
//                
//                [self.view.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
            });
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:self.view];
                alert.minShowTime = 2;
                alert.mode = MBProgressHUDModeText;
                alert.labelText = @"用户名密码不正确";
                self.hidesBottomBarWhenPushed = YES;
                [self.view addSubview:alert];
                [alert show:YES];
                [alert hide:YES afterDelay:2];
            });
            
        }
        
    }];
    
}

- (void)animationDidStart:(CAAnimation *)anim{
    
    if ([self.view.layer animationForKey:@"rotationAnimation"] == anim) {
        self.view.alpha = 0;
    }
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
            
        [self.view.layer removeAllAnimations];
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate loadUserinfoFrame];
        
    
    
    //NSLog(@" animation end: %@ ", anim);

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (IBAction)switchValueChanged:(UISwitch *)sender {
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
    [userdefaults setValue:@(self.passwordSwitch.on) forKey:kRememberPassword];
    
    [userdefaults synchronize];
    
}

@end

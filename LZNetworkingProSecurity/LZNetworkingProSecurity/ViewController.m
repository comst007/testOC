//
//  ViewController.m
//  LZNetworkingProSecurity
//
//  Created by comst on 15/10/16.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
#import "KeychainItemWrapper.h"
#define kRememberPassword @"rememberPassword"
#define kLoginUserName  @"loginUserName"
#define kLoginUserPassword @"loginUserPassword"
#import "LZRequest.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *userpasswordTextfield;
@property (weak, nonatomic) IBOutlet UISwitch *passwordSwitcher;
@property (nonatomic, strong) MBProgressHUD *alertview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BOOL ifRememberPassword = [[NSUserDefaults standardUserDefaults] valueForKey:kRememberPassword];
    if (ifRememberPassword == YES) {
        KeychainItemWrapper *dataItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"comst1314.com.logindata" accessGroup:nil];
//        NSString *account = [dataItem objectForKey:(__bridge id)(kSecAttrAccount)];
        NSString *dataString  = [dataItem objectForKey:(__bridge id)(kSecValueData)];
        NSData *dictData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:dictData options:NSJSONReadingMutableContainers error:nil];
        self.usernameTextfield.text = dict[@"name"];
        self.userpasswordTextfield.text = dict[@"password"] ;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (IBAction)rememberPassword:(UISwitch *)sender {
    
    //self.passwordSwitcher.on = !self.passwordSwitcher.on;
    [[NSUserDefaults standardUserDefaults] setValue:@(sender.isOn) forKey:kRememberPassword];
    
}
- (IBAction)logIn:(UIButton *)sender {
    if ([self.usernameTextfield.text length] == 0 || [self.userpasswordTextfield.text length] == 0) {
        //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        self.alertview = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.alertview];
        self.alertview.labelText = @"username or password not empty";
        self.alertview.mode = MBProgressHUDModeCustomView;
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, 37, 37);
        imageView.image = [UIImage imageNamed:@"error"];;
        self.alertview.customView = imageView;
        //self.alertview.minShowTime = 5;
        self.alertview.removeFromSuperViewOnHide = YES;
        [self.alertview show:YES];
        [self.alertview hide:YES afterDelay:1];
        return;
    }
    NSString *username = self.usernameTextfield.text;
    NSString *password = self.userpasswordTextfield.text;
    username = [self encodeToBase64String:username];
    password = [self encodeToBase64String:password];
    NSLog(@"base64: %@, %@", username, password);
    LZRequest *request = [[LZRequest alloc] init];
    [request loginRequestWithName:username password:password  completionHandler:^(NSURLResponse *response, NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSString *res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"retur: %@", dict);
        if ([dict[@"userId"] intValue] == 1) {
            
            if (self.passwordSwitcher.isOn) {
//                [[NSUserDefaults standardUserDefaults] setValue:username forKey:kLoginUserName];
//                [[NSUserDefaults standardUserDefaults] setValue:password forKey:kLoginUserPassword];
//                [[NSUserDefaults standardUserDefaults] synchronize];
                [self saveToKeychain];
            }
        }
    }];
    
}

- (NSString *)encodeToBase64String:(NSString *)source{
    
    NSData *data = [ source dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions: 0];

}

- (NSString *)decodeFromBase64String:(NSString *)source{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:source options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
//    NSLog(@"subview: %@", self.view.subviews);
}

- (void)saveToKeychain{
    
    KeychainItemWrapper *userNameKaychainItem =[[KeychainItemWrapper alloc] initWithIdentifier:@"comst1314.com.logindata" accessGroup:nil];
    [userNameKaychainItem setObject:@"logindata" forKey:(__bridge id)(kSecAttrAccount)];
    [userNameKaychainItem setObject:(__bridge id)(kSecAttrAccessibleWhenUnlocked) forKey:(__bridge id)(kSecAttrAccessible)];
    
    NSDictionary *dict = @{@"name":self.usernameTextfield.text, @"password":self.userpasswordTextfield.text};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [userNameKaychainItem setObject:dataString forKey:(__bridge id)(kSecValueData)];
    
    
    
    
}
@end

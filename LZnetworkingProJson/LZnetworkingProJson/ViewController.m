//
//  ViewController.m
//  LZnetworkingProJson
//
//  Created by comst on 15/10/14.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary *dict = @{@"name":@"comst", @"age":@23, @"email":@"123456789.qq.com"};
    NSString *urlString = @"http://120.24.236.135/Comst/post/postjson.php";
    NSURL *URL = [NSURL URLWithString:urlString];
    NSMutableURLRequest *requestM = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLErrorNotConnectedToInternet timeoutInterval:20];
    requestM.HTTPMethod = @"POST";
    if ([NSJSONSerialization isValidJSONObject:dict] == NO) {
        NSLog(@"JsonData invalid");
        return;
    }
    requestM.HTTPBody = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    
    [NSURLConnection sendAsynchronousRequest:requestM queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (connectionError == nil && httpResponse.statusCode == 200) {
            NSLog(@"--- %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            
            //id recv = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //NSLog(@"-------%@", recv);
        }
    }];
}


@end

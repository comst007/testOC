//
//  ViewController.m
//  LZNetworkingPro03Upload
//
//  Created by comst on 15/10/14.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZMultipartForm.h"
#import "NSString+LZMIMETYPE.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
/**
 *  Content-Type
 multipart/form-data; boundary=---------------------------11831781002123239127544245290
 *
 *  @param touches <#touches description#>
 *  @param event   <#event description#>
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSString *postURLString = @"http://120.24.236.135/Comst/post/upload.php";
    NSURL *postURL = [NSURL URLWithString:postURLString];
    NSMutableURLRequest *requestM = [[NSMutableURLRequest alloc] initWithURL:postURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    requestM.HTTPMethod = @"POST";
    
    LZMultipartForm *form = [[LZMultipartForm alloc] init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Singleton.png" ofType:nil];
    
    [form addFile:filePath forField:@"userfile"];
    requestM.HTTPBody = [form httpBody];
    
    NSString *headValue = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", form.httpBoundary];
    [requestM setValue:headValue forHTTPHeaderField:@"Content-Type"];
    
    
    [NSURLConnection sendAsynchronousRequest:requestM queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (connectionError == nil && httpResponse.statusCode == 200) {
            NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@", res);
        }
    }];
}

@end

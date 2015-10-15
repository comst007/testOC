//
//  ViewController.m
//  LZNetworkingProDownload
//
//  Created by comst on 15/10/15.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZProgressView.h"
@interface ViewController ()<NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, assign) long long totalLength;
@property (nonatomic, assign) long  long  currentLength;
@property (nonatomic, strong) NSFileHandle *handleWrite;
@property (nonatomic, strong) NSString *filepath;
@property (nonatomic, strong) LZProgressView *progreeView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.downloadButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    [self.downloadButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.progreeView = [[LZProgressView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:self.progreeView];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 *  Range: bytes=0-801
 *
 *  @param sender <#sender description#>
 */
- (void)btnClick:(UIButton *)sender{
    self.downloadButton.selected = !self.downloadButton.selected;
    if (self.downloadButton.selected == NO) {
        [self.connection cancel];
        self.connection = nil;
    }else{
        
        NSString *urlString = @"http://120.24.236.135/Comst/hello.c";
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *requestURL = [NSURL URLWithString:urlString];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
        
        NSString *rangString = [NSString stringWithFormat:@"bytes=%lli-", self.currentLength];
        [request setValue:rangString forHTTPHeaderField:@"Range"];
        
        self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        [self.connection start];
        
    }
    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"connect fail");
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSLog(@"%@", [httpResponse allHeaderFields]);
//    if (httpResponse.statusCode != 200) {
//        NSLog(@"client wrong------");
//        return;
//    }
    if (self.currentLength == 0) {
        
        NSString *fileName = httpResponse.suggestedFilename;
        self.totalLength = 73912610;
        // NSLog(@"total:---%lli", self.`);
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"path: %@", path);
        
        path = [path stringByAppendingPathComponent:fileName];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
        
        if ([[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil] == NO) {
            NSLog(@"file create fail");
        }
        
        self.filepath = path;
        self.handleWrite = [NSFileHandle fileHandleForWritingAtPath:path];
        
    }
    
 
    
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.handleWrite seekToEndOfFile];
    [self.handleWrite writeData:data];
    
    self.currentLength = self.currentLength + [data length];
    
    //NSLog(@"-----------%.2f", self.currentLength / (self.totalLength * 1.0));
    self.progreeView.progress = self.currentLength / (self.totalLength * 1.0);
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self.handleWrite closeFile];
    NSLog(@"over");
    NSLog(@"%@", self.filepath);
    self.currentLength = 0;
    self.downloadButton.selected = NO;
    self.connection = nil;
    self.handleWrite = nil;
}




@end

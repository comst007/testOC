//
//  ViewController.m
//  LZNetworkPro02-dataParser
//
//  Created by comst on 15/10/12.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZCell.h"
#import "LZVedioItem.h"
#import "LZVedioRequest.h"
#import "LZVedioParser.h"
@interface ViewController ()
@property (nonatomic, copy) NSArray *arrayOfCourse;
@property (nonatomic, strong) LZVedioRequest *vedioRequest;
@property (nonatomic, strong) LZVedioParser *parser;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak typeof(self) weakSelf = self;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.vedioRequest sendVedioRequest:@"http://120.24.236.135/Comst/videos.xml" completeHandler:^(NSData *recvData, NSError *error) {
        if (error == nil) {
            
            weakSelf.arrayOfCourse = [weakSelf.parser parserVedioXML:recvData];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                [weakSelf.tableView reloadData];
            }];
            
        }
    }];
    
}



#pragma mark - tableview datasource delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrayOfCourse count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LZCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZCell"];
    
    cell.currentVedioItem = self.arrayOfCourse[indexPath.row];
    
    return cell;
}

- (LZVedioRequest *)vedioRequest{
    if (!_vedioRequest) {
        _vedioRequest = [[LZVedioRequest alloc] init];
    }
    return _vedioRequest;
}
- (LZVedioParser *)parser{
    if (!_parser) {
        _parser = [[LZVedioParser alloc] init];
    }
    return _parser;
}
@end

//
//  ViewController.m
//  LZtableviewLoadImage
//
//  Created by comst on 15/10/8.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZAppInfo.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[LZAppInfo arrayOfAppInfo] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZCell"];
    
    LZAppInfo *appItem = [[LZAppInfo arrayOfAppInfo] objectAtIndex:indexPath.row];
    cell.textLabel.text = appItem.name;
   
    cell.detailTextLabel.attributedText = [self LZColoredString:appItem.download];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:appItem.icon]];
    
    UIImage *iconImage = [UIImage imageWithData:imageData];
    
    cell.imageView.image = iconImage;
    
    return cell;
}

- (NSMutableAttributedString *)LZColoredString:(NSString *)source{
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:source];
    NSRange range1 = [source rangeOfString:@"万"];
    NSRange range2 = NSMakeRange(0, range1.location);
    [attrString setAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]} range:range2];
    return attrString;
}

@end

//
//  ViewController.m
//  LZtableviewLoadImage
//
//  Created by comst on 15/10/8.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZAppInfo.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"
@interface ViewController ()
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSCache *imageCache;
@property (nonatomic, strong) NSMutableDictionary *operationDicM;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self networkStatus];
}

- (void)networkStatus{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[LZAppInfo arrayOfAppInfo] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZCell"];
    
    LZAppInfo *appItem = [[LZAppInfo arrayOfAppInfo] objectAtIndex:indexPath.row];
    cell.textLabel.text = appItem.name;
    
    cell.detailTextLabel.attributedText = [self LZColoredString:appItem.download];
    
    //[cell.imageView sd_setImageWithURL:[NSURL URLWithString:appItem.icon] placeholderImage:[UIImage imageNamed:@"user_default"]];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:appItem.icon] placeholderImage:[UIImage imageNamed:@"user_default"] options:SDWebImageProgressiveDownload | SDWebImageCacheMemoryOnly];
    //[cell.imageView];
    
//    id imageData = [self.imageCache objectForKey:appItem.icon];
//    
//    if (imageData) {
//        NSLog(@"memery");
//        UIImage *iconImage = [UIImage imageWithData:imageData];
//        cell.imageView.image = iconImage;
//    }else{
//        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *iconName = [appItem.icon lastPathComponent];
//        
//        NSString *iconPath = [NSString stringWithFormat:@"%@/%@", path, iconName];
//        
//        BOOL ifExist = [[NSFileManager defaultManager] fileExistsAtPath:iconPath];
//        
//        if (ifExist) {
//            NSLog(@"sandbox");
//            NSData *imageData = [NSData dataWithContentsOfFile:iconPath];
//            UIImage *iconImage = [UIImage imageWithData:imageData];
//            cell.imageView.image = iconImage;
//            [self.imageCache setObject:imageData forKey:appItem.icon];
//            
//        }else{
//            cell.imageView.image = [UIImage imageNamed:@"user_default"];
//            if (self.operationDicM[appItem.icon] == nil) {
//                NSLog(@"network");
//                __weak typeof(self) weakSelf = self;
//                NSBlockOperation *iconOperation = [NSBlockOperation blockOperationWithBlock:^{
//                    
//                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:appItem.icon]];
//                    if (imageData) {
//                        
//                        [imageData writeToFile:iconPath atomically:YES];
//                        [weakSelf.imageCache setObject:imageData forKey:appItem.icon];
//                        
//                    }
//                    
//                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                        
//                        
//                        
//                        [weakSelf.operationDicM removeObjectForKey:appItem.icon];
//                        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
//                        
//                    }];
//                    
//                }];
//                [self.operationQueue addOperation:iconOperation];
//                self.operationDicM[appItem.icon] = iconOperation;
//            }else{
//                
//                NSLog(@"operation exist");
//            }
//        }
//    }
//    
    
    
    
    return cell;
}
//
- (NSMutableAttributedString *)LZColoredString:(NSString *)source{
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:source];
    NSRange range1 = [source rangeOfString:@"万"];
    NSRange range2 = NSMakeRange(0, range1.location);
    [attrString setAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]} range:range2];
    return attrString;
}


- (NSOperationQueue *)operationQueue{
    
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return _operationQueue;
}

- (NSCache *)imageCache{
    
    if (!_imageCache) {
        _imageCache = [[NSCache alloc] init];
    }
    return _imageCache;
}

- (NSMutableDictionary *)operationDicM{
    
    if (!_operationDicM) {
        
        _operationDicM = [[NSMutableDictionary alloc] init];
        
    }
    return _operationDicM;
}
@end


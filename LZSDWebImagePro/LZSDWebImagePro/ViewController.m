//
//  ViewController.m
//  LZtableviewLoadImage
//
//  Created by comst on 15/10/8.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

/*
 
 typedef enum : NSInteger {
	NotReachable = 0,
	ReachableViaWiFi,
	ReachableViaWWAN
 } NetworkStatus;

 
 
 */
/*
 
 -----------------------------971210516111941565206208183
   ---------------------------971210516111941565206208183
 */
#import "ViewController.h"
#import "LZAppInfo.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"
@interface ViewController () <UIAlertViewDelegate>
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSCache *imageCache;
@property (nonatomic, strong) NSMutableDictionary *operationDicM;
@property (nonatomic, strong) Reachability *reach;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusChanged:) name:kReachabilityChangedNotification object:nil];
    [self networkStatus];
}

- (void)statusChanged:(NSNotification *)noti{

    
    Reachability *reach = [noti object];
    NSLog(@"status changed: current status: %@", [self statusString:[reach currentReachabilityStatus]]);
    
    
}

- (NSString *)statusString:(NetworkStatus)status{
    NSString *statusDesp = @"" ;
    switch (status) {
        case NotReachable:
            
            statusDesp = @"NotReachable";
            break;
            
        case ReachableViaWiFi:
            
            statusDesp = @"ReachableViaWifi";
            break;
            
        case ReachableViaWWAN:
            statusDesp = @"ReachableViaWAN";
            break;
            
        default:
            break;
            
    }
    return statusDesp;

}
- (void)networkStatus{
    self.reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self.reach startNotifier];
    NetworkStatus status = [self.reach currentReachabilityStatus];
    NSString *statusDesp = [self statusString:status];
   
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:statusDesp message:@"status" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
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


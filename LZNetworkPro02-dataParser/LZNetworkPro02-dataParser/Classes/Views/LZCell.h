//
//  LZCell.h
//  LZNetworkPro02-dataParser
//
//  Created by comst on 15/10/14.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZVedioItem.h"
@interface LZCell : UITableViewCell

@property (nonatomic, strong) LZVedioItem *currentVedioItem;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *nameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *authorLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *descLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *timeLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *vedioImage;

@end

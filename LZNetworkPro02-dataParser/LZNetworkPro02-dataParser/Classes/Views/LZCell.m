//
//  LZCell.m
//  LZNetworkPro02-dataParser
//
//  Created by comst on 15/10/14.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZCell.h"
#import "UIImageView+WebCache.h"
@implementation LZCell

- (void)setCurrentVedioItem:(LZVedioItem *)currentVedioItem{
    _currentVedioItem = currentVedioItem;
    self.nameLabel.text = currentVedioItem.name;
    self.descLabel.text = currentVedioItem.desc;
  
    
    self.timeLabel.text = [NSString stringWithFormat:@"%i:%i", [currentVedioItem.length intValue] / 60, [currentVedioItem.length intValue] % 60];
    
    NSString *imageURL = [NSString stringWithFormat:@"http://120.24.236.135/%@", currentVedioItem.imageURL];
    [self.vedioImage sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"user_default"] options:SDWebImageLowPriority | SDWebImageRetryFailed | SDWebImageRefreshCached | SDWebImageCacheMemoryOnly];
    
    
    
    self.authorLabel.text = currentVedioItem.teacher;
    
    
    
}

@end

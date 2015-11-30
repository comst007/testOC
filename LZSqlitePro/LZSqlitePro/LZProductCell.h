//
//  LZProductCell.h
//  LZSqlitePro
//
//  Created by comst on 15/10/30.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZProduct.h"
#import "LZCellView.h"
@interface LZProductCell : UITableViewCell

@property (nonatomic, strong) LZProduct *currentProduct;


@property (weak, nonatomic)  LZCellView *productView;

@end

//
//  LZProductCell.m
//  LZSqlitePro
//
//  Created by comst on 15/10/30.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZProductCell.h"


@interface LZProductCell ()


@property (weak, nonatomic) IBOutlet UIImageView *nameImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *countryImageview;

@end

@implementation LZProductCell




- (void)setCurrentProduct:(LZProduct *)currentProduct{
    
    _currentProduct = currentProduct;
    
    self.nameImageView.image = [UIImage imageNamed:currentProduct.image];
    self.nameLabel.text = currentProduct.name;
    self.detailLabel.text = currentProduct.details;
    self.priceLabel.text = [currentProduct.price stringValue];
    self.countryImageview.image = [UIImage imageNamed:currentProduct.country];
    
    
}

@end

//
//  LZCellView.m
//  LZSqlitePro
//
//  Created by comst on 15/10/30.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZCellView.h"

@implementation LZCellView



- (void)drawRect:(CGRect)rect{
   
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    
    //productName
    UIImage *productImage = [UIImage imageNamed:self.currentProduct.image];
    
    CGFloat imageX = 10;
    CGFloat imageW = 50;
    CGFloat imageH = 50;
    CGFloat imageY = (viewHeight - imageH) * 0.5;
    
    [productImage drawInRect:CGRectMake(imageX, imageY, imageW, imageH)];
    
    
    //country
    UIImage *countryImage = [UIImage imageNamed:self.currentProduct.country];
    
    CGFloat countryW = 80;
    CGFloat countryH = 50;
    CGFloat countryY = (viewHeight - countryH) * 0.5;
    CGFloat countryX = viewWidth - 10 - countryW;
    [countryImage drawInRect:CGRectMake(countryX, countryY, countryW, countryH)];
    
    
    //price
    NSString *price = [self.currentProduct.price stringValue];
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.alignment = NSTextAlignmentCenter;
    
    CGFloat priceH = viewHeight - 10;
    CGFloat priceW = 40;
    CGFloat priceY = 5;
    CGFloat priceX = countryX - 3 - priceW;
    
    [price drawInRect:CGRectMake(priceX, priceY, priceH, priceW) withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor greenColor], NSParagraphStyleAttributeName: paraStyle}];
    
    //name
    CGFloat nameX = imageX + imageW + 3;
    CGFloat nameY = 3;
    CGFloat nameW = priceX - nameX - 3;
    CGFloat nameH = (viewHeight - 6) * 0.6;
    
    NSMutableParagraphStyle *nameStyle = [[NSMutableParagraphStyle alloc] init];
    nameStyle.alignment = NSTextAlignmentCenter;
    nameStyle.lineBreakMode = NSLineBreakByTruncatingMiddle;
    
    [self.currentProduct.name drawInRect:CGRectMake(nameX, nameY, nameW, nameH) withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor blueColor], NSParagraphStyleAttributeName:nameStyle}];
    
    //detail
    CGFloat detailY = nameY + nameH;
    CGFloat detailX = nameX;
    CGFloat detailW = nameW;
    CGFloat detailH = (viewHeight - 6) * 0.4;
    
    NSMutableParagraphStyle *detailStyle = [[NSMutableParagraphStyle alloc] init];
    detailStyle.alignment = NSTextAlignmentCenter;
    detailStyle.lineBreakMode = NSLineBreakByTruncatingMiddle;
    
     [self.currentProduct.details drawInRect:CGRectMake(detailX, detailY, detailW, detailH) withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor grayColor], NSParagraphStyleAttributeName:detailStyle}];
   
}



- (void)setCurrentProduct:(LZProduct *)currentProduct{
    
    _currentProduct = currentProduct;
    [self setNeedsDisplay];
    
}

@end

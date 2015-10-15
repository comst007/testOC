//
//  LZProgressView.m
//  LZNetworkingProDownload
//
//  Created by comst on 15/10/15.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZProgressView.h"
#import <CoreGraphics/CoreGraphics.h>
@implementation LZProgressView


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _progress = 0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5 - 5;
    CGFloat centerX = rect.size.width * 0.5;
    CGFloat centerY = rect.size.height * 0.5;
    CGContextAddArc(ctx, centerX, centerY, radius, 0, M_PI * 2, 0);
    CGContextStrokePath(ctx);
    [[UIColor blueColor] set];
    CGContextSetLineWidth(ctx, 5);
    CGFloat endAngle = M_PI * 2 * self.progress - M_PI_4;
    
    CGContextAddArc(ctx, centerX, centerY, radius, - M_PI_4, endAngle, 0);
    
    CGContextStrokePath(ctx);
    NSString *progressString = [NSString stringWithFormat:@"%04.2f%%", self.progress * 100];
    [progressString drawInRect:CGRectMake(centerX - 25, centerY - 10, 60, 60)
                withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor purpleColor]}];
    
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}
@end

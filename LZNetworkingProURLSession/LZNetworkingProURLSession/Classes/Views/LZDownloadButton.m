//
//  LZDownloadButton.m
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZDownloadButton.h"
#import "LZDownLoadRequest.h"
@interface LZDownloadButton ()<LZDownloadRequestDelegate>

@property (nonatomic, strong) LZDownLoadRequest *request;

@property (nonatomic, assign) CGRect orignalFrame;

@property (nonatomic, strong) UIBezierPath *progressPath;

@property (nonatomic, strong) CAShapeLayer *progressShapeLayer;

@property (nonatomic, strong) UIImageView *imageview;

@property (nonatomic, assign) BOOL isProgressing;
@property (nonatomic, assign) BOOL paused;
@end

@implementation LZDownloadButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {

        [self setup];
        
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup{
    
    self.orignalFrame = self.frame;
    self.imageview = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.imageview];
    self.imageview.image = [UIImage imageNamed:@"downloadicon"];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapped)];
    
    [self addGestureRecognizer:tapGesture];
   
}

- (void)buttonTapped{
    
    if (self.isProgressing == NO) {
        
        [self beginDownload];
    }else{
        //断点续传
        if (self.paused) {
            [self.request downloadRequestRsume];
            self.paused = NO;
        }else{
            self.paused = YES;
            [self.request downloadRequestPause];
        }
    }
    
    
}

- (void)beginDownload{
    
    self.userInteractionEnabled = NO;
    self.orignalFrame = self.frame;
    [self.imageview removeFromSuperview];
    self.layer.cornerRadius = self.progressBarHeight * 0.5;
    
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
    CABasicAnimation *cornerRadiusShrinkAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    
    cornerRadiusShrinkAnimation.fromValue = @(self.orignalFrame.size.height * 0.5);
    cornerRadiusShrinkAnimation.duration = 0.3;
    cornerRadiusShrinkAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    cornerRadiusShrinkAnimation.delegate = self;
    [self.layer addAnimation:cornerRadiusShrinkAnimation forKey:@"cornerRadiusShrinkAnimation"];
    
}

- (void)animationDidStart:(CAAnimation *)anim{
    
    
    if ([self.layer animationForKey:@"cornerRadiusShrinkAnimation"] == anim) {
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.bounds = CGRectMake(0, 0, self.progressBarWidth, self.progressBarHeight);
        } completion:^(BOOL finished) {
            NSLog(@"%@", [NSThread currentThread]);
            [self.layer removeAnimationForKey:@"cornerRadiusShrinkAnimation"];
            
            self.userInteractionEnabled = YES;
            
            self.isProgressing = YES;
            NSString *path = @"http://120.24.236.135/Comst/杨-kiss.mp3";
            LZDownLoadRequest *request = [[LZDownLoadRequest alloc] init];
            self.request = request;
            [request downloadRequest:path delegate:self];
            
        }];
    }
    
    if ([self.layer animationForKey:@"cornerRadiusExpandAnimation"] == anim) {
        
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.bounds = CGRectMake(0, 0, self.orignalFrame.size.width, self.orignalFrame.size.height);
        } completion:^(BOOL finished) {
            [self.layer removeAnimationForKey:@"cornerRadiusExpandAnimation"];
            [self checkmarkAnimation];
        }];
        
    }
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    NSString *animName = [anim valueForKey:@"animationName"];
    
    if ([animName isEqualToString:@"checkAnimation"]) {
        
        //NSLog(@"thread:-----%@", [NSThread currentThread]);
        [self performSelector:@selector(removeSublayers) withObject:nil afterDelay:1.0];
        
    }
}

- (void)removeSublayers{
    
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
    }
    self.progressShapeLayer = nil;
    self.progressPath = nil;
    [self addSubview:self.imageview];
    self.userInteractionEnabled = YES;
}

- (void)checkmarkAnimation{
    
    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGRect rectInCircle = CGRectInset(self.bounds, self.bounds.size.width*(1-1/sqrt(2.0))/2, self.bounds.size.width*(1-1/sqrt(2.0))/2);
    [path moveToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width/9, rectInCircle.origin.y + rectInCircle.size.height*2/3)];
    [path addLineToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width/3,rectInCircle.origin.y + rectInCircle.size.height*9/10)];
    [path addLineToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width*8/10, rectInCircle.origin.y + rectInCircle.size.height*2/10)];
    
    checkLayer.path = path.CGPath;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.strokeColor = [UIColor whiteColor].CGColor;
    checkLayer.lineWidth = 10.0;
    checkLayer.lineCap = kCALineCapRound;
    checkLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:checkLayer];
    
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = 0.8f;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    checkAnimation.delegate = self;
    [checkAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [checkLayer addAnimation:checkAnimation forKey:@"checkAnimation"];

    
}

- (void)shapeLayer: (CGFloat)progress{
   
    

    
    if (self.progressPath == nil) {
        self.progressPath = [UIBezierPath bezierPath];
        [self.progressPath moveToPoint:CGPointMake(self.progressBarHeight * 0.5, self.orignalFrame.size.height * 0.5 - 20)];
    }
    
    
    
    [self.progressPath addLineToPoint:CGPointMake(self.progressBarHeight * 0.5 + (self.progressBarWidth - self.progressBarHeight )* progress, self.orignalFrame.size.height * 0.5 - 20)];
    self.progressShapeLayer.path = self.progressPath.CGPath;
 
}

- (CAShapeLayer *)progressShapeLayer{
    
    if (!_progressShapeLayer) {
        
        _progressShapeLayer = [[CAShapeLayer alloc] init];
        _progressShapeLayer.lineCap = kCALineCapRound;
        _progressShapeLayer.lineWidth = 30;
        _progressShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        
        [self.layer addSublayer:_progressShapeLayer];
    }
    return _progressShapeLayer;
}



- (void)downloadRequestDidRecieveData:(LZDownLoadRequest *)downloadRequest{
    
    NSLog(@"-----%lf, %@", downloadRequest.progress, [NSThread currentThread]);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self shapeLayer:downloadRequest.progress / 100];
    });
    
}

- (void)downloadRequestDidFinish:(LZDownLoadRequest *)downloadReques{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mp3Path = downloadReques.filePath;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"mp3DownloadComplationg" object:self];
        [self.progressShapeLayer removeFromSuperlayer];
        self.isProgressing = NO;
        self.userInteractionEnabled = NO;
        self.layer.cornerRadius = self.orignalFrame.size.height * 0.5;
        
        
        CABasicAnimation *cornerRadiusExpandAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
        
        cornerRadiusExpandAnimation.fromValue = @(self.progressBarHeight * 0.5);
        cornerRadiusExpandAnimation.duration = 0.3;
        cornerRadiusExpandAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        cornerRadiusExpandAnimation.delegate = self;
        [self.layer addAnimation:cornerRadiusExpandAnimation forKey:@"cornerRadiusExpandAnimation"];
    });
}

@end

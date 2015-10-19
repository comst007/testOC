//
//  LZUserInfoViewController.m
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZUserInfoViewController.h"
#import "LZDownLoadRequest.h"
#import "LZGlobal.h"
#import "LZDownloadButton.h"
#import "LZIconRequest.h"
#import "MBProgressHUD.h"
#import "LZUploadRequest.h"
#import "NSString+LZMIMETYPE.h"

typedef NS_ENUM(NSInteger, LZUploadButtonSate) {
    kUploadButtonSateSelect,
    kUploadButtonStateUpload
};
@interface LZUserInfoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) LZDownLoadRequest *request;
@property (weak, nonatomic) IBOutlet UILabel *aboutSelfLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headiconImageview;
@property (weak, nonatomic) IBOutlet LZDownloadButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;

@property (weak, nonatomic) IBOutlet UIImageView *uploadImageview;

@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) LZUploadButtonSate uploadButtonSate;
@end

@implementation LZUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [LZGlobal sharedglobal].userinfo.username;
    [UIView animateWithDuration:1.0 animations:^{
        self.view.alpha = 1.0;
    }];
    self.aboutSelfLabel.text = [LZGlobal sharedglobal].userinfo.aboutself;
    
    LZIconRequest *iconRequest = [[LZIconRequest alloc] init];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [iconRequest headIconRequest:[LZGlobal sharedglobal].userinfo.headiconURL completionHandler:^(LZIconRequest *iconRequest) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            if (iconRequest.headIconImage != nil) {
                self.headiconImageview.image = iconRequest.headIconImage;
            }else{
                
                MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:self.view];
                alert.minShowTime = 2;
                alert.mode = MBProgressHUDModeText;
                alert.labelText = @"headIcon 加载失败";
                self.hidesBottomBarWhenPushed = YES;
                [self.view addSubview:alert];
                [alert show:YES];
                [alert hide:YES afterDelay:2];
            }
            
        });
        
    }];
    
    self.uploadButtonSate = kUploadButtonSateSelect;
}

- (void)animationDidStart:(CAAnimation *)anim{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)uploadButtonClick:(UIButton *)sender {
    //[self beginUploadAnimation];
//    [self displayLink];
    if (self.uploadButtonSate == kUploadButtonSateSelect) {
        
        UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        }else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
        imagePickerVC.delegate = self;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
        
    }else{
        [self displayLink];
        self.uploadButton.userInteractionEnabled = NO;
        LZUploadRequest *uploadRequest = [[LZUploadRequest alloc] init];
        NSData *imageData = UIImagePNGRepresentation(self.uploadImageview.image);
        [uploadRequest uploadRequestWithData:imageData mimeType:@"image/png" completionHandler:^(LZUploadRequest *uploadRequest) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.displayLink invalidate];
//                [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
                self.displayLink = nil;
                [self.shapeLayer removeFromSuperlayer];
                MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:self.view];
                alert.minShowTime = 2;
                alert.mode = MBProgressHUDModeText;
                alert.labelText = @"上传成功";
                self.hidesBottomBarWhenPushed = YES;
                [self.view addSubview:alert];
                [alert show:YES];
                [alert hide:YES afterDelay:2];
                self.uploadButtonSate = kUploadButtonSateSelect;
                self.uploadButton.userInteractionEnabled = YES ;
                [self.uploadButton setTitle:@"选择上传图片" forState:UIControlStateNormal];
                
            });
        }];
    }
}
/**
 *  UIImagePickerControllerOriginalImage
 *
 *  @param picker <#picker description#>
 *  @param info   <#info description#>
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"end pick ----%@", info);
    self.uploadImageview.image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.uploadButton setTitle:@"开始上传" forState:UIControlStateNormal];
    self.uploadButtonSate = kUploadButtonStateUpload;
    
   
    
    
}

- (void)beginUploadAnimation{
    
    if (self.shapeLayer == nil) {
        
        CGRect textRect =  [self.uploadButton titleRectForContentRect:self.uploadButton.bounds] ;
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        self.shapeLayer = shapeLayer;
        CGRect shapeLayerBounds = CGRectMake(0, 0, textRect.size.height, textRect.size.height);
        CGPoint  shapeLayerPosition = CGPointMake(textRect.origin.x - 15, textRect.origin.y + textRect.size.height * 0.5);
        
        shapeLayer.bounds = shapeLayerBounds;
        shapeLayer.position = shapeLayerPosition;
        shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineWidth = 2;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        
        [self.uploadButton.layer addSublayer:shapeLayer];
    }
    
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    
    self.startAngle = self.startAngle + M_PI * 0.4 ;
    
    if (self.startAngle > M_2_PI) {
        self.startAngle = self.startAngle - M_2_PI;
    }
    self.endAngle = self.startAngle + M_PI * 1.6;
    
    if (self.endAngle > M_2_PI) {
        self.endAngle = self.endAngle - M_2_PI;
    }
    [circlePath addArcWithCenter:CGPointMake(self.shapeLayer.bounds.size.width * 0.5, self.shapeLayer.bounds.size.width * 0.5) radius:self.shapeLayer.bounds.size.width * 0.5 - 1 startAngle:self.startAngle endAngle:self.endAngle clockwise:1];
    self.shapeLayer.path = circlePath.CGPath;

}

- (CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(beginUploadAnimation)];
        _displayLink.frameInterval = 8;
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _displayLink;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    LZUploadRequest *request = [[LZUploadRequest alloc] init];
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"hello.txt" ofType:nil];
    NSData *fileData = [[NSData alloc] initWithContentsOfFile:filepath];
    [request uploadRequestWithData:fileData mimeType:[filepath mimeType] completionHandler:^(LZUploadRequest *uploadRequest) {
        ;
    }];
}
@end

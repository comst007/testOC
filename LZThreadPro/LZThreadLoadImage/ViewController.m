//
//  ViewController.m
//  LZThreadLoadImage
//
//  Created by comst on 15/10/7.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad: %@", [NSThread currentThread] );
    [self performSelectorInBackground:@selector(loadImage) withObject:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSLog(@"viewDidLoad end---------");
    
}

- (void)loadImage{
    
     NSLog(@"loadImage: %@", [NSThread currentThread] );
    NSURL *imageURL = [NSURL URLWithString:@"http://120.24.236.135/imagesdir/syln.jpg"];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    [NSThread sleepForTimeInterval:5];
    [self performSelectorOnMainThread:@selector(finishLoad:) withObject:imageData waitUntilDone:NO];
    
    NSLog(@"loadImage end------");
}

- (void)finishLoad:(NSData *)data{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSLog(@"finishLoad: %@", [NSThread currentThread] );
    
    UIImage *image = [UIImage imageWithData:data];
    self.imageView.image = image;
    NSLog(@"finishLoad end------");
}
@end

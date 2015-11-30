//
//  LZFirstViewController.m
//  LZTransitionPro02_Push_Pop
//
//  Created by comst on 15/11/30.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZFirstViewController.h"
#import "LZCustomCell.h"
#import "LZPushTransition.h"
#import "LZSecondViewController.h"
@interface LZFirstViewController ()<UINavigationControllerDelegate>

@end
@implementation LZFirstViewController

- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.delegate  =self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LZCustomCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LZCell" forIndexPath:indexPath];
    Cell.iconImageview.image = [UIImage imageNamed:@"bkground"];
    return Cell;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if ([toVC isKindOfClass:[LZSecondViewController class]]) {
        return [[LZPushTransition alloc] init];
    }
   
    return nil;
}
@end

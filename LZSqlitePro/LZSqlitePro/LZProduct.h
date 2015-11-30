//
//  LZProduct.h
//  LZSqlitePro
//
//  Created by comst on 15/10/28.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZProduct : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *manufacture;
@property (nonatomic, copy) NSString *details;
@property (nonatomic, copy) NSNumber *price;
@property (nonatomic, copy) NSNumber *quality;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) NSInteger section;
@end

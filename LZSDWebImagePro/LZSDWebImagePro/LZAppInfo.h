//
//  LZAppInfo.h
//  LZtableviewLoadImage
//
//  Created by comst on 15/10/8.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZAppInfo : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *download;
- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)appInfoWithDict:(NSDictionary *)dict;

+ (NSArray *)arrayOfAppInfo;
@end

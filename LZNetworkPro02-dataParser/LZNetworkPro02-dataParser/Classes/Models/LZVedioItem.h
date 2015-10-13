//
//  LZVedioItem.h
//  LZNetworkPro02-dataParser
//
//  Created by comst on 15/10/12.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZVedioItem : NSObject
@property (nonatomic, copy) NSString *vedioID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *vedioURL;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *teacher;
@property (nonatomic, strong) NSNumber *length;
@end

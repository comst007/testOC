//
//  LZAppInfo.m
//  LZtableviewLoadImage
//
//  Created by comst on 15/10/8.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZAppInfo.h"

@implementation LZAppInfo

- (instancetype)initWithDict:(NSDictionary *)dict{

    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)appInfoWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)arrayOfAppInfo{
    static NSMutableArray *arrayM;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        arrayM = [NSMutableArray array];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil];
        
        NSArray *arrayOfItem = [NSArray arrayWithContentsOfFile:path];
        
        for (NSDictionary *dict in arrayOfItem) {
            LZAppInfo *appItem = [LZAppInfo appInfoWithDict:dict];
            [arrayM addObject:appItem];
        }
        
    });
    return arrayM;
}
@end

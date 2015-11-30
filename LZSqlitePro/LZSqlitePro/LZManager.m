//
//  LZManager.m
//  LZSqlitePro
//
//  Created by comst on 15/10/28.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZManager.h"

@interface LZManager ()

@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, copy) NSArray *arrayOfProducts;
@end


@implementation LZManager

- (NSArray *)allProducts{
    
    if (self.arrayOfProducts == nil) {
        BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:[self path]];
        if (!exist) {
            NSString *source = [[NSBundle mainBundle] pathForResource:@"catalog.db" ofType:nil];
            
            [[NSFileManager defaultManager] copyItemAtPath:source toPath:[self path] error:nil];
        }
        self.db = [FMDatabase databaseWithPath:[self path]];
        
        [self.db open];
        self.arrayOfProducts = [self searchAll];
    }
    
    return self.arrayOfProducts;
}


- (NSArray *)searchAll{
    NSMutableArray *arrayM = [NSMutableArray array];
    
    NSString *sql = @"SELECT PRODUCT.NAME, MANUFACTURER.NAME, PRODUCT.DETAILS, PRODUCT.PRICE, PRODUCT.QUALITYONHAND, PRODUCT.IMAGE, COUNTRY.COUNTRY FROM PRODUCT, COUNTRY, MANUFACTURER WHERE COUNTRY.COUNTRYID = PRODUCT.COUNTRYOFORIGINID AND MANUFACTURER.MANUFACTURERID = PRODUCT.MANUFACTURERID";
    
    FMResultSet *resSet = [self.db executeQuery:sql];
    
    //[self showCollum:resSet];
    
    while ([resSet next]) {
        
        LZProduct *item = [[LZProduct alloc] init];
        item.name = [resSet stringForColumnIndex:0];
        item.manufacture = [resSet stringForColumnIndex:1];
        item.details = [resSet stringForColumnIndex:2];
        item.price = @([resSet doubleForColumnIndex:3]);
        item.quality = @([resSet intForColumnIndex:4]);
        item.image = [resSet stringForColumnIndex:5];
        item.country = [resSet stringForColumnIndex:6];
        [arrayM addObject:item];
        
    }
    return  arrayM;
}

- (void)showCollum: (FMResultSet *)set{
    NSInteger count = [set columnCount];
    
    for (int  i = 0; i < count; i ++) {
        NSLog(@"name: -----%@", [set columnNameForIndex:i]);
    }
}

- (NSString *)path{
    
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return [dir stringByAppendingPathComponent:@"product.sqlite"];
}

- (void)dealloc{
    [self.db close];
    self.db = nil;
}
@end

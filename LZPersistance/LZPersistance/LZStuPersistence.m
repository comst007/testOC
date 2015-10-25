//
//  LZStuPersistence.m
//  LZStudentNote
//
//  Created by comst on 15/10/25.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZStuPersistence.h"
#import "FMDB.h"

@interface LZStuPersistence ()

@property (nonatomic, strong) NSMutableArray *listOfStudents;

@property (nonatomic, strong) FMDatabase *db;
@end

@implementation LZStuPersistence

- (NSString *)path{
    
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *filePath = [dir stringByAppendingPathComponent:@"stu.sqlite3"];
    
    return filePath;
}


- (NSArray *)findAll{

    NSMutableArray *resM = [NSMutableArray array];
    FMResultSet *resSet = [self.db executeQuery:@"SELECT * FROM STU_INFO;"];
    
    while ([resSet next]) {
        LZStudent *stu = [[LZStudent alloc] init];
        stu.name = [resSet stringForColumn:@"STU_NAME"];
        stu.phone = [resSet stringForColumn:@"STU_PHONE"];
        [resM addObject:stu];
    }
    return resM;
    
}

- (void)save{

}

- (void)addStudent:(LZStudent *)student{
   
   FMResultSet *res = [self.db executeQuery:@"SELECT * FROM STU_INFO WHERE STU_NAME=? ;", student.name];
    if ([res next]) {
        return;
    }
    [self.db executeUpdate:@"INSERT INTO STU_INFO(STU_NAME, STU_PHONE) VALUES(?,?);", student.name,student.phone];
}

- (void)deleteStudent:(LZStudent *)student{
    [self.db executeUpdate:@"DELETE FROM STU_INFO WHERE STU_NAME = ? ;", student.name];
    
}

- (NSArray *)searchByName:(NSString *)name{
    
    NSMutableArray *res = [NSMutableArray array];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM STU_INFO WHERE STU_NAME LIKE '%%%@%%' ;", name];
    
    FMResultSet *resSet = [self.db executeQuery:sql];
    
    while ([resSet next]) {
        LZStudent *stu = [[LZStudent alloc] init];
        stu.name = [resSet stringForColumn:@"STU_NAME"];
        stu.phone = [resSet stringForColumn:@"STU_PHONE"];
        [res addObject:stu];
    }
    
    return res;
}

- (void)updateStudent:(LZStudent *)student phone:(NSString *)phone{
    
    [self.db executeUpdate:@"UPDATE STU_ONFO SET STU_PHONE = ? WHERE STU_NAME = ?", phone, student.name];
}

- (FMDatabase *)db{
    if (!_db) {
        
        if([[NSFileManager defaultManager] fileExistsAtPath:[self path]]) {
            _db = [FMDatabase databaseWithPath:[self path]];
            [_db open];
        }else{
            _db = [FMDatabase databaseWithPath:[self path]];
            [_db open];
            [self createTableandInsertOneItem];
        }
    }
    return _db;
}
- (void)createTableandInsertOneItem{
    
    [self.db beginTransaction];
    [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS STU_INFO ("
					@"STU_NAME TEXT PRIMARY KEY NOT NULL,"
					@"STU_PHONE TEXT NOT NULL);"];
    [self.db executeUpdate:@"INSERT INTO STU_INFO(STU_NAME, STU_PHONE) VALUES(?,?);", @"comst", @"18899763793"];
    [self.db commit];
    
}
- (void)dealloc{
    
    [self.db close];
}
@end

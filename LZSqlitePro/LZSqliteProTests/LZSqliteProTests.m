//
//  LZSqliteProTests.m
//  LZSqliteProTests
//
//  Created by comst on 15/10/26.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LZManager.h"
@interface LZSqliteProTests : XCTestCase

@end

@implementation LZSqliteProTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    
    LZManager *manager = [[LZManager alloc] init];
    
    NSArray *res;
    res = [manager allProducts];
    
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

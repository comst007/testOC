//
//  LZStudentNoteTests.m
//  LZStudentNoteTests
//
//  Created by comst on 15/10/25.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LZStudent.h"
#import "LZStuManager.h"
@interface LZStudentNoteTests : XCTestCase

@end

@implementation LZStudentNoteTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
///Users/comst/Desktop
- (void)testExample {

    
    LZStuManager *m1 = [LZStuManager sharedstuManager];
    m1.name = @"comst";
    
    LZStuManager *m2 = [LZStuManager sharedstuManager];
    
    
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

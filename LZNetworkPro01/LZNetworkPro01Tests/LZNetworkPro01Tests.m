//
//  LZNetworkPro01Tests.m
//  LZNetworkPro01Tests
//
//  Created by comst on 15/10/12.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LZRequest.h"
@interface LZNetworkPro01Tests : XCTestCase

@end

@implementation LZNetworkPro01Tests

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
    NSString *url = @"http://120.24.236.135/Comst/demo.json";
    LZRequest *request = [[LZRequest alloc] init];
    [request sendRequest:url];
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

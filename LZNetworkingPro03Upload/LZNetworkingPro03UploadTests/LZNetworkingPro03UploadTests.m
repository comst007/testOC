//
//  LZNetworkingPro03UploadTests.m
//  LZNetworkingPro03UploadTests
//
//  Created by comst on 15/10/14.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSString+LZMIMETYPE.h"
@interface LZNetworkingPro03UploadTests : XCTestCase

@end

@implementation LZNetworkingPro03UploadTests

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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Singleton.png" ofType:nil];
    
    
    NSString *type = [path mimeType];
    NSLog(@"----------------type: %@", type);
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

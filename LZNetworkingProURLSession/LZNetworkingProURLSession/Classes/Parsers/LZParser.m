//
//  LZParser.m
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/19.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZParser.h"

@implementation LZParser

- (LZUserInfo *)parseUserinfoFromJsonData:(NSData *)source{
    
    NSDictionary *userInfoDict = [NSJSONSerialization JSONObjectWithData:source options:NSJSONReadingMutableContainers error:nil];
    if (userInfoDict) {
        LZUserInfo *userInfo = [[LZUserInfo alloc] init];
        userInfo.username = userInfoDict[@"userName"];
        userInfo.headiconURL = userInfoDict[@"headIcon"];
        userInfo.aboutself = userInfoDict[@"aboutSelf"];
        return userInfo;
    }
    return nil ;
}
@end

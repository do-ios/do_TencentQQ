//
//  SDKCall.h
//  Do_TencentQQ
//
//  Created by yz on 15/4/28.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface YZQQSDKCall : NSObject

+ (YZQQSDKCall *)getinstance;
+ (void)resetSDK;
@property (nonatomic, retain)TencentOAuth *oauth;

@end

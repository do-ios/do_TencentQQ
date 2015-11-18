//
//  SDKCall.m
//  Do_TencentQQ
//
//  Created by yz on 15/4/28.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import "YZQQSDKCall.h"
static YZQQSDKCall *g_instance = nil;

@implementation YZQQSDKCall

+ (YZQQSDKCall *)getinstance
{
    @synchronized(self)
    {
        if (nil == g_instance)
        {
            g_instance = [[super allocWithZone:nil] init];
        }
    }
    
    return g_instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (!g_instance) {
            g_instance = [super allocWithZone:zone];
        }
    }
    return g_instance;
}
+(void)resetSDK
{
    g_instance = nil;
}

@end

















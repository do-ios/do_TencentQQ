//
//  do_TencentQQ_App.m
//  DoExt_SM
//
//  Created by 刘吟 on 15/4/9.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#define ThrID @"tencent"

#import "do_TencentQQ_App.h"
#import "YZQQSDKCall.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "doScriptEngineHelper.h"

@implementation do_TencentQQ_App
@synthesize ThridPartyID;
- (instancetype)init
{
    if (self = [super init]) {
        self.ThridPartyID = ThrID;
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url fromThridParty:(NSString *)_id
{
    if ([_id isEqualToString:ThrID]) {
        [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[doScriptEngineHelper ParseSingletonModule:nil :@"do_TencentQQ" ]];
        return [TencentOAuth HandleOpenURL:url];
    }
    return NO;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation fromThridParty:(NSString *)_id
{
    if ([_id isEqualToString:ThrID]) {
        BOOL qqApi = [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[doScriptEngineHelper ParseSingletonModule:nil :@"do_TencentQQ" ]];
        BOOL tencent = [TencentOAuth HandleOpenURL:url];
        return qqApi || tencent;
    }
    return NO;
}
@end

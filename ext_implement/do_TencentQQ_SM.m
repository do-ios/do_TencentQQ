//
//  do_TencentQQ_SM.m
//  DoExt_SM
//
//  Created by @userName on @time.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import "do_TencentQQ_SM.h"

#import "doScriptEngineHelper.h"
#import "doIScriptEngine.h"
#import "doInvokeResult.h"
#import "doJsonHelper.h"
#import "YZQQSDKCall.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "doIOHelper.h"
#import "doIPage.h"

typedef NS_ENUM(NSInteger, MessageType)
{
    MessageTextType,
    MessageImageType,
    MessageMusicType,
    MessageAppType
};

@interface do_TencentQQ_SM() <TencentSessionDelegate,QQApiInterfaceDelegate>
@property(nonatomic,copy) NSString *callbackName;
@property(nonatomic,strong) id<doIScriptEngine> scritEngine;

@end

@implementation do_TencentQQ_SM
#pragma mark -
#pragma mark - 同步异步方法的实现
/*
 1.参数节点
 doJsonNode *_dictParas = [parms objectAtIndex:0];
 a.在节点中，获取对应的参数
 NSString *title = [_dictParas GetOneText:@"title" :@"" ];
 说明：第一个参数为对象名，第二为默认值
 
 2.脚本运行时的引擎
 id<doIScriptEngine> _scritEngine = [parms objectAtIndex:1];
 
 同步：
 3.同步回调对象(有回调需要添加如下代码)
 doInvokeResult *_invokeResult = [parms objectAtIndex:2];
 回调信息
 如：（回调一个字符串信息）
 [_invokeResult SetResultText:((doUIModule *)_model).UniqueKey];
 异步：
 3.获取回调函数名(异步方法都有回调)
 NSString *_callbackName = [parms objectAtIndex:2];
 在合适的地方进行下面的代码，完成回调
 新建一个回调对象
 doInvokeResult *_invokeResult = [[doInvokeResult alloc] init];
 填入对应的信息
 如：（回调一个字符串）
 [_invokeResult SetResultText: @"异步方法完成"];
 [_scritEngine Callback:_callbackName :_invokeResult];
 */
//同步
- (void)logout:(NSArray *)parms
{
    //自己的代码实现
    [[YZQQSDKCall getinstance].oauth logout:self];
}
//异步
- (void)getUserInfo:(NSArray *)parms
{
    self.scritEngine  = [parms objectAtIndex:1];
    //自己的代码实现
    self.callbackName = [parms objectAtIndex:2];
    
}
- (void)login:(NSArray *)parms
{
    
    NSDictionary *_dictParas = [parms objectAtIndex:0];
    self.scritEngine  = [parms objectAtIndex:1];
    //自己的代码实现
    
    self.callbackName = [parms objectAtIndex:2];
    NSString *app_id = [doJsonHelper GetOneText:_dictParas :@"appId" :@""];
    [YZQQSDKCall getinstance].oauth = [[TencentOAuth alloc]initWithAppId:app_id andDelegate:self];
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_IDOL,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_PIC_T,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_DEL_IDOL,
                            kOPEN_PERMISSION_DEL_T,
                            kOPEN_PERMISSION_GET_FANSLIST,
                            kOPEN_PERMISSION_GET_IDOLLIST,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_GET_REPOST_LIST,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                            kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                            nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[YZQQSDKCall getinstance].oauth authorize:permissions inSafari:NO];
    });
}

- (void)shareToQQ:(NSArray *)parms
{
    NSDictionary *_dictParas = [parms objectAtIndex:0];
    self.scritEngine = [parms objectAtIndex:1];
    self.callbackName = [parms objectAtIndex:2];

    //自己的代码实现
//    NSString *appID = [doJsonHelper GetOneText:_dictParas :@"appId" :@""];
    int type = [doJsonHelper GetOneInteger:_dictParas :@"type" :-1];
    NSString *title = [doJsonHelper GetOneText:_dictParas :@"title" :@""];
    NSString *image = [doJsonHelper GetOneText:_dictParas :@"image" :@""];
    NSString *url = [doJsonHelper GetOneText:_dictParas :@"url" :@""];
    NSString *summary = [doJsonHelper GetOneText:_dictParas :@"summary" :@""];
    NSString *audio = [doJsonHelper GetOneText:_dictParas :@"audio" :@""];
    NSString *appName = [doJsonHelper GetOneText:_dictParas :@"appName" :@""];
    QQApiObject *qqApiObject = [self messageToShare:type withTitle:title withImage:image withUrl:url withSummary:summary withAudio:audio withAppName:appName];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:qqApiObject];
    dispatch_async(dispatch_get_main_queue(), ^{
        [QQApiInterface sendReq:req];
    });
}

- (void)shareToQzone:(NSArray *)parms
{
    NSDictionary *_dictParas = [parms objectAtIndex:0];
    self.scritEngine = [parms objectAtIndex:1];
    self.callbackName = [parms objectAtIndex:2];
    //自己的代码实现
    //    NSString *appID = [doJsonHelper GetOneText:_dictParas :@"appId" :@""];
    int type = [doJsonHelper GetOneInteger:_dictParas :@"type" :-1];
    NSString *title = [doJsonHelper GetOneText:_dictParas :@"title" :@""];
    NSString *image = [doJsonHelper GetOneText:_dictParas :@"image" :@""];
    NSString *url = [doJsonHelper GetOneText:_dictParas :@"url" :@""];
    NSString *summary = [doJsonHelper GetOneText:_dictParas :@"summary" :@""];
    NSString *audio = [doJsonHelper GetOneText:_dictParas :@"audio" :@""];
    NSString *appName = [doJsonHelper GetOneText:_dictParas :@"appName" :@""];
    QQApiObject *qqApiObject = [self messageToShareQQZone:type withTitle:title withImage:image withUrl:url withSummary:summary withAudio:audio withAppName:appName];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:qqApiObject];
    dispatch_async(dispatch_get_main_queue(), ^{
        [QQApiInterface SendReqToQZone:req];
    });
}
- (QQApiObject *)messageToShareQQZone:(int)type withTitle:(NSString *)title withImage:(NSString *)image withUrl:(NSString *)url withSummary:(NSString *)summary withAudio:(NSString *)audio withAppName:(NSString *)appName
{
    QQApiObject *qqApiObject;
    NSString * imagePath = [doIOHelper GetLocalFileFullPath:_scritEngine.CurrentPage.CurrentApp :image];
    qqApiObject = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:summary previewImageData:[NSData dataWithContentsOfFile:imagePath]];
     [qqApiObject setCflag:kQQAPICtrlFlagQZoneShareOnStart];
    return qqApiObject;
}


- (QQApiObject *)messageToShare:(int)type withTitle:(NSString *)title withImage:(NSString *)image withUrl:(NSString *)url withSummary:(NSString *)summary withAudio:(NSString *)audio withAppName:(NSString *)appName
{
    QQApiObject *qqApiObject;
    
    switch (type) {
        case MessageTextType:
        {
            if(summary.length<=0){
                [NSException raise:@"TencentQQ" format:@"QQ分享的summary的无效!",nil];
            }
            qqApiObject = [QQApiTextObject objectWithText:summary];
            qqApiObject.title = title;
        }
        break;
        case MessageImageType:
        {
            NSString * imagePath = [doIOHelper GetLocalFileFullPath:_scritEngine.CurrentPage.CurrentApp :image];
            NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
            if(imageData == nil){
                [NSException raise:@"TencentQQ" format:@"QQ分享的imageData的无效!",nil];
            }
            
            qqApiObject = [QQApiImageObject objectWithData:imageData previewImageData:imageData title:title description:summary];
        }
        break;
        case MessageMusicType:
        {
            if(audio.length<=0){
                [NSException raise:@"TencentQQ" format:@"QQ分享的audio的无效!",nil];
            }
            NSString * imagePath = [doIOHelper GetLocalFileFullPath:_scritEngine.CurrentPage.CurrentApp :image];
            NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
            qqApiObject = [QQApiAudioObject objectWithURL:[NSURL URLWithString:url] title:title description:summary previewImageData:imageData];
            [(QQApiAudioObject *)qqApiObject setFlashURL:[NSURL URLWithString:audio]];
        }
        break;
        //        case MessageAppType:
        //        {
        //            qqApiObject = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:summary previewImageData:nil];
        //        }
        //            break;
        default:
        break;
    }
    return qqApiObject;
}
#pragma -mark -
#pragma -mark TencentSessionDelegate
- (void)tencentDidLogout
{
    
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    
}
/**
 *  登录时网络有问题的回调
 */
-(void)tencentDidNotNetWork
{
    
}
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    
}
/**
 *  登录成功后的回调
 */
-(void)tencentDidLogin
{
    NSString *accessToken = [[YZQQSDKCall getinstance].oauth accessToken];
    NSString *openID = [[YZQQSDKCall getinstance].oauth openId];
    
    NSString *expirationDate = [NSString stringWithFormat:@"%f",[[YZQQSDKCall getinstance].oauth expirationDate].timeIntervalSinceNow];
    NSString *ret = [[YZQQSDKCall getinstance].oauth passData][@"ret"];
    NSString *pay_token = [[YZQQSDKCall getinstance].oauth passData][@"pay_token"];
    NSString *msg = [[YZQQSDKCall getinstance].oauth passData][@"msg"];
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    [resultDict setValue:ret forKey:@"ret"];
    [resultDict setValue:pay_token forKey:@"pay_token"];
    [resultDict setValue:openID forKey:@"openid"];
    [resultDict setValue:expirationDate forKey:@"expires_in"];
    [resultDict setValue:msg forKey:@"msg"];
    [resultDict setValue:accessToken forKey:@"access_token"];
    NSString *resultStr = [doJsonHelper ExportToText:resultDict :YES];
    doInvokeResult *_invokeResult = [[doInvokeResult alloc]init:self.UniqueKey];
    [_invokeResult SetResultText:resultStr];
    [self.scritEngine Callback:self.callbackName :_invokeResult];
    if ([[YZQQSDKCall getinstance].oauth getUserInfo]) {
        
    }
}
/**
 *
 * 获取用户个人信息回调
 *
 *  @param response
 */
-(void)getUserInfoResponse:(APIResponse *)response
{
    if (URLREQUEST_SUCCEED == response.retCode && kOpenSDKErrorSuccess == response.detailRetCode)
    {
        NSData *dictData = [NSJSONSerialization dataWithJSONObject:response.jsonResponse options:NSJSONWritingPrettyPrinted error:nil];
        NSString *resultStr = [[NSString alloc]initWithData:dictData encoding:NSUTF8StringEncoding];
        doInvokeResult *_invokeResult = [[doInvokeResult alloc]init:self.UniqueKey];
        [_invokeResult SetResultText:resultStr];
        [self.scritEngine Callback:self.callbackName :_invokeResult];
    }
}
/**
 *  分享回调
 *
 *  @param resp <#resp description#>
 */
- (void)onResp:(QQBaseResp *)resp
{
    doInvokeResult *_invokeResult = [[doInvokeResult alloc] init:self.UniqueKey];
    if ([resp.result isEqualToString:@"0"]) {
        [_invokeResult SetResultBoolean:YES];
    }
    else
    {
        [_invokeResult SetResultBoolean:NO];
    }
    [self.scritEngine Callback:self.callbackName :_invokeResult];
}

- (void)onReq:(QQBaseReq *)req
{
    
}
@end

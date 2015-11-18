//
//  do_TencentQQ_IMethod.h
//  DoExt_API
//
//  Created by @userName on @time.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol do_TencentQQ_ISM <NSObject>

//实现同步或异步方法，parms中包含了所需用的属性
@required
- (void)getUserInfo:(NSArray *)parms;
- (void)login:(NSArray *)parms;
- (void)logout:(NSArray *)parms;
- (void)shareToQQ:(NSArray *)parms;
- (void)shareToQzone:(NSArray *)parms;

@end
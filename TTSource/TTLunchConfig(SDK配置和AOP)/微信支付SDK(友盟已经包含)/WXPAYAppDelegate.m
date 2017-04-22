//
//  WXPAYAppDelegate.m
//  ZPCommon
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 ZengPing. All rights reserved.
//

#import "WXPAYAppDelegate.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "TTSDKMacros.h"

#import "WXApi.h"

@interface WXPAYAppDelegate ()<WXApiDelegate>

@end
@implementation WXPAYAppDelegate
+(void)load
{
    
    TTAppDelegateName(@"AppDelegate")
    TTdifferentClassExchangeMethod(@"application:didFinishLaunchingWithOptions:",didFinishLaunching,WXPAY_application:didFinishLaunchingWithOptions:)
    TTdifferentClassExchangeMethod(@"application:openURL:options:",openURL,WXPAY_application:openURL:options:)
    
}


- (BOOL)WXPAY_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //填写APPID
    //    商户在微信开放平台申请开发APP应用后，微信开放平台会生成APP的唯一标识APPID。在Xcode中打开项目，设置项目属性中的URL Schemes为您的APPID
    [WXApi registerApp:@""];
    
    
    return [self WXPAY_application:application didFinishLaunchingWithOptions:launchOptions];
}


- (BOOL)WXPAY_application:(UIApplication *)app
                      openURL:(NSURL *)url
                      options:(NSDictionary<NSString*, id> *)options
{
    
    /*! @brief 处理微信通过URL启动App时传递的数据
     *
     * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
     * @param url 微信启动第三方应用时传递过来的URL
     * @param delegate  WXApiDelegate对象，用来接收微信触发的消息。
     * @return 成功返回YES，失败返回NO。
     */
    [WXApi handleOpenURL:url delegate:self];
    
    
    return [self WXPAY_application:app
                           openURL:url
                           options:options];
    
}



/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */

- (void)onResp:(BaseResp *)resp
{
    //支付返回结果，实际支付结果需要去微信服务器端查询
    NSString *strMsg = [NSString stringWithFormat:@"支付结果"];
    switch (resp.errCode) {
        case WXSuccess:
            strMsg = @"支付结果：成功！";
            //            NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
            break;
        default:
            strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
            //            NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
            break;
    }
}




@end

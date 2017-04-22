//
//  UShareAppDelegate.m
//  ZPCommon
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 ZengPing. All rights reserved.
//

#import "UShareAppDelegate.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "TTSDKMacros.h"

#import <UMSocialCore/UMSocialCore.h>
/**
 
 文档:http://dev.umeng.com/social/ios/quick-integration#3_1_2
 
 包括了三方授权(三方登陆)
 
 注意事项:
 由于最新QQ sdk支持的CPU指令集调整，最新5.2.1及6.x版本支持的CPU架构为：armv7\x86_64\arm64，不再支持i386架构，各位开发者注意不要在架构支持中勾选i386或在模拟器调试！！！
 
 
 3.3.2.1  分享文本
 - (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
 {
 //创建分享消息对象
 UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
 //设置文本
 messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
 
 //调用分享接口
 [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
 if (error) {
 NSLog(@"************Share fail with error %@*********",error);
 }else{
 NSLog(@"response data is %@",data);
 }
 }];
 }
 
 
 */

@implementation UShareAppDelegate
+(void)load
{
    
    TTAppDelegateName(@"AppDelegate")
    
    TTdifferentClassExchangeMethod(@"application:didFinishLaunchingWithOptions:",didFinishLaunching,UShare_application:didFinishLaunchingWithOptions:)
    TTdifferentClassExchangeMethod(@"application:openURL:options:",openURL,UShare_application:openURL:options:)
    TTdifferentClassExchangeMethod(@"application:openURL:sourceApplication:annotation:",sourceApplication,UShare_application:openURL:sourceApplication:annotation:)
    TTdifferentClassExchangeMethod(@"application:handleOpenURL:",handleOpenURL,UShare_application:handleOpenURL:)

    
}



//app启动后进行U-Share和第三方平台的初始化工作 以下代码将所有平台初始化示例放出，开发者根据平台需要选取相应代码，并替换为所属注册的appKey和appSecret。
//在AppDelegate.m中设置如下代码
- (BOOL)UShare_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //打开调试日志
        [[UMSocialManager defaultManager] openLog:NO];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"580d6160734be46ef7001dfc"];
    
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置微信的appKey和appSecret
    //    AppID：wx03127fa4aad904ed
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx03127fa4aad904ed" appSecret:@"da18bf7e6fb7f55099b745f0b3e30f74" redirectURL:@"http://mobile.umeng.com/social"];
    
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105540108"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3071058091"  appSecret:@"c1d733f895787c9e84f070c6a6fa1158" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
    
    // 如果不想显示平台下的某些类型，可用以下接口设置
    //    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite),@(UMSocialPlatformType_YixinTimeLine),@(UMSocialPlatformType_LaiWangTimeLine),@(UMSocialPlatformType_Qzone)]];
    //    ...
    
    
    return [self UShare_application:application didFinishLaunchingWithOptions:launchOptions];
}

/**
 当用户通过其它应用启动本应用时，
 会回调这个方法，
 url参数是其它应用调用openURL:方法时传过来的。
 */
- (BOOL)UShare_application:(UIApplication *)application
                    openURL:(NSURL *)url
          sourceApplication:(NSString *)sourceApplication
                 annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    
    
    
    return [self UShare_application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}
/** 9.0以后使用新API接口
 
 当用户通过其它应用启动本应用时，
 会回调这个方法，
 url参数是其它应用调用openURL:方法时传过来的。
 */

- (BOOL)UShare_application:(UIApplication *)app
                    openURL:(NSURL *)url
                    options:(NSDictionary<NSString*, id> *)options
{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    
    return [self UShare_application:app openURL:url options:options];
}

- (BOOL)UShare_application:(UIApplication *)app
              handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    
    
    return  [self UShare_application:app handleOpenURL:url];
}





@end

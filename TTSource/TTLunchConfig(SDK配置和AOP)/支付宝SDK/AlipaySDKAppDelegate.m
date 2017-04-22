//
//  AlipaySDKAppDelegate.m
//  ZPCommon
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 ZengPing. All rights reserved.
//

#import "AlipaySDKAppDelegate.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "TTSDKMacros.h"
#import <AlipaySDK/AlipaySDK.h>


#define KNOTIFICATION_PaySuccess @"KNOTIFICATION_PaySuccess"
#define KNOTIFICATION_PayFailure @"KNOTIFICATION_PayFailure"


@implementation AlipaySDKAppDelegate
/*
 
 支付宝文档
 
 https://doc.open.alipay.com/docs/doc.htm?spm=a219a.7629140.0.0.GMOLaD&treeId=204&articleId=105295&docType=1
 
 
 iPhone SDK可以把你的App和一个自定义的URL Scheme绑定。该URL Scheme可用来从浏览器或别的App启动你的App。
 
 如何响应从别的App里发给你的URL Scheme申请，由你决定：可以唤醒你的App；也可以传一些信息给你。
 
 给自己的App注册一个URL Scheme非常简单，就是在info.plist文件里定义两个键值就OK。
 
 pod 'AliPay', '~> 2.1.2'
 */

//注意Appdelegate主类中必须 实现 才会调用黑魔法
+(void)load
{
    
    TTAppDelegateName(@"AppDelegate")
    
    TTdifferentClassExchangeMethod(@"application:openURL:sourceApplication:annotation:",sourceApplication,AlipaySDK_application:openURL:sourceApplication:annotation:)
    
    TTdifferentClassExchangeMethod(@"application:openURL:options:",openURL,AlipaySDK_application:openURL:options:)


}


/**
 当用户通过其它应用启动本应用时，
 会回调这个方法，
 url参数是其它应用调用openURL:方法时传过来的。
 */
- (BOOL)AlipaySDK_application:(UIApplication *)application
                      openURL:(NSURL *)url
            sourceApplication:(NSString *)sourceApplication
                   annotation:(id)annotation
{
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName: KNOTIFICATION_PaySuccess object:resultDic];
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName: KNOTIFICATION_PayFailure object:resultDic];
            }
        }];
    }
    
    return [self AlipaySDK_application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}
/** 9.0以后使用新API接口
 
 当用户通过其它应用启动本应用时，
 会回调这个方法，
 url参数是其它应用调用openURL:方法时传过来的。
 */

- (BOOL)AlipaySDK_application:(UIApplication *)app
                      openURL:(NSURL *)url
                      options:(NSDictionary<NSString*, id> *)options
{
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName: KNOTIFICATION_PaySuccess object:resultDic];
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName: KNOTIFICATION_PayFailure object:resultDic];
                
            }
        }];
        
    }
    
    return [self AlipaySDK_application:app openURL:url options:options];
}


@end

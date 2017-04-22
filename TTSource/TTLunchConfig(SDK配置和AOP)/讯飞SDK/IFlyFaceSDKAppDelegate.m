//
//  IFlyFaceSDKAppDelegate.m
//  ZPCommon
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 ZengPing. All rights reserved.
//

#import "IFlyFaceSDKAppDelegate.h"
#import "iflyMSC/IFlyFaceSDK.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "TTSDKMacros.h"

#define USER_APPID           @"56ce54a5"

@implementation IFlyFaceSDKAppDelegate

+(void)load
{
    
    TTAppDelegateName(@"AppDelegate")
    TTdifferentClassExchangeMethod(@"application:didFinishLaunchingWithOptions:",didFinishLaunching,IFlyFaceSDK_application:didFinishLaunchingWithOptions:)
    
   
}

-(BOOL)IFlyFaceSDK_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    //设置log等级，此处log为默认在app沙盒目录下的msc.log文件
    [IFlySetting setLogFile:LVL_ALL];
    
    //输出在console的log开关
//    [IFlySetting showLogcat:YES];
    [IFlySetting showLogcat:NO];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    //设置msc.log的保存路径
    [IFlySetting setLogFilePath:cachePath];
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@,",USER_APPID];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    
    
    
    return [self IFlyFaceSDK_application:application didFinishLaunchingWithOptions:launchOptions];
    
    
}
@end

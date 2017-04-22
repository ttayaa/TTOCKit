//
//  BaiduMapSDKAppdelegate.m
//  ZPCommon
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 ZengPing. All rights reserved.
//

#import "BaiduMapSDKAppdelegate.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "TTSDKMacros.h"


static BMKMapManager *mapManager;

@implementation BaiduMapSDKAppdelegate
+(void)load
{
    
    mapManager = [[BMKMapManager alloc]init];
    
    TTAppDelegateName(@"AppDelegate")
    TTdifferentClassExchangeMethod(@"application:didFinishLaunchingWithOptions:",didFinishLaunching,BaiduMapSDK_application:didFinishLaunchingWithOptions:)
    
    
}


/**
 文档
 http://lbsyun.baidu.com/index.php?title=iossdk/guide/attention
 1、静态库中采用ObjectC++实现，因此需要您保证您工程中至少有一个.mm后缀的源文件(您可以将任意一个.m后缀的文件改名为.mm)，或者在工程属性中指定编译方式，即在Xcode的Project -> Edit Active Target -> Build Setting 中找到 Compile Sources As，并将其设置为"Objective-C++"
 
 2、如果您只在Xib文件中使用了BMKMapView，没有在代码中使用BMKMapView，编译器在链接时不会链接对应符号，需要在工程属性中显式设定：在Xcode的Project -> Edit Active Target -> Build Setting -> Other Linker Flags中添加-ObjC
 
 
 */


//- (void)applicationWillResignActive:(UIApplication *)application {
//    [BMKMapView willBackGround];//当应用即将后台时调用，停止一切调用opengl相关的操作
//}
//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [BMKMapView didForeGround];//当应用恢复前台状态时调用，回复地图的渲染和opengl相关的操作
//}



//AK = Hc5cHp1uilLPaOfORIAYGjq6fAHcEa49  (ttayaa1)
#define AppKey @"Hc5cHp1uilLPaOfORIAYGjq6fAHcEa49"
- (BOOL)BaiduMapSDK_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 要使用百度地图，请先启动BaiduMapManager  _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [mapManager  start:AppKey  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    return [self BaiduMapSDK_application:application didFinishLaunchingWithOptions:launchOptions];
}



@end

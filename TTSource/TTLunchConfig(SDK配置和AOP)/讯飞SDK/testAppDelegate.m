//
//  testAppDelegate.m
//  ZPCommon
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 ZengPing. All rights reserved.
//

#import "testAppDelegate.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "TTSDKMacros.h"

@implementation testAppDelegate
+(void)load
{
    
    
    TTAppDelegateName(@"AppDelegate")
    TTdifferentClassExchangeMethod(@"application:didFinishLaunchingWithOptions:",didFinishLaunching,test_application:didFinishLaunchingWithOptions:)
    
    
}

-(BOOL)test_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    return [self test_application:application didFinishLaunchingWithOptions:launchOptions];
    
    
}
@end

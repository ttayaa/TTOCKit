//
//  AppDelegate.m
//  testproject
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import "AppDelegate.h"
#import "NetDataModel.h"
//#import "ShareProgress.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [NetDataModel networkConfigureIP:@"https://mapi.dragonb.com/" test:@"http://192.168.0.10:85/" ext:^{
        
    }];
    [NetDataModel networkConfigureStatusKeyName:@"status" dataKeyName:@"data" msgKeyName:@"message"];
    [NetDataModel networkConfigureStatusSuceessKey:@"1"];
    [NetDataModel networkConfigureStatusOtherKey:@"0" block:^{
        
    }];
    [NetDataModel networkConfigureStatusOtherKey:@"-1" block:^{
        
    }];
    [NetDataModel networkConfigureParmsFillter:^(NSMutableDictionary *dict) {
        [dict addEntriesFromDictionary:@{
                                         @"_v": [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                         @"_p":@"ios",}];
        
    }];
    
    [NetDataModel networkConfigureProgress:^(NSString *text) {
        //        CommonProgressError(text)
    }];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

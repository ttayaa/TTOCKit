//
//  VersionTools.m
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import "VersionTools.h"


#define Version @"version"

@implementation VersionTools

+(BOOL) isNewVersion
{
    // 1.获取当前软件的版本号 --> info.plist
    NSString *curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 2.获取以前的软件版本号 --> 从本地文件中读取(以前自己存储的)
      NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:Version];
    
    // 3.比较当前版本号和以前版本号
    //(如果当前版本号比以前版本号新(大) 那么就播放新特性界面)
    if ([curVersion compare:lastVersion]==NSOrderedDescending) {
       
        //将新的版本号存入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:Version];
        
        //返回是新版本
         return YES;
    }
    else
    {
        //返回不是新版本
        return NO;
    }
}


@end

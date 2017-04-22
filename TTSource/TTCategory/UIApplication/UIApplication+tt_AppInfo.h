//
//  AppDelegate.h
//  MACProject
//
//  Created by ttayaa on 15/9/10.
//  Copyright (c) 2015年 ttayaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AddressBook/ABAddressBook.h"
#import "EventKit/EventKit.h"
#import "AVFoundation/AVFoundation.h"
#import "AssetsLibrary/AssetsLibrary.h"

typedef void(^tt_grantBlock)(BOOL granted);

@interface UIApplication (tt_AppInfo)


@property (strong, nonatomic) UIWindow *window;


///-------------------------------------
/// @name  app基本信息
///-------------------------------------

/**
 当前app名称
 */
- (NSString *)tt_appName;

/*
 当前app版本号
 */
- (NSString *)tt_appVersion;

/**
 build 版本号
 */
- (NSString *)tt_appBuild;

/**
  apps 证书编号 (例如ttayaa.az.com)
 */
- (NSString *)tt_appBundleID;

///--------------------------------------------------------------
/// @name  沙盒缓存大小
///--------------------------------------------------------------

/**
 *  沙盒的路径
 */
- (NSString *)tt_documentsDirectoryPath;
/**
  沙盒的内容大小 (例如5 MB)
 */
- (NSString *)tt_documentsFolderSizeAsString;

/**
  沙盒内的字节大小
 */
- (int)tt_documentsFolderSizeInBytes;
/**
 *  程序的大小 包括文件 缓冲 以及 下载
 *
 *  @return  所有文件大小
 */
- (NSString *)tt_applicationSize;


/////---------------------------------------------------------------
///// @name  app 隐私权限
/////---------------------------------------------------------------

/**
  定位权限是否开启
 */
- (BOOL)tt_applicationHasAccessToLocationData;

/**
  通讯录访问权限是否开启
 */
- (BOOL)tt_applicationhasAccessToAddressBook;

/**
  相机权限是否开启
 */
- (BOOL)tt_applicationHasAccessToCalendar;

/**
  推送功能是否开启
 */
- (BOOL)tt_applicationHasAccessToReminders;

/**
 相册权限是否开启
 */
- (BOOL)tt_applicationHasAccessToPhotosLibrary;

/**
 *  麦克风开启
 *
 *
 */
- (void)tt_applicationHasAccessToMicrophone:(tt_grantBlock)flag;

///-------------------------------------
/// @name  app 相关事件
///-------------------------------------

/**
 *  注册推送(兼容iOS8)
 */
-(void)tt_registerNotifications;
///**
// *  获取当前视图
// *
// */
-(UIViewController*)tt_getCurrentViewConttoller;


@end

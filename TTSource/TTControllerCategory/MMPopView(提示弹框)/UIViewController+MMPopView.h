//
//  UIViewController+MMPopView.h
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 RecruitTreasure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMAlertView.h"
#import "MMSheetView.h"

@interface UIViewController (MMPopView)
/**
 *  展示Alert提示信息
 */
-(void)TTShowAlertMessage:(NSString*)message;

/**
 *  展示Alert提示信息
 */
-(void)TTShowAlertMessage:(NSString*)message titile:(NSString *)title;
/**
 *  展示Alert提示信息
 *
 *  @param message    提示内容
 *  @param title      提示标题
 *   @param clickArr   按钮信息数组
 *  @param clickIndex 点击的下标
 */
-(void)TTShowAlertMessage:(NSString *)message title:(NSString *)title clickArr:(NSArray *)arr click:(MMPopupItemHandler) clickIndex;
/**
 *  展示SheetView提示信息
 *
 *  @param title      提示标题
 *   @param clickArr   按钮信息数组
 *  @param clickIndex 点击的下标
 */
-(void)TTShowSheetTitle:(NSString *)title clickArr:(NSArray *)arr click:(MMPopupItemHandler) clickIndex;



@end

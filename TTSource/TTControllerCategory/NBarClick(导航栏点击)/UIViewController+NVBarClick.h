//
//  UIViewController+NVBarClick.h
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 RecruitTreasure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBShimmering.h"
#import "FBShimmeringLayer.h"
#import "FBShimmeringView.h"

//外部可以直接使用宏
#define TTLeftClick   - (void)tt_leftBarItemAction:(UIBarButtonItem *)BarButtonItem

#define TTRightClick   - (void)tt_rightBarItemAction:(UIBarButtonItem *)BarButtonItem


@interface UIViewController (NVBarClick)

/** 返回几个页面 默认1个*/
@property (assign,nonatomic) NSInteger dy_backNumb;

/**
 *  设置左侧文字形式的BarItem
 */
- (void)TTLeftBarTitle:(NSString*)string textColor:(UIColor*)color;
/**
 *  设置左侧图片形式的BarItem
 */
- (void)TTLeftBarImage:(NSString *)imageName;
/**
 *  设置右侧文字形式的BarItem
 */
- (void)TTRightBarTitle:(NSString*)string textColor:(UIColor*)color;
/**
 *  设置右侧图片形式的BarItem
 */
- (void)TTRightBarImage:(NSString *)imageName;

- (void)TTTitle:(NSString *)string textColor:(UIColor*)color isShimmering:(BOOL)isShimmering;

@end

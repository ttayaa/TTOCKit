//
//  UIViewController+AlphaBar.h
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UINavigationBar+ttAwesome.h"


@interface UIViewController (AlphaBar)<UIScrollViewDelegate>

typedef NS_ENUM(NSInteger, TTAlphaNaviBarStyle) {
    
    /** 完全透明 */
    TTAlphaNaviBarStyle1=1,
    
    /** 渐变颜色 */
    TTAlphaNaviBarStyle2=2
};

////只有当 style== TTAlphaNaviBarStyle2 生效
//- (void)TTNVAlphaBar:(TTAlphaNaviBarStyle)style BarColor:(UIColor *)color;

- (void)TTNVAlphaBar:(TTAlphaNaviBarStyle)style BarColor:(UIColor *)color bindScrollView:(UIScrollView *)scroll;

//设置默认颜色
- (void)TTNVDefaultBarWithColor:(UIColor *)color bindScrollView:(UIScrollView *)scroll;
//设置默认背景图片
- (void)TTNVDefaultBarWithImg:(UIImage *)img bindScrollView:(UIScrollView *)scroll;


- (void)TTNVShowLine:(BOOL)isShowLine;

@end


//
//  UIViewController+AlphaBar.m
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "UIViewController+AlphaBar.h"
#import <objc/runtime.h>
#import "KVOController.h"

#define weakify( x )  __weak __typeof__(x) __weak_##x##__ = x;
#define normalize( x ) __typeof__(x) x = __weak_##x##__;

#define TTkeyPath(objc,keyPath) @(((void)objc.keyPath, #keyPath))

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)



static NSString * AlphaBarExt_setAlphaVc;

@interface UIViewController (AlphaBar_ext)
/** 开启半透明,枚举默认是0*/
@property (assign, nonatomic) TTAlphaNaviBarStyle TTBarStyle;
@property (strong, nonatomic) UIColor *TTBarBGColor;

@property (strong, nonatomic) UIScrollView *TTbindScroll;


@end
@implementation UIViewController (AlphaBar_ext)
@dynamic TTBarStyle;
-(TTAlphaNaviBarStyle)TTBarStyle
{
    return [objc_getAssociatedObject(self, @selector(TTBarStyle)) integerValue] ;
}

-(void)setTTBarStyle:(TTAlphaNaviBarStyle)TTBarStyle
{
    objc_setAssociatedObject(self, @selector(TTBarStyle), @(TTBarStyle), OBJC_ASSOCIATION_RETAIN);
}
@dynamic TTBarBGColor;
- (UIColor *)TTBarBGColor
{
    return objc_getAssociatedObject(self, @selector(TTBarBGColor));
}

- (void)setTTBarBGColor:(UIColor *)TTBarBGColor
{
    objc_setAssociatedObject(self, @selector(TTBarBGColor), TTBarBGColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@dynamic TTbindScroll;
- (UIScrollView *)TTbindScroll
{
    return objc_getAssociatedObject(self, @selector(TTbindScroll));
}

- (void)setTTbindScroll:(UIScrollView *)TTbindScroll
{
    objc_setAssociatedObject(self, @selector(TTbindScroll), TTbindScroll, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end



@implementation UIViewController (AlphaBar)

//ControllerCategoryOverride(TTAlphaNaviBar)

- (void)TTNVShowLine:(BOOL)isShowLine
{
    if (isShowLine) {
        //todo
        
    }
    else
    {
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        self.extendedLayoutIncludesOpaqueBars = YES;
    }
}

- (void)TTNVDefaultBarWithImg:(UIImage *)img bindScrollView:(UIScrollView *)scroll
{
    
    [self.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([vc isKindOfClass:NSClassFromString(AlphaBarExt_setAlphaVc)]) {
            [vc.KVOController unobserve:vc.TTbindScroll keyPath:TTkeyPath(vc.TTbindScroll, contentOffset)];
        }
    }];
    
    [self.navigationController.navigationBar tt_reset];
    
    
    self.TTbindScroll = scroll;
    
    [self.navigationController.navigationBar tt_setBackgroundImage:img];
    
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11 // 当前Xcode支持iOS11及以上
    
    if (@available(iOS 11.0, *)) {
        scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        
        if (iPhoneX) {
            
            //如果是主模块
            if (self.navigationController.childViewControllers.count==1) {
                //                scroll.contentInset = UIEdgeInsetsMake(88, 0, 49, 0);
                self.edgesForExtendedLayout=UIRectEdgeNone;
                
            }
            else
            {
                self.edgesForExtendedLayout=UIRectEdgeBottom;
                //                scroll.contentInset = UIEdgeInsetsMake(88, 0, 0, 0);
            }
        }
        else//ios11 但不是iphoneX
        {
            
            //如果是主模块
            if (self.navigationController.childViewControllers.count==1) {
                //                scroll.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
                self.edgesForExtendedLayout=UIRectEdgeNone;
                
            }
            else
            {
                //                scroll.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
                self.edgesForExtendedLayout=UIRectEdgeBottom;
                
            }
        }
        
    }
    else//在xcode9 运行 ios11以下的设备 那么自动设置内间距
    {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
#endif
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_11 // 当前Xcode支持iOS11及以上
    self.automaticallyAdjustsScrollViewInsets = YES;
#endif
    
}

- (void)TTNVDefaultBarWithColor:(UIColor *)color bindScrollView:(UIScrollView *)scroll;
{
    //去除滚动的监听
    [self.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([vc isKindOfClass:NSClassFromString(AlphaBarExt_setAlphaVc)]) {
            [vc.KVOController unobserve:vc.TTbindScroll keyPath:TTkeyPath(vc.TTbindScroll, contentOffset)];
        }
    }];
    
    
    [self.navigationController.navigationBar tt_reset];
    
    //    //去除滚动的监听
    //    [self.KVOController unobserve:self.TTbindScroll keyPath:TTkeyPath(self.TTbindScroll, contentOffset)];
    //
    [self.navigationController.navigationBar tt_setBackgroundColor:color];
    
    
    self.TTbindScroll = scroll;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11 // 当前Xcode支持iOS11及以上
    
    if (@available(iOS 11.0, *)) {
        scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        if (iPhoneX) {
            
            //如果是主模块
            if (self.navigationController.childViewControllers.count==1) {
                self.edgesForExtendedLayout=UIRectEdgeNone;
            }
            else
            {
                self.edgesForExtendedLayout=UIRectEdgeBottom;
            }
        }
        else//ios11 但不是iphoneX
        {
            
            //如果是主模块
            if (self.navigationController.childViewControllers.count==1) {
                self.edgesForExtendedLayout=UIRectEdgeNone;
            }
            else
            {
                self.edgesForExtendedLayout=UIRectEdgeBottom;
                
            }
        }
        
    }
    else//在xcode9 运行 ios11以下的设备 那么自动设置内间距
    {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
#endif
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_11 // 当前Xcode支持iOS11及以上
    self.automaticallyAdjustsScrollViewInsets = YES;
#endif
    
}


- (void)TTNVAlphaBar:(TTAlphaNaviBarStyle)style BarColor:(UIColor *)color bindScrollView:(UIScrollView *)scroll
{
    
    [self.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([vc isKindOfClass:NSClassFromString(AlphaBarExt_setAlphaVc)]) {
            [vc.KVOController unobserve:vc.TTbindScroll keyPath:TTkeyPath(vc.TTbindScroll, contentOffset)];
        }
    }];
    
    
    self.TTBarStyle = style;
    self.TTBarBGColor = color;
    
    AlphaBarExt_setAlphaVc = NSStringFromClass([self class]);
    
    
    if (scroll) {
        self.TTbindScroll = scroll;
    }
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11 // 当前Xcode支持iOS11及以上
    
    if (@available(iOS 11.0, *)) {
        scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        if (iPhoneX) {
            
            //如果是主模块
            if (self.navigationController.childViewControllers.count==1) {
                self.edgesForExtendedLayout = UIRectEdgeTop;
            }
            else
            {
                self.edgesForExtendedLayout = UIRectEdgeAll;
                
            }
        }
        else//ios11 但不是iphoneX
        {
            //如果是主模块
            if (self.navigationController.childViewControllers.count==1) {
                
                self.edgesForExtendedLayout = UIRectEdgeTop;
            }
            else
            {
                self.edgesForExtendedLayout = UIRectEdgeAll;
                
            }
        }
        
    }
    else//在xcode9 运行 ios11以下的设备 那么自动设置内间距
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    
#endif
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_11 // 当前Xcode支持iOS11及以上
    self.automaticallyAdjustsScrollViewInsets = NO;
#endif
    
    
    
    
    
    if(self.TTBarStyle==TTAlphaNaviBarStyle1)
    {
        
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar tt_setBackgroundColor:[UIColor clearColor]];
    }
    
    if(self.TTBarStyle==TTAlphaNaviBarStyle2)
    {
        
        
        self.KVOController = [FBKVOController controllerWithObserver:self];//初始化FBKVOController
        
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar tt_setBackgroundColor:[UIColor clearColor]];
        
        
        if (self.TTBarBGColor) {
            [self.navigationController.navigationBar tt_setBackgroundColor:self.TTBarBGColor];
        }
        else
        {
            [self.navigationController.navigationBar tt_setBackgroundColor:[UIColor blackColor]];
        }
        
        if (self.TTbindScroll) {
            
            
            [self initScroll:self.TTbindScroll];
            weakify(self)
            [self.KVOController observe:self.TTbindScroll keyPath:TTkeyPath(self.TTbindScroll, contentOffset) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(UIViewController *Vc, UIScrollView *scView, NSDictionary<NSKeyValueChangeKey, id> *change) {
                normalize(self)
                [self initScroll:self.TTbindScroll];
                
                //                CLOCK_LAYER(clockView).date = change[NSKeyValueChangeNewKey];
            }];
            
            
            
            
            
        }
        
        
    }
    
}



-(void)initScroll:(UIScrollView *)scv
{
    
    if(self.TTBarStyle==TTAlphaNaviBarStyle2)
    {
        CGFloat offsetY = scv.contentOffset.y;
        CGFloat alpha = 0;
        if (offsetY >= 100) {
            
            alpha=((offsetY-100)/100 <= 1.0 ? (offsetY-100)/100:1);
            
            [self.navigationController.navigationBar tt_setBackgroundColor:[self.TTBarBGColor colorWithAlphaComponent:alpha]];
            
        }else{
            [self.navigationController.navigationBar tt_setBackgroundColor:[UIColor clearColor]];
        }
        
        if (offsetY>=0) {
            //        self.bgScrollview.backgroundColor =RGBACOLOR(215, 77, 66, 1);
            //            scv.backgroundColor = [UIColor whiteColor];
            self.navigationController.navigationBar.hidden = NO;
        }
        if (offsetY<0)
        {
            self.navigationController.navigationBar.hidden = YES;
        }
        
    }
}


@end



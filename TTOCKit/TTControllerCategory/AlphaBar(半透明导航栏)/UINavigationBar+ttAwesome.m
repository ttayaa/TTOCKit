//
//  UINavigationBar+ttAwesome.m
//  TTModule
//
//  Created by apple on 2017/4/6.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "UINavigationBar+ttAwesome.h"
#import <objc/runtime.h>


@interface UIViewController (ttAwesome)

@end
@implementation UIViewController (ttAwesome)
- (UIImage *)transBarImg
{
    return objc_getAssociatedObject(self, @selector(transBarImg));
}

- (void)setTransBarImg:(UIImage *)transBarImg
{
    objc_setAssociatedObject(self, @selector(transBarImg), transBarImg, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)transBarColor
{
    return objc_getAssociatedObject(self, @selector(transBarColor));
}

- (void)setTransBarColor:(UIColor *)transBarColor
{
    objc_setAssociatedObject(self, @selector(transBarColor), transBarColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
@implementation UINavigationBar (ttAwesome)
static char overlayKey;

+(void)load
{
    Method layoutSubviews = class_getInstanceMethod(self, @selector(layoutSubviews));
    
    Method ttAwesome_layoutSubviews = class_getInstanceMethod(self, @selector(ttAwesome_layoutSubviews));
    
    method_exchangeImplementations(layoutSubviews, ttAwesome_layoutSubviews);
    
}

-(void)ttAwesome_layoutSubviews
{
    
    [self ttAwesome_layoutSubviews];
    [self insertSubview:self.overlay atIndex:0];
    
    
    UIViewController * tempVc = (UIViewController *)self.nextResponder.nextResponder;
    
    
    //这个bar是pop回来的
    if (![tempVc isKindOfClass:[UINavigationController class]] &&
        tempVc.navigationController
        ) {
        
        
    }
    //这个bar是pop掉的
    if (![tempVc isKindOfClass:[UINavigationController class]] &&
        !tempVc.navigationController
        ) {
        
        UIImageView *tempimgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width),64)];
        tempimgv.image = tempVc.transBarImg;
        tempimgv.backgroundColor = tempVc.transBarColor;
        
        
        CGRect barframe = [tempVc.view.subviews lastObject].frame;
        
        BOOL clipsToBoundsFlag = tempVc.view.clipsToBounds;
        tempVc.view.clipsToBounds = NO;
        
        [tempVc.view.subviews lastObject].frame = CGRectMake(0, -64, CGRectGetWidth(barframe), CGRectGetHeight(barframe));
        
        [[tempVc.view.subviews lastObject] addSubview:tempimgv];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            tempVc.view.clipsToBounds = clipsToBoundsFlag;
            
            [tempimgv removeFromSuperview];
        });
    }
    
    
}
@dynamic overlay;
- (UIImageView *)overlay
{
    
    
    
    if (!objc_getAssociatedObject(self, &overlayKey)) {
        
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        
        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, -statusBarHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + statusBarHeight)];
        
        
        imgv.userInteractionEnabled = NO;
        imgv.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        objc_setAssociatedObject(self, &overlayKey, imgv, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIImageView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)tt_setBackgroundColor:(UIColor *)backgroundColor
{
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.overlay.image = [UIImage new];
    self.overlay.backgroundColor = backgroundColor;
    
    
    UINavigationController *tempNV =  (UINavigationController *)self.nextResponder.nextResponder;
    [tempNV.childViewControllers lastObject].transBarImg = nil;
    [tempNV.childViewControllers lastObject].transBarColor = backgroundColor;
    
    [self insertSubview:self.overlay atIndex:0];
    
}

- (void)tt_setBackgroundImage:(UIImage *)image
{
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.overlay.image = image;
    self.overlay.backgroundColor = [UIColor clearColor];
    
    
    UINavigationController *tempNV =  (UINavigationController *)self.nextResponder.nextResponder;
    [tempNV.childViewControllers lastObject].transBarImg = image;
    [tempNV.childViewControllers lastObject].transBarColor = nil;
    
    
    [self insertSubview:self.overlay atIndex:0];
    
}


- (void)tt_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)tt_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)tt_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}
@end



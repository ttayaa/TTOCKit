//
//  UINavigationBar+ttAwesome.h
//  TTModule
//
//  Created by apple on 2017/4/6.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (ttAwesome)
- (void)tt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)tt_setBackgroundImage:(UIImage *)image;
- (void)tt_setElementsAlpha:(CGFloat)alpha;
- (void)tt_setTranslationY:(CGFloat)translationY;
- (void)tt_reset;
@property (strong, nonatomic) UIImageView *overlay;

@end


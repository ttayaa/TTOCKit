//
//  UIButton+MAC.h
//  MACProject
//
//  Created by ttayaa on 16/8/8.
//  Copyright © 2016年 com.ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger ,tt_EButtonType) {
    kButtonNormal,
    kButtonRed,
    
} ;


@interface UIButton(tt)

/**
 *  创建button
 *
 *  @param frame    frame值
 *  @param type     类型
 *  @param title    标题
 *  @param tag      标签
 *  @param target   目标
 *  @param selector 执行句柄
 *
 *  @return 创建好的button
 */
+ (UIButton *)tt_createButtonWithFrame:(CGRect)frame buttonType:(tt_EButtonType)type title:(NSString *)title tag:(NSInteger)tag
                             target:(id)target action:(SEL)selector;

/**
 *  设置高亮图片
 *
 *  @param image 高亮图片
 */
- (void)tt_setHighlightedImage:(UIImage *)image;

/**
 *  返回高亮图片
 *
 *  @return 高亮图片
 */
- (UIImage *)tt_highlightedImage;

/**
 *  设置普通图片
 *
 *  @param image 普通图片
 */
- (void)tt_setNormalImage:(UIImage *)image;

/**
 *  返回普通图片
 *
 *  @return 普通图片
 */
- (UIImage *)tt_normalImage;

/**
 *  设置选中的图片
 *
 *  @param image 选中的图片
 */
- (void)tt_setSelectedImage:(UIImage *)image;

/**
 *  返回选中的图片
 *
 *  @return 选中的图片
 */
- (UIImage *)tt_selectedImage;


/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)tt_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

/**
 *  扩大点击热区
 *
 *  @param size
 */
- (void)tt_setEnlargeEdge:(CGFloat) size;
- (void)tt_setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

@end

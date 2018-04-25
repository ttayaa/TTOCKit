//
//  UIImage+frame.h
//  common
//
//
//  Copyright © 2016年 ttayaa.
//


//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/
#import <UIKit/UIKit.h>

@interface UIView (TTframe)
//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/
@property (assign,nonatomic) CGFloat TTx;
@property (assign,nonatomic) CGFloat TTy;


//根据xib读取出来的宽自动比例出xib的高(自动适配 4 4s 6 6p)
@property (assign,nonatomic) CGFloat AutoWidth;
//根据xib读取出来的高自动比例出xib的宽(自动适配 4 4s 6 6p)
@property (assign,nonatomic) CGFloat AutoHeight;




@property (nonatomic, assign) CGSize TTsize;

@property (nonatomic, assign) CGFloat TTleft;
@property (nonatomic, assign) CGFloat TTright;
@property (nonatomic, assign) CGFloat TTtop;
@property (nonatomic, assign) CGFloat TTbottom;

@property (nonatomic, assign) CGFloat TTcenterX;
@property (nonatomic, assign) CGFloat TTcenterY;

@property (nonatomic, assign) CGFloat TTwidth;
@property (nonatomic, assign) CGFloat TTheight;


@property (nonatomic, assign) CGFloat TTmaxX;
@property (nonatomic, assign) CGFloat TTmaxY;


@property(retain) id TTcookie;
/**
 *  @brief  找到当前view所在的viewcontroler
 */
@property (readonly) UIViewController *TTviewController;

/**
 *  底部加阴影
 */
-(void)TTaddShadowonBottom;
/**
 *  加灰色阴影
 */
-(void)TTaddGrayGradientShadow;
/**
 *  顶部加阴影
 */
-(void)TTaddShadowonTop;
/**
 *  移动加阴影
 */
-(void)TTaddMovingShadow;
/**
 *  移除阴影
 */
-(void)TTremoveShadow;


/**
 *  相对Rect居中
 */
- (void)TTcenterInRect:(CGRect)rect;
/**
 *  相对Rect垂直居中
 */
- (void)TTcenterVerticallyInRect:(CGRect)rect;
/**
 *  相对Rect水平居中
 */
- (void)TTcenterHorizontallyInRect:(CGRect)rect;
/**
 *  相对父视图居中
 */
- (void)TTcenterInSuperView;
/**
 *  相对父视图垂直居中
 */
- (void)TTcenterVerticallyInSuperView;
/**
 *  相对父视图水平居中
 */
- (void)TTcenterHorizontallyInSuperView;
/**
 *  同一父视图的兄弟视图水平居中
 */
- (void)TTcenterHorizontallyBelow:(UIView *)view padding:(CGFloat)padding;
/**
 *  同一父视图的兄弟视图水平居中
 */
- (void)TTcenterHorizontallyBelow:(UIView *)view;


/*
 * 设置窗体大小
 */
- (void)TTsetFrameSize:(CGSize)newSize;

/*
 * 设置窗体宽度
 */
- (void)TTsetFrameWidth:(CGFloat)newWidth;

/*
 * 设置窗体高度
 */
- (void)TTsetFrameHeight:(CGFloat)newHeight;

/*
 * 设置窗体起始位置
 */
- (void)TTsetFrameOrigin:(CGPoint)newOrigin;

/*
 * 设置窗体起始X
 */
- (void)TTsetFrameOriginX:(CGFloat)newX;

/*
 * 设置窗体起始Y
 */
- (void)TTsetFrameOriginY:(CGFloat)newY;

/*
 * 增加窗体宽度
 */
- (void)TTaddSizeWidth:(CGFloat)newWidth;

/*
 * 增加窗体高度
 */
- (void)TTaddSizeHeight:(CGFloat)newHeight;

/*
 * 移动窗体起始X位置
 */
- (void)TTaddOriginX:(CGFloat)newX;

/*
 * 移动窗体起始Y位置
 */
- (void)TTaddOriginY:(CGFloat)newY;




@end

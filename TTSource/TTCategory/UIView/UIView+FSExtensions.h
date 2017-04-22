//
//  UIView+FSExtensions.h
//  FSMenuController
//
//  Created by ttayaa on 14-2-5.
//
//

#import <UIKit/UIKit.h>

@interface UIView (FSExtensions)

// 获取和设置x坐标
- (CGFloat)viewX;
- (void)setViewX:(CGFloat)xPoint;

// 获取和设置y坐标
- (CGFloat)viewY;
- (void)setViewY:(CGFloat)yPoint;

// 获取和设置width
- (CGFloat)viewWidth;
- (void)setViewWidth:(CGFloat)width;

// 获取和设置height
- (CGFloat)viewHeight;
- (void)setViewHeight:(CGFloat)height;

// 获取和设置origin
- (CGPoint)viewOrigin;
- (void)setViewOrigin:(CGPoint)origin;

// 获取和设置size
- (CGSize)viewSize;
- (void)setViewSize:(CGSize)size;

// 改变 center
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;

// 获取view的最右边的x值
-(CGFloat)viewXRight;
// 获取view的最下边的y值
-(CGFloat)viewYBelow;

//  与一个view的y轴对齐
- (void)centerYalignView:(UIView *)view;
// 增加y坐标
- (void)addViewY:(CGFloat)yPoint;

/**
 *  show the border around the view
 *
 *  @param color border color
 */
- (void)showBorderWithColor:(UIColor*)color;

/**
 *  Print the view positino information.
 */
- (void)printPositionInfo;

/**
 *	Extract a view from a xib
 *  Note: The view and class name must be the same.
 *
 *	@return	the view extracted or nil if fail
 */
+ (UIView *)extractFromXib;

/**
 *  Remove all subView
 */
- (void)removeAllSubView;

/**
 *  As its name hints.
 **/
-(void)moveRightToParentWithPadding:(CGFloat) padding;

/**
 *  As its name hints.
 **/
-(void)centerHorizontally;

/**
 *  As its name hints.
 **/
-(void)centerVertically;

/**
 *  Set up the widget accessibility label.
 *
 *  @param accessibilityLabel the label to set to widget.
 */
-(void)setupAccessibility:(NSString *)accessibilityLabel;

/**
 *  @description
 *      根据 320 屏幕尺寸宽度，计算出大小
 *  @params
 *      width   需要计算的view的大小
 *  @returns
 *      返回等比 320 比例对应的大小
 */
+ (CGFloat)convert320Scale:(CGFloat)width;

/**
 *  相对于window的位置
 *
 *  @return 返回view相对于window的位置
 */
- (CGRect )positionInWindow;


@end

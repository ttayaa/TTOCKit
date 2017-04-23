//
//  UIView+Contraints.h
//  elmsc
//
//  Created by Jekity on 17/8/16.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Contraints)

@property (nonatomic,strong)NSMutableArray *constraintsArray ;
/**左边*/
-(void)leftEqualToView:(UIView *)toView margain:(CGFloat) space;

/**右边*/
-(void)rightEqualToView:(UIView *)toView margain:(CGFloat) space;

/**顶端*/
-(void)topEqualToView:(UIView *)toView margain:(CGFloat) space;

/**顶端*/
-(void)bottomEqualToView:(UIView *)toView margain:(CGFloat) space;

/**X中心点*/
-(void)centerXEqualToView:(UIView *)toView;

/**Y中心点*/
-(void)centerYEqualToView:(UIView *)toView;

/**顶部相等*/
-(void)topEqualToView:(UIView *)toView;

/**底部相等*/
-(void)bottomEqualToView:(UIView *)toView;

/**左边相等*/
-(void)leftEqualToView:(UIView *)toView;

/**右边相等*/
-(void)rightEqualToView:(UIView *)toView;

/**宽度相等*/
-(void)widthEqualToView:(UIView *)toView;

/**高度相等*/
-(void)heightEqualToView:(UIView *)toView;

/**设置高度*/
-(void)heightForView:(CGFloat)height;

/**设置高度为某个高度的倍数*/
-(void)heightForView:(CGFloat)height multipler:(CGFloat)multipler;

/**设置高度为参考对象高度的倍数*/
-(void)heightForView:(UIView *)toView multipler:(CGFloat)multipler constant:(CGFloat)constant;

/**设置宽度*/
-(void)widthForView:(CGFloat)width;

/**设置宽度为某个宽度的倍数*/
-(void)widthForView:(CGFloat)width multipler:(CGFloat)multipler;

/**设置宽度为参考对象宽度的倍数*/
-(void)widthForView:(UIView *)toView multipler:(CGFloat)multipler constant:(CGFloat)constant;

-(UIView*)superViewFromView;

/**控件尺寸*/
-(void)equalToSize: (CGSize) size;

/**移除约束*/
-(void)removeAllConstraint;
@end

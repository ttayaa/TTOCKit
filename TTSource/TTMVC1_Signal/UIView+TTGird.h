//
//  UIView+TTGird.h
//  bssc
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GirdViewCreateBlock)(UIView *clickView,NSInteger createIndex);


typedef void (^GirdViewFrameBlock)(CGRect rect,NSInteger idx);

typedef void (^GirdViewFrameFinishBlock)(CGFloat needHeight);



@interface UIView (TTGird)

//+(UIView *)TTmakeGird:(UIView *)girdview cols:(NSInteger)cols rows:(NSInteger)rows;

+(void)TTmakeGirdWithContainView:(UIView *)ContainView XibGirdView:(Class)GirdviewClass makeCount:(NSInteger)Conut ContainViewfixWidth:(CGFloat)backViewWidth cols:(NSInteger)cols LeftRightEdge:(CGFloat)LeftRightEdge TopBottomEdge:(CGFloat)TopBottomEdge LeftRightiInnerEdge:(CGFloat)LeftRightiInnerEdge TopBottomInnerEdge:(CGFloat)TopBottomInnerEdge GirdViewCreateBlock:(GirdViewCreateBlock)Createblock;


+(void)TTgetGirdViewFrameWithGirdViewHeight:(CGFloat)GirdviewHeight makeCount:(NSInteger)Conut ContainViewfixWidth:(CGFloat)backViewWidth cols:(NSInteger)cols LeftRightEdge:(CGFloat)LeftRightEdge TopBottomEdge:(CGFloat)TopBottomEdge LeftRightiInnerEdge:(CGFloat)LeftRightiInnerEdge TopBottomInnerEdge:(CGFloat)TopBottomInnerEdge GirdViewFrameBlock:(GirdViewFrameBlock)GirdViewFrameBlock Finish:(GirdViewFrameFinishBlock)GirdViewFrameFinishBlock;
@end

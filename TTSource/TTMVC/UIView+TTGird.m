//
//  UIView+TTGird.m
//  bssc
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "UIView+TTGird.h"

@implementation UIView (TTGird)






//根据传入的backViewWidth的宽度

+(void)TTmakeGirdWithContainView:(UIView *)ContainView XibGirdView:(Class)GirdviewClass makeCount:(NSInteger)Conut ContainViewfixWidth:(CGFloat)backViewWidth cols:(NSInteger)cols LeftRightEdge:(CGFloat)LeftRightEdge TopBottomEdge:(CGFloat)TopBottomEdge LeftRightiInnerEdge:(CGFloat)LeftRightiInnerEdge TopBottomInnerEdge:(CGFloat)TopBottomInnerEdge GirdViewCreateBlock:(GirdViewCreateBlock)Createblock
{
    [ContainView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([view isKindOfClass:GirdviewClass]) {
            [view removeFromSuperview];
        }
    }];
    
    
    //控件宽度
    CGFloat Vwidth = (backViewWidth - 2*LeftRightEdge - LeftRightiInnerEdge*(cols-1))/cols;
    
    
   
    UIView *tempGird = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([GirdviewClass class]) owner:nil options:nil] firstObject];
    
 //根据宽度  比例出xib的高度
    
    CGRect tempGirdframe = tempGird.frame;
    //    保证xib的height原始比例
    CGFloat WHscale = tempGirdframe.size.width/tempGirdframe.size.height;
    tempGirdframe.size.width = backViewWidth;
    tempGirdframe.size.height = backViewWidth / WHscale;
    tempGird.frame = tempGirdframe;
    
    
    //控件高度
    CGFloat Vheight = tempGird.frame.size.height;
    
    
    //计算出总共有几行
    NSInteger rows = Conut/cols+1;
    
    
     CGRect ContainViewframe = ContainView.frame;
    ContainViewframe.size.width = backViewWidth;
    ContainViewframe.size.height = rows*Vheight + 2*TopBottomEdge + LeftRightiInnerEdge*(rows-1);
    ContainView.frame = ContainViewframe;
    
    
    
    
    
    for (int idx=0; idx<Conut; idx++) {
        
       
        UIView *gird = (UIView *)[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([GirdviewClass class]) owner:nil options:nil] firstObject];
        
        NSUInteger col = idx % cols;
        
        CGFloat X = col * (Vwidth + LeftRightiInnerEdge) + LeftRightEdge;
        
        NSUInteger row = idx / cols;
        
        CGFloat Y = row * (Vheight + TopBottomInnerEdge) + TopBottomEdge;
        
        gird.frame = CGRectMake(X, Y, Vwidth, Vheight);
        
        gird.tag = idx;
        
        [ContainView addSubview:gird];
        
        Createblock(gird,idx);
        
    }
    

}


+(void)TTgetGirdViewFrameWithGirdViewHeight:(CGFloat)GirdviewHeight makeCount:(NSInteger)Conut ContainViewfixWidth:(CGFloat)backViewWidth cols:(NSInteger)cols LeftRightEdge:(CGFloat)LeftRightEdge TopBottomEdge:(CGFloat)TopBottomEdge LeftRightiInnerEdge:(CGFloat)LeftRightiInnerEdge TopBottomInnerEdge:(CGFloat)TopBottomInnerEdge GirdViewFrameBlock:(GirdViewFrameBlock)GirdViewFrameBlock Finish:(GirdViewFrameFinishBlock)GirdViewFrameFinishBlock;
{
    
    //控件宽度
    CGFloat Vwidth = (backViewWidth - 2*LeftRightEdge - LeftRightiInnerEdge*(cols-1))/cols;
    
    
    //控件高度
    CGFloat Vheight = GirdviewHeight;
    
    
    for (int idx=0; idx<Conut; idx++) {
        
        NSUInteger col = idx % cols;
        
        CGFloat X = col * (Vwidth + LeftRightiInnerEdge) + LeftRightEdge;
        
        NSUInteger row = idx / cols;
        
        CGFloat Y = row * (Vheight + TopBottomInnerEdge) + TopBottomEdge;
        
        
        GirdViewFrameBlock(CGRectMake(X, Y, Vwidth, Vheight),idx);
        
    }
    
    //计算出总共有几行
    NSInteger rows = (Conut-1)/cols+1;
    
    if (Conut<1) {
        GirdViewFrameFinishBlock(0);
    }
    else
    {
        
        CGFloat Totalheight = rows*Vheight + 2*TopBottomEdge + TopBottomInnerEdge*(rows-1);
        
        GirdViewFrameFinishBlock(Totalheight);
    }
    
}


@end

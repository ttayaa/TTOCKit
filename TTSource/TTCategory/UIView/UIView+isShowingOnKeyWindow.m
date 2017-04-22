//
//  UIView+isShowingOnKeyWindow.m
//  ttayaa微博部署
//
//  Created by apple on 16/5/22.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import "UIView+isShowingOnKeyWindow.h"

@implementation UIView (isShowingOnKeyWindow)
- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}



@end

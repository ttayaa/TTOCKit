//
//  UIViewController+CurVc.m
//  fscar
//
//  Created by apple on 2016/11/16.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import "UIViewController+CurVc.h"
#import "ControllerCategoryOverride.h"

@implementation UIViewController (CurVc)

//引用当前控制器, 不能使用强指针
static UIViewController * __weak CurSignalVc;

ControllerCategoryOverride(CurVc)
viewWillAppear(CurVc)
{
    // 主窗口的bounds 和 self控制器 是否有重叠
    if(CGRectIntersectsRect(self.view.frame, [UIApplication sharedApplication].keyWindow.bounds))
    {
        CurSignalVc = self;
    }
}

+(UIViewController *)getCurSignalVc
{
    return CurSignalVc;
}


@end


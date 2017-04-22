//
//  ModalAnimator_midAnimation.h
//  elmsc
//
//  Created by apple on 2016/10/3.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModalAnimator_midAnimation : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

/** 显示出来的控制器View的尺寸(目标控制器View的尺寸)*/
@property (assign, nonatomic) CGRect presentFrame;

@end

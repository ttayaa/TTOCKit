//
//  ModalAnimator_downMenuAnimation_clear.h
//  elmsc
//
//  Created by apple on 16/9/24.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModalAnimator_downMenuAnimation_clear : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

/** 显示出来的控制器View的尺寸(目标控制器View的尺寸)*/
@property (assign, nonatomic) CGRect presentFrame;

@end

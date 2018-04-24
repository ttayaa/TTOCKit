//
//  ModalAnimator_midSpringPopAnimation_black.h
//  fschat
//
//  Created by apple on 2016/12/23.
//  Copyright © 2016年 丰硕聊天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModalAnimator_midSpringPopAnimation_black : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

/** 显示出来的控制器View的尺寸(目标控制器View的尺寸)*/
@property (assign, nonatomic) CGRect presentFrame;

@end

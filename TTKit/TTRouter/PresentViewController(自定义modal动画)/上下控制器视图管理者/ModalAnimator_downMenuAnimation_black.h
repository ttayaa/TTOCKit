//
//  ModalAnimator_downMenuAnimation_black.h
//  fscar
//
//  Created by apple on 2016/10/23.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModalAnimator_downMenuAnimation_black : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>
/** 显示出来的控制器View的尺寸(目标控制器View的尺寸)*/
@property (assign, nonatomic) CGRect presentFrame;
@end

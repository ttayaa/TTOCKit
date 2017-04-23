//
//  PopAnimator_downAnimation.h
//  ttayaa
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModalAnimator_downToUpAnimation : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

/** 显示出来的控制器View的尺寸(目标控制器View的尺寸)*/
@property (assign, nonatomic) CGRect presentFrame;


@end

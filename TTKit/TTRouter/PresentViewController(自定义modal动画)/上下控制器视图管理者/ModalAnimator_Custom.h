//
//  ModalAnimator_Custom.h
//  bssc
//
//  Created by apple on 2017/3/19.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^whenDisplay)(UIView *toView,id<UIViewControllerContextTransitioning> transitionContext);

typedef void (^whenDismiss)(UIView *fromView,id<UIViewControllerContextTransitioning> transitionContext);



@interface ModalAnimator_Custom : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>


/** 显示出来的控制器View的尺寸(目标控制器View的尺寸)*/
@property (assign, nonatomic) CGRect presentFrame;

@property (strong, nonatomic) UIColor * hudColor;


@property (copy, nonatomic) whenDisplay whenDisplayBlock;

@property (copy, nonatomic) whenDismiss whenDismissBlock;


//外部使用block是动画结束一定要加上
//[transitionContext completeTransition:YES];
// 不然会出现未知错误

+(instancetype)ModalAnimaterPresentFram:(CGRect)rect hudColor:(UIColor *)color whenDisplay:(whenDisplay)whenDisplayBlock whenDismiss:(whenDismiss)whenDismissBlock;


@end




@interface PopPresentationController_Custom : UIPresentationController

/** 外部提供的 目标控制器的view的尺寸*/
@property (assign,nonatomic) CGRect presentFrame;

@property (strong, nonatomic) UIColor * hudColor;

-(instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController;


@end

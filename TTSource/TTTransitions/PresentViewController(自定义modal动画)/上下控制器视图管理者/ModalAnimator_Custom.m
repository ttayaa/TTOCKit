//
//  ModalAnimator_Custom.m
//  bssc
//
//  Created by apple on 2017/3/19.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "ModalAnimator_Custom.h"

#define hScreenBounds [UIScreen mainScreen].bounds
#define RGBA32Color(r, g, b, a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:(a)*1.0]



@implementation ModalAnimator_Custom


+(instancetype)ModalAnimaterPresentFram:(CGRect)rect hudColor:(UIColor *)color whenDisplay:(whenDisplay)whenDisplayBlock whenDismiss:(whenDismiss)whenDismissBlock
{
    ModalAnimator_Custom *Animator = [ModalAnimator_Custom new];
    
    Animator.presentFrame = rect;
    Animator.hudColor = color;
    Animator.whenDisplayBlock = whenDisplayBlock;
    Animator.whenDismissBlock = whenDismissBlock;
    
    return Animator;
}


/** 记录动画是在present还是在dismiss*/
static bool isPresent = NO;

/** 通知外界 将要开始执行present动画*/
#define ModalAnimator_Custom_PresentNotification @"ModalAnimator_Custom_PresentNotification"
/** 通知外界 将要开始执行dismiss动画*/
#define ModalAnimator_Custom_DismissNotification @"ModalAnimator_Custom_DismissNotification"
#pragma mark - UIViewControllerTransitioningDelegate

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0)
{
    PopPresentationController_Custom * ppVc =[[PopPresentationController_Custom alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    
    ppVc.presentFrame = self.presentFrame;
    
    ppVc.hudColor = self.hudColor;
    
    return ppVc;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    //说明执行的是present显示动画
    isPresent = YES;
    
    //发送一个通知告诉外界 将要进行present动画
    [[NSNotificationCenter defaultCenter] postNotificationName:ModalAnimator_Custom_PresentNotification object:self];
    
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    //说明执行的是dismiss消失动画
    isPresent = NO;
    
    //发送一个通知告诉外界 将要进行present动画
    [[NSNotificationCenter defaultCenter] postNotificationName:ModalAnimator_Custom_DismissNotification object:self];
    
    return self;
}




#pragma mark - UIViewControllerAnimatedTransitioning
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    
    //显示时候的动画
    if(isPresent)
    {
        
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        //2, 将toView添加到容器视图上
        UIView *containerView = [transitionContext containerView];
        [containerView addSubview:toView];
        
        self.whenDisplayBlock(toView,transitionContext);
        
        
    }
    //消失时候的动画
    else
    {
        //消失动画的需要的是FromView
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        self.whenDismissBlock(fromView,transitionContext);
        
    }
}



@end







@implementation PopPresentationController_Custom


-(instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    return  [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
}

//ViewController都有一个containerView层,view是添加在这个层上面的
//这个方法可以布局 将要转场到的控制器view(self.presentedView)的frame
-(void)containerViewWillLayoutSubviews
{
    
    if (CGRectEqualToRect(self.presentFrame, CGRectZero) ) {
        self.presentedView.frame =CGRectMake(0, 0, 200, 200);
    }
    else
    {
        self.presentedView.frame =self.presentFrame;
    }
    
    //2,设置一个蒙版 让用户知道后面是不能点击的
    //虽然已经有了self.containerView,但是我们不要直接操作(私有API),而是创建一个view
    UIView * HUDview = [UIView new];
    HUDview.frame = hScreenBounds;
    HUDview.backgroundColor = self.hudColor;
    [self.containerView insertSubview:HUDview atIndex:0];
    UIGestureRecognizer *TapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HUDClick)];
    [HUDview addGestureRecognizer:TapGes];
    
}

-(void)HUDClick
{
    //在这个控制器中可以拿到presentedViewController和presentingViewController
    //dismiss控制器
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

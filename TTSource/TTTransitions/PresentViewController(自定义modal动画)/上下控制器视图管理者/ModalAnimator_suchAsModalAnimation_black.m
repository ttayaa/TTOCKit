//
//  ModalAnimator_suchAsModalAnimation_black.m
//  fscar
//
//  Created by apple on 2016/10/28.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import "ModalAnimator_suchAsModalAnimation_black.h"
#import "PopPresentationController_fadeInAlphaBlack_frame.h"
#import "UIView+TTTransitions.h"

@implementation ModalAnimator_suchAsModalAnimation_black
/** 记录动画是在present还是在dismiss*/
static bool isPresent = NO;

/** 通知外界 将要开始执行present动画*/
#define ModalAnimator_downToUpAnimationPresentNotification @"ModalAnimator_downToUpAnimationPresentNotification"
/** 通知外界 将要开始执行dismiss动画*/
#define PopoverAnimatorDismissNotification @"ModalAnimator_downToUpAnimationDismissNotification"


#pragma mark - UIViewControllerTransitioningDelegate
/**
 当目标控制器的view 被(present)modal出来时就会调用,
 用来获得一个能处理presentedView(目标控制器的view)和presentingView(发起modal的控制器的view)
 的控制器
 
 实现代理方法:返回一个UIPresentationController对象(ios8推出的处理转场动画的对象)
 
 UIPresentationController需要我们自定义,
 该框架中定义了一个PopPresentationController_fadeInAlphaBlack_frame继承自它
 (在这个类中我们主要用来处理目标控制器的view的frame)
 */
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0)
{
    PopPresentationController_fadeInAlphaBlack_frame * ppVc =[[PopPresentationController_fadeInAlphaBlack_frame alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    
    //传递目标控制器的View的尺寸
    //如果在这个方法中设置ppVc.presentedView.frame得到的结果不准确
    //所以需要再将frame传递给PopPresentationController_fadeInAlphaBlack_frame
    //不准确ppVc.presentedView.frame = CGRectMake(100, 0, 300, 100);
    
    ppVc.presentFrame = self.presentFrame;
    
    return ppVc;
}

/**当present时会调用
 
 返回一个  在Present(展现)时处理动画  的对象
 (这个对象要实现UIViewControllerAnimatedTransitioning协议)
 (这里我们返回自己,让自己来处理动画,所以自己还要实现这个协议)
 */
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    //说明执行的是present显示动画
    isPresent = YES;
    
    //发送一个通知告诉外界 将要进行present动画
    [[NSNotificationCenter defaultCenter] postNotificationName:ModalAnimator_downToUpAnimationPresentNotification object:self];
    
    return self;
}

/**当dismiss时会调用
 
 返回一个  在dismiss(消失)时处理动画  的对象
 (这个对象要实现UIViewControllerAnimatedTransitioning协议)
 (这里我们返回自己,让自己来处理动画,所以自己还要实现这个协议)
 */
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    //说明执行的是dismiss消失动画
    isPresent = NO;
    
    //发送一个通知告诉外界 将要进行present动画
    [[NSNotificationCenter defaultCenter] postNotificationName:PopoverAnimatorDismissNotification object:self];
    
    return self;
}


#pragma mark - UIViewControllerAnimatedTransitioning
//transitionDuration和animateTransition必须实现默认不写(表示@required必须实现)
/**
 返回动画时长 (包括2个动画,present和dismiss)
 
 param: transitionContext 转场上下文, 提供了转场需要的参数
 
 returns: 返回动画时长
 */
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

/**
 这个方法处理动画的细节,(包括两个动画)
 转场动画实现函数, 一旦实现这个方法默认的转场动画会失效, 一切都由程序员提供
 
 我们在这个方法中处理 present和dismiss 时的两个动画效果
 所以需要我们设置一个标记来记录是在modal还是在dismiss
 
 注意:当present动画的时候目标控制器的View是ToView
 当dismiss动画的时候目标控制器的View是FromView
 
 :param: transitionContext 转场上下文, 提供了转场需要的参数
 */
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    
    //显示时候的动画
    if(isPresent)
    {
        
        //1, 获取目标控制器的View(适配ios7用前两个)
        //UITransitionContextFromViewControllerKey NS_AVAILABLE_IOS(7_0);
        //UITransitionContextToViewControllerKey NS_AVAILABLE_IOS(7_0);
        //UITransitionContextFromViewKey NS_AVAILABLE_IOS(8_0);
        //UITransitionContextToViewKey NS_AVAILABLE_IOS(8_0);
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        //2, 将toView添加到容器视图上
        UIView *containerView = [transitionContext containerView];
        [containerView addSubview:toView];
        
        
        //3, 实现动画
        //3.1,高度缩放为0
        //初始形变
//        toView.transform = CGAffineTransformMakeScale(1, 0);
        
        toView.TTTransitions_centerY = [UIScreen mainScreen].bounds.size.height+200;
        
        //设置动画开始的锚点
        //注意缩放是根据锚点进行的,(所以还要设置锚点)
        //如果不设置会从中间向上和向下展示
        toView.layer.anchorPoint = CGPointMake(0, 0);
        
        [UIView animateWithDuration:0.3 animations:^{
            //还原形变
            toView.TTTransitions_centerY = -([UIScreen mainScreen].bounds.size.height+200);
        } completion:^(BOOL finished) {
            // 一定要告诉系统转场动画结束
            // 不然会出现为止错误
            [transitionContext completeTransition:YES];
        }];
        
    }
    //消失时候的动画
    else
    {
        //消失动画的需要的是FromView
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        [UIView animateWithDuration:0.2 animations:^{
            // (小bug)由于CGFloat不准确, 所以需要写一个很小的数字即可
            fromView.TTTransitions_centerY = [UIScreen mainScreen].bounds.size.height+200;
            
        } completion:^(BOOL finished) {
            // 一定要告诉系统转场动画结束
            // 不然会出现未知错误
            [transitionContext completeTransition:YES];
        }];
        
        
    }
}

@end

//
//  PopAnimator_upTpdownAnimation.m
//  elmsc
//
//  Created by apple on 2016/10/14.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#import "PopAnimator_upTpdownAnimation.h"

@implementation PopAnimator_upTpdownAnimation


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect finalFrameForVc = [transitionContext finalFrameForViewController:toVc];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    toVc.view.frame = CGRectOffset(finalFrameForVc, 0, -bounds.size.height);
    
    [[transitionContext containerView] addSubview:toVc.view];
    
    //    弹簧
//    [UIView animateWithDuration:[self transitionDuration:transitionContext]
//                          delay:0.0
//         usingSpringWithDamping:0.4
//          initialSpringVelocity:10.0
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         fromVc.view.alpha = 0.8;
//                         toVc.view.frame = finalFrameForVc;
//                     }
//                     completion:^(BOOL finished) {
//                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//                         fromVc.view.alpha = 1.0;
//                     }];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVc.view.alpha = 0.8;
//        fromVc.view.transform = CGAffineTransformMakeTranslation(0, finalFrameForVc.size.height);
//        fromVc.view.layer.transform = CATransform3DMakeTranslation(0, finalFrameForVc.size.height, 0);
           fromVc.view.frame = CGRectMake(0, finalFrameForVc.size.height, finalFrameForVc.size.width, finalFrameForVc.size.height);
        toVc.view.frame = finalFrameForVc;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        fromVc.view.alpha = 1.0;
    }];
}

@end

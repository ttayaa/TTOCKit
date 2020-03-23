//
//  NavigationBarPop_push_Manager.m
//  fscar
//
//  Created by apple on 2016/10/30.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import "NavigationBarPop_push_Manager.h"
#import "PopAnimator_upTpdownAnimation.h"
#import "PushAnimator_downToupAnimation.h"


@interface NavigationBarPop_push_Manager()<UINavigationControllerDelegate>
//pop动画转场管理者
@property (nonatomic,strong)PopAnimator_upTpdownAnimation *popAnimator;
//push动画转场管理者
@property (nonatomic,strong)PushAnimator_downToupAnimation *pushAnimator;

@end

@implementation NavigationBarPop_push_Manager

static NSInteger TTRouterAnimationType;
static NavigationBarPop_push_Manager *NavigationManage;

+(void)load
{
    NavigationManage = [NavigationBarPop_push_Manager new];
}


+(void)manageUseAnimationType:(NaviBarAnimationType)type NavigationController:(UINavigationController *)NavigationController
{
    NavigationController.delegate = NavigationManage;
    TTRouterAnimationType = type;

}


#pragma mark - push
//push动画转场管理者
-(PushAnimator_downToupAnimation *)pushAnimator
{
    if (!_pushAnimator) {
        _pushAnimator = [PushAnimator_downToupAnimation new];
    }
    return _pushAnimator;
}
-(PopAnimator_upTpdownAnimation *)popAnimator
{
    if (!_popAnimator) {
        _popAnimator = [PopAnimator_upTpdownAnimation new];
    }
    return _popAnimator;
}

/** 返回转场动画实例 只做push*/
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        
        if (TTRouterAnimationType == NaviBarAnimationRootVcViewUpDown)
            return self.pushAnimator;
        if (TTRouterAnimationType == NaviBarAnimationRootVcOnlyPushUp)
            return self.pushAnimator;
       
        
            return nil;
        
    }else if (operation == UINavigationControllerOperationPop){
        if (TTRouterAnimationType == NaviBarAnimationRootVcViewUpDown)
            return self.popAnimator;
        
        if (TTRouterAnimationType == NaviBarAnimationRootVcOnlyPopDown)
            return self.popAnimator;
        
            return nil;
        
    }
    return nil;
}

@end

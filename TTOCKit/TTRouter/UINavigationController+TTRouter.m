//
//  UINavigationController+TTRouter.m
//  ZPCommon
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 ZengPing. All rights reserved.
//

#import "UINavigationController+TTRouter.h"
#import <objc/runtime.h>

#import "YYModel.h"



@implementation UIViewController (TTRouter)

/** modal   出控制器 带回调 以弹框的形式
 被push的控制器调用
 self.callbackblock(你需要回传的参数);
 */
-(void)TTPresentStyleViewController:(id)VcName animated:(BOOL)animated frame:(CGRect)rect style:(TTPresentStyle)style SetupParms:(NVWillPushBlock)block completion: (TTWillPresentCompletionBlock)completion callback:(TTRouterCallBackBlock)callbackblock jumpError:(TTWillPresentCompletionBlock)jumperrorblock
{
    [self WillPresentViewController:VcName animated:animated frame:rect isCustom:NO style:style hudColor:nil whenDisplay:nil whenDismiss:nil SetupParms:block completion:completion callback:callbackblock jumpError:jumperrorblock];
}

/** 可自定义动画
 */
-(void)TTPresentCustomViewController:(id)VcName animated:(BOOL)animated frame:(CGRect)rect hudColor:(UIColor *)color whenDisplay:(whenDisplay)whenDisplayBlock whenDismiss:(whenDismiss)whenDismissBlock SetupParms:(NVWillPushBlock)block completion: (TTWillPresentCompletionBlock)completion callback:(TTRouterCallBackBlock)callbackblock jumpError:(TTWillPresentCompletionBlock)jumperrorblock;
{
    [self WillPresentViewController:VcName animated:animated frame:rect isCustom:YES style:0 hudColor:color whenDisplay:whenDisplayBlock whenDismiss:whenDismissBlock SetupParms:block completion:completion callback:callbackblock jumpError:jumperrorblock];
}


/** modal   出控制器 带回调
 被push的控制器调用
 self.callbackblock(你需要回传的参数);
 */
-(void)TTPresentDefaultViewController:(id)VcName animated:(BOOL)animated SetupParms:(NVWillPushBlock)block completion: (TTWillPresentCompletionBlock)completion callback:(TTRouterCallBackBlock)callbackblock jumpError:(TTWillPresentCompletionBlock)jumperrorblock
{
    
    if (!VcName) {
        if (jumperrorblock) {
            jumperrorblock();
        }
        return;
    }
    
    
    NSMutableDictionary * dict= [NSMutableDictionary dictionary];
    
    UIViewController *willPresentVc;
    
    if ([VcName isKindOfClass:[NSString class]]) {
        willPresentVc = [NSClassFromString(VcName) new];
    }
    else if ([VcName isKindOfClass:[UIViewController class]]) {
        willPresentVc = VcName;
    }
    
    
    
    if (block) {
        
        block(willPresentVc,dict);
        
    }
    
    if (!willPresentVc) {
        
        
        if (jumperrorblock) {
            jumperrorblock();
        }
        
        return;
    }
    
    
    
    [willPresentVc yy_modelSetWithDictionary:dict];
    
    willPresentVc.callbackblock = callbackblock;
    
    
    
    [self  presentViewController:willPresentVc animated:animated completion:^{
        if (completion) {
            completion();
        }
        
    }];
    
    
}





-(void)WillPresentViewController:(id)VcName animated:(BOOL)animated frame:(CGRect)rect isCustom:(BOOL)iscustom style:(TTPresentStyle)style hudColor:(UIColor *)color whenDisplay:(whenDisplay)whenDisplayBlock whenDismiss:(whenDismiss)whenDismissBlock SetupParms:(NVWillPushBlock)block completion: (TTWillPresentCompletionBlock)completion callback:(TTRouterCallBackBlock)callbackblock jumpError:(TTWillPresentCompletionBlock)jumperrorblock
{
    if (!VcName) {
        if (jumperrorblock) {
            jumperrorblock();
        }
        return;
    }
    
    
    NSMutableDictionary * dict= [NSMutableDictionary dictionary];
    
    UIViewController *willPresentVc;
    
    if ([VcName isKindOfClass:[NSString class]]) {
        willPresentVc = [NSClassFromString(VcName) new];
    }
    else if ([VcName isKindOfClass:[UIViewController class]]) {
        willPresentVc = VcName;
    }
    
    
    
    if (block) {
        
        block(willPresentVc,dict);
        
    }
    
    
    
    if (!willPresentVc) {
        
        
        if (jumperrorblock) {
            jumperrorblock();
        }
        
        return;
    }
    
    //如果有参数,
    
    [willPresentVc yy_modelSetWithDictionary:dict];
    
    
    willPresentVc.callbackblock = callbackblock;
    
    
    if (iscustom) {
        
        [self presentViewController:willPresentVc animated:animated frame:rect hudColor:color whenDisplay:^(UIView *toView, id<UIViewControllerContextTransitioning> transitionContext) {
            if(whenDisplayBlock)
            {
                whenDisplayBlock(toView,transitionContext);
            }
            
        } whenDismiss:^(UIView *fromView, id<UIViewControllerContextTransitioning> transitionContext) {
            
            if (whenDismissBlock) {
                whenDismissBlock(fromView,transitionContext);
            }
            
        } completion:^{
            
            if (completion) {
                completion();
            }
            
        }];
    }
    else
    {
        [self presentViewController:willPresentVc animated:animated frame:rect style:style completion:^{
            if (completion) {
                completion();
            }
        }];
    }
    
    
    
    
}






-(id)TTRouterCallbackParms
{
    return objc_getAssociatedObject(self, @selector(TTRouterCallbackParms));
}
-(void)setTTRouterCallbackParms:(id)TTRouterCallbackParms
{
    objc_setAssociatedObject(self, @selector(TTRouterCallbackParms), TTRouterCallbackParms, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic callbackblock;
-(TTRouterCallBackBlock)callbackblock
{
    if (!objc_getAssociatedObject(self, @selector(callbackblock))) {
        self.callbackblock = ^(id parms){};
    }
    return objc_getAssociatedObject(self, @selector(callbackblock));
}
-(void)setCallbackblock:(TTRouterCallBackBlock)callbackblock
{
    objc_setAssociatedObject(self, @selector(callbackblock), callbackblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end














@implementation UINavigationController (TTRouter)


-(void)TTPushViewController:(id)VcName animated:(BOOL)animated SetupParms:(NVWillPushBlock)block callback:(TTRouterCallBackBlock)callbackblock jumpError:(TTWillPresentCompletionBlock)jumperrorblock
{
    
    NSMutableDictionary * dict= [NSMutableDictionary dictionary];
    
    UIViewController *willPushVc;
    
    
    if ([VcName isKindOfClass:[NSString class]]) {
        willPushVc = [NSClassFromString(VcName) new];
    }
    else if ([VcName isKindOfClass:[UIViewController class]]) {
        willPushVc = VcName;
    }
    
    
    if (block) {
        
        block(willPushVc,dict);
        
    }
    
    
    //如果控制器不存在
    if (!willPushVc) {
        
        
        if (jumperrorblock) {
            jumperrorblock();
        }
        
        return;
    }
    
    
    
    [willPushVc yy_modelSetWithDictionary:dict];
    
    //传递回调
    willPushVc.callbackblock = callbackblock;
    
    
    [self pushViewController:willPushVc animated:animated];
    
    
    
}


@end

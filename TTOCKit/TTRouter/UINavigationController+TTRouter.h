//
//  UINavigationController+TTRouter.h
//  ZPCommon
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 ZengPing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+CustomPopVc.h"

typedef void (^TTRouterCallBackBlock)(id parameter);
typedef void (^NVWillPushBlock)(UIViewController *vc,NSMutableDictionary *dict);
typedef void (^TTWillPresentCompletionBlock)(void);
@interface UIViewController (TTRouter)

//回调的block
@property (strong, nonatomic) TTRouterCallBackBlock callbackblock;

/** modal   出控制器 带回调
 被Present的控制器调用
 self.callbackblock(你需要回传的参数);
 */
-(void)TTPresentDefaultViewController:(id)VcName animated:(BOOL)animated SetupParms:(NVWillPushBlock)block completion: (TTWillPresentCompletionBlock)completion callback:(TTRouterCallBackBlock)callbackblock jumpError:(TTWillPresentCompletionBlock)jumperrorblock;


/** modal   出控制器 带回调 以弹框的形式
 被Present的控制器调用
 self.callbackblock(你需要回传的参数);
 */
-(void)TTPresentStyleViewController:(id)VcName animated:(BOOL)animated frame:(CGRect)rect style:(TTPresentStyle)style SetupParms:(NVWillPushBlock)block completion: (TTWillPresentCompletionBlock)completion callback:(TTRouterCallBackBlock)callbackblock jumpError:(TTWillPresentCompletionBlock)jumperrorblock;

/** 可自定义动画
 */
-(void)TTPresentCustomViewController:(id)VcName animated:(BOOL)animated frame:(CGRect)rect hudColor:(UIColor *)color whenDisplay:(whenDisplay)whenDisplayBlock whenDismiss:(whenDismiss)whenDismissBlock SetupParms:(NVWillPushBlock)block completion: (TTWillPresentCompletionBlock)completion callback:(TTRouterCallBackBlock)callbackblock jumpError:(TTWillPresentCompletionBlock)jumperrorblock;



@end

@interface UINavigationController (TTRouter)

/** push   出控制器 带回调
 被push的控制器调用
 self.callbackblock(你需要回传的参数);
 */
-(void)TTPushViewController:(id)VcName animated:(BOOL)animated SetupParms:(NVWillPushBlock)block callback:(TTRouterCallBackBlock)callbackblock jumpError:(TTWillPresentCompletionBlock)jumperrorblock;

@end

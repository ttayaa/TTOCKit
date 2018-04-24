//
//  UIViewController+CustomPopVc.h
//  bssc
//
//  Created by apple on 2017/3/17.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ModalAnimator_downMenuAnimation_black.h"
#import "ModalAnimator_downMenuAnimation_clear.h"
#import "ModalAnimator_downToUpAnimation.h"
#import "ModalAnimator_midAnimation.h"
#import "ModalAnimator_suchAsModalAnimation_black.h"
#import "ModalAnimator_midSpringPopAnimation_black.h"

#import "ModalAnimator_Custom.h"

typedef NS_ENUM(NSInteger, TTPresentStyle) {
    
 
    TTPresentStyleDownMenu_blackhud=0,
    
    TTPresentStyleDownMenu_clearhud,
    
    TTPresentStyleDownToUp_blackhud,
    
    TTPresentStyleMid_blackhud,
    
    TTPresentStylemidSpringPop_blackhud,
    
    TTPresentStyleCustomModal_blackhud,

};


@interface UIViewController (CustomPopVc)





/**
 freme : 显示弹出Controller的位置
 
 */
-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag frame:(CGRect)rect style:(TTPresentStyle)style completion:(void (^)(void))completion;


-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag frame:(CGRect)rect  hudColor:(UIColor *)color whenDisplay:(whenDisplay)whenDisplayBlock whenDismiss:(whenDismiss)whenDismissBlock completion:(void (^)(void))completion;


@end

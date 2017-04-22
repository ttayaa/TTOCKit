//
//  UIViewController+CustomPopVc.m
//  bssc
//
//  Created by apple on 2017/3/17.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "UIViewController+CustomPopVc.h"
#import <objc/runtime.h>


@implementation UIViewController (CustomPopVc)


-(ModalAnimator_Custom *)Animater{
    return objc_getAssociatedObject(self, @selector(Animater));
}
-(void)setAnimater:(ModalAnimator_Custom *)Animater{
    objc_setAssociatedObject(self, @selector(Animater), Animater, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}




-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag frame:(CGRect)rect style:(TTPresentStyle)style completion:(void (^)(void))completion
{
//    ModalAnimator_Custom  *animater;
    

    switch (style) {
        case TTPresentStyleDownMenu_blackhud:
            self.Animater = (ModalAnimator_Custom  *)[ModalAnimator_downMenuAnimation_black new];
            break;
        case TTPresentStyleDownMenu_clearhud:
            self.Animater = (ModalAnimator_Custom  *)[ModalAnimator_downMenuAnimation_clear new];
            break;
        case TTPresentStyleDownToUp_blackhud:
            self.Animater = (ModalAnimator_Custom  *)[ModalAnimator_downToUpAnimation new];
            break;
        case TTPresentStyleMid_blackhud:
            self.Animater = (ModalAnimator_Custom  *)[ModalAnimator_midAnimation new];
            break;
        case TTPresentStylemidSpringPop_blackhud:
            self.Animater = (ModalAnimator_Custom  *)[ModalAnimator_midSpringPopAnimation_black new];
            break;
        case TTPresentStyleCustomModal_blackhud:
            self.Animater = (ModalAnimator_Custom  *)[ModalAnimator_suchAsModalAnimation_black new];
            break;
        default:
            break;
    }
    
    
    viewControllerToPresent.transitioningDelegate = self.Animater;
    self.Animater.presentFrame = rect;
    
    
    
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:viewControllerToPresent animated:YES completion:completion];
    
    
}




-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag frame:(CGRect)rect  hudColor:(UIColor *)color whenDisplay:(whenDisplay)whenDisplayBlock whenDismiss:(whenDismiss)whenDismissBlock completion:(void (^)(void))completion
{
    self.Animater = [ModalAnimator_Custom ModalAnimaterPresentFram:rect hudColor:color whenDisplay:^(UIView *toView, id<UIViewControllerContextTransitioning> transitionContext) {
        whenDisplayBlock(toView,transitionContext);
        
    } whenDismiss:^(UIView *FromView, id<UIViewControllerContextTransitioning> transitionContext) {
        whenDismissBlock(FromView,transitionContext);
    }];
    
    viewControllerToPresent.transitioningDelegate = self.Animater;
    self.Animater.presentFrame = rect;
    self.Animater.hudColor = color;

    viewControllerToPresent.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:viewControllerToPresent animated:YES completion:completion];
}
@end

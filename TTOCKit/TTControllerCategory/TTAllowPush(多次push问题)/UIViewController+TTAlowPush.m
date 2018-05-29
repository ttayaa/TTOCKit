//
//  UIViewController+TTAlowPush.m
//  TTOCKitDemo
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import "UIViewController+TTAlowPush.h"
#import <objc/runtime.h>
@implementation UIViewController (TTAlowPush)
@dynamic TTisCanMutablePush;
-(BOOL)TTisCanMutablePush
{
    return [objc_getAssociatedObject(self, @selector(TTisCanMutablePush)) boolValue] ;
}

-(void)setTTisCanMutablePush:(BOOL)TTisCanMutablePush
{
    objc_setAssociatedObject(self, @selector(TTisCanMutablePush), @(TTisCanMutablePush), OBJC_ASSOCIATION_RETAIN);
}
@end


@implementation UINavigationController (TTAlowPush)
+(void)load
{
    Method pushViewController = class_getInstanceMethod(self, @selector(pushViewController:animated:));
    Method ExtpushViewController = class_getInstanceMethod(self,@selector(pushViewController_TTAlowPush:animated:));
    if (  class_addMethod(self, @selector(pushViewController:animated:), method_getImplementation(ExtpushViewController), method_getTypeEncoding(ExtpushViewController))    ) {
        class_replaceMethod(self, @selector(pushViewController_TTAlowPush:animated:),method_getImplementation(pushViewController),  method_getTypeEncoding(pushViewController));
    }else{
        method_exchangeImplementations(pushViewController, ExtpushViewController);
    }
}

- (void)pushViewController_TTAlowPush:(UIViewController *)viewController animated:(BOOL)animated
{
    if(viewController.TTisCanMutablePush)
    {
        [self pushViewController_TTAlowPush:viewController animated:animated];
    }
    else//如果是默认的不能多条push
    {
        if([NSStringFromClass(self.childViewControllers.lastObject.class) isEqualToString: NSStringFromClass(viewController.class)]) {
            
            
        }else{//如果push的是不同名的那么直接给push
             [self pushViewController_TTAlowPush:viewController animated:animated];
        }
    }
    

}
@end

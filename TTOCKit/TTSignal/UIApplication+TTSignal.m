//
//  UIWindow+TTSignal.m
//  attgod
//
//  Created by apple on 2019/1/24.
//  Copyright © 2019 apple. All rights reserved.
//

#import "UIApplication+TTSignal.h"
#import "UIView+TTSignal.h"
#import <objc/runtime.h>
@implementation UIApplication (TTSignal)
+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL safeSel=@selector(sendEvent:);
        SEL unsafeSel=@selector(TTSignal_sendEvent:);
        Class myClass = [self class];
        Method safeMethod=class_getInstanceMethod (myClass, safeSel);
        Method unsafeMethod=class_getInstanceMethod (myClass, unsafeSel);
        method_exchangeImplementations(unsafeMethod, safeMethod);
        
    });
 
    
}
- (void)TTSignal_sendEvent:(UIEvent *)event
{
    NSSet *set= event.allTouches;
    NSArray *array=[set allObjects];
    UITouch *touchEvent= [array lastObject];
    UIView *view=[touchEvent view];
    
 
    //UISwitch很特殊如果按下超过0.1秒在UITouchPhaseEnded中就不存在view,我们只能截取UITouchPhaseBegan
    if (touchEvent.phase==UITouchPhaseBegan){
        if ([NSStringFromClass([view.superview class]) containsString:@"UISwitch"]) {//如果是UISwitch的子类
            
            if (!(view.superview.superview.userInteractionEnabled == NO || view.superview.superview.hidden == YES || view.superview.superview.alpha <= 0.01 )
                ){
               
                UIView *fitview = [self findFitView:view.superview.superview];
                
                if(fitview)
                {
                    
                    [fitview performSelector:@selector(TTtouchesEnded: withEvent:) withObject:set withObject:event];
                }
                
            }
            
        }
    }
    
    
    if (touchEvent.phase==UITouchPhaseEnded) {
        
        UIView *fitview = [self findFitView:view];
        
        if(fitview)
        {
            
             [fitview performSelector:@selector(TTtouchesEnded: withEvent:) withObject:set withObject:event];
        }
    }
    
    [self TTSignal_sendEvent:event];

    
}

-(UIView *)findFitView:(UIView *)view
{
    
    view.clickSignalName = [view performSelector:@selector(dymaicSignalName)];
    
    if (view.clickSignalName.length>0) {
        
        return view;
    }
    else{
        UIView *nextResponder = (UIView *)view.nextResponder;
        if ([nextResponder isKindOfClass:[UIView class]]) {
          return [self findFitView:nextResponder];
        }
        
    }
    return nil;
}


@end

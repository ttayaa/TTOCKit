//
//  UIControl+stopContinuousClick.m
//  fscar
//
//  Created by apple on 2016/11/29.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import "UIControl+stopContinuousClick.h"
#import <objc/runtime.h>


@implementation UIControl (stopContinuousClick)


- (NSTimeInterval)RecordEventTime{
    return [objc_getAssociatedObject(self, @selector(RecordEventTime)) doubleValue];
}
- (void)setRecordEventTime:(NSTimeInterval)RecordEventTime{
     objc_setAssociatedObject(self, @selector(RecordEventTime), @(RecordEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(NSTimeInterval)UIControlAcceptEventDelayTime
{
      return [objc_getAssociatedObject(self, @selector(UIControlAcceptEventDelayTime)) doubleValue];
}
-(void)setUIControlAcceptEventDelayTime:(NSTimeInterval)UIControlAcceptEventDelayTime
{
     objc_setAssociatedObject(self, @selector(UIControlAcceptEventDelayTime), @(UIControlAcceptEventDelayTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


+ (void)load{
    
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    Method systemMethod = class_getInstanceMethod(self, sysSEL);
    SEL mySEL = @selector(ext_sendAction:to:forEvent:);
    Method myMethod = class_getInstanceMethod(self, mySEL);
    
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(myMethod), method_getTypeEncoding(myMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self, mySEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, myMethod);
    }
}



- (void)ext_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (NSDate.date.timeIntervalSince1970 - self.RecordEventTime < self.UIControlAcceptEventDelayTime) {     
        return;
    }
    else
    {
        //记录事件发生的时间
        self.RecordEventTime = NSDate.date.timeIntervalSince1970;
         [self ext_sendAction:action to:target forEvent:event];
    }
}
@end

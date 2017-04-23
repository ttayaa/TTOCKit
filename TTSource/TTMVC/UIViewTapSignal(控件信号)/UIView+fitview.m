//
//  UIWindow+GlobalSignal.m
//  elmsc
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#import "UIView+fitview.h"
#import "TTClassInfo.h"
#import "UIView+Signal.h"

@implementation UIView (fitview)





- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    //    // 0.返回全局的点坐标
    //    if(self == [UIApplication sharedApplication].keyWindow)
    //    {
    ////        ttLog(@"%@",NSStringFromCGPoint(point));
    //        //全局手印
    //       UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(point.x-25, point.y-25, 50, 50)];
    //        view.image = [UIImage imageNamed:@"fingerprint"];
    //        view.alpha = 0.1;
    //
    ////        view.backgroundColor = TTrandomColor;
    //        [self addSubview:view];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            [view removeFromSuperview];
    //        });
    //
    //    }
    
    
    
    // 1.判断当前控件能否接收事件
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01)
        return nil;
    
    // 2. 判断点在不在当前控件,(UIView类提供的方法)
    if ([self pointInside:point withEvent:event] == NO)
        return nil;
    
    // 3.从后往前遍历自己的子控件
    NSInteger count = self.subviews.count;
    
    
    
    
    
    for (NSInteger i = count - 1; i >= 0; i--) {
        UIView *childView = self.subviews[i];
        
        // 把当前控件上的坐标系转换成子控件上的坐标系
        //   (因为他的子控件的子控件是相对这个坐标判断,点在不在自己的身上)
        CGPoint childP = [self convertPoint:point toView:childView];
        
        // 查找子控件的子控件是否合适.有合适就返回
        UIView *fitView = [childView hitTest:childP withEvent:event];
        
        
        
        // 如果找到合适的就返回,没有就不返回
        if (fitView) { // 寻找到最合适的view
            
            if ([fitView isKindOfClass:[UIControl class]]) {
                if (!fitView.clickSignalName) {
                    //                    fitView
                    NSString *str = [self getfitUIControlVarName:fitView next:fitView];
                    
                    if (str) {
                        fitView.clickSignalName = str;
                        fitUIControlSignalName = nil;
                    }
                }
                
            }
            
            return fitView;
        }
    }
    
    
    // 循环结束,表示没有比自己更合适的view
    return self;
}

static NSString * fitUIControlSignalName;

-(NSString *)getfitUIControlVarName:(UIView *)fitView next:(UIView *)view
{
    UIResponder *next = [view nextResponder];
    
    
    TTClassInfo *clsinfo = [TTClassInfo classInfoWithClass:[next class]];
    
    
    [clsinfo.propertyInfos enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, TTClassPropertyInfo * _Nonnull obj, BOOL * _Nonnull stop) {
        
        
        _Pragma("clang diagnostic push")
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
        
        if ((obj.type & TTEncodingTypeMask)==TTEncodingTypeObject) {
            
            if ([obj.cls isSubclassOfClass:[UIControl class]]) {
                
                if (fitView == [next performSelector:obj.getter]) {
                    
                    fitUIControlSignalName = obj.name ;
                }
            }
        }
        
        
        
        _Pragma("clang diagnostic pop")
        
    }];
    
    if ([(UIWindow *)next isKindOfClass:[UIWindow class]]||[(UIViewController *)next isKindOfClass:[UIViewController class]]) {
        return nil;
    }
    
    if (!fitUIControlSignalName) {
        [self getfitUIControlVarName:fitView next:(UIView *)next];
    }
    
    
    return fitUIControlSignalName;
    
}

@end

//
//  UIViewController+TTGetVar.m
//  bssc
//
//  Created by apple on 2017/3/23.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "UIViewController+TTGetVar.h"
#import "TTClassInfo.h"
#import "NSObject+getVarName.h"


@implementation UIViewController (TTGetVar)


-(UIView *)findViewProperty:(UIView *)view propertyName:(SEL)propertyNameSEL
{
    
    UIResponder *next = [view nextResponder];
    
    
//    NSSelectorFromString(propertyName)
    if (! [next respondsToSelector:propertyNameSEL]) {
        
        return [self findViewProperty:(UIView *)next propertyName:propertyNameSEL];
    }

    return (UIView *)next;
    
    
    
}




-(UIView *)findWritePropertyClass:(UIView*)view respond:(UIResponder *)respond
{

        NSString *tempStr1 = [[respond nameWithInstance:view] substringFromIndex:1];

        if (tempStr1==nil) {

           return [self findWritePropertyClass:view respond:[respond nextResponder]];

        }

        return (UIView *)respond;
}


@end

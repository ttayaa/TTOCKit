//
//  UIViewController+TTGetVar.h
//  bssc
//
//  Created by apple on 2017/3/23.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TTGetVar)


#define TTAutoView(name,className) className * name;\
\
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wundeclared-selector\"") \
name = [[self findViewProperty:signal.view propertyName:@selector(name)] performSelector:@selector(name)];\
\
_Pragma("clang diagnostic pop") \


-(UIView *)findViewProperty:(UIView *)view propertyName:(SEL)propertyNameSEL;


@end

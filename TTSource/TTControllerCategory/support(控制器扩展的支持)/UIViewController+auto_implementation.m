//
//  UIViewController+auto_implementation.m
//  fscar
//
//  Created by apple on 2016/11/1.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import "UIViewController+auto_implementation.h"

@implementation UIViewController (auto_implementation)
//-Wunused-const-variable
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-const-variable"
#pragma clang diagnostic ignored "-Wunused-variable"
static BOOL IS_IMPLEMENT_viewDidLoad;
static BOOL IS_IMPLEMENT_viewWillAppear;
static BOOL IS_IMPLEMENT_viewDidAppear;
static BOOL IS_IMPLEMENT_viewWillLayoutSubviews;
static BOOL IS_IMPLEMENT_viewDidLayoutSubviews;
static BOOL IS_IMPLEMENT_viewWillDisappear;
static BOOL IS_IMPLEMENT_viewDidDisappear;
#pragma clang diagnostic pop


+(void)load
{
    UIViewController *vc =  [self new];
    if ([vc respondsToSelector:@selector(viewDidLoad)]) {
        IS_IMPLEMENT_viewDidLayoutSubviews = YES;
    }
    if ([vc respondsToSelector:@selector(viewWillAppear:)]) {
        IS_IMPLEMENT_viewDidLayoutSubviews = YES;
    }
    if ([vc respondsToSelector:@selector(viewDidAppear:)]) {
        IS_IMPLEMENT_viewDidLayoutSubviews = YES;
    }
    if ([vc respondsToSelector:@selector(viewWillLayoutSubviews)]) {
        IS_IMPLEMENT_viewDidLayoutSubviews = YES;
    }
    if ([vc respondsToSelector:@selector(viewDidLayoutSubviews)]) {
        IS_IMPLEMENT_viewDidLayoutSubviews = YES;
    }
    if ([vc respondsToSelector:@selector(viewWillDisappear:)]) {
        IS_IMPLEMENT_viewDidLayoutSubviews = YES;
    }
    if ([vc respondsToSelector:@selector(viewDidDisappear:)]) {
        IS_IMPLEMENT_viewDidLayoutSubviews = YES;
    }
    
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

//#define method(name) IS_IMPLEMENT_##name

//#if method(name)

#if IS_IMPLEMENT_viewDidLoad

#else

-(void)viewDidLoad
{
    //    ttLog(@"%@---没有实现viewDidLoad",NSStringFromClass([self class]));
}

#endif

#if IS_IMPLEMENT_viewWillAppear
#else
-(void)viewWillAppear:(BOOL)animated
{
    //    ttLog(@"%@---没有实现viewWillAppear",NSStringFromClass([self class]));
}
#endif
#if IS_IMPLEMENT_viewDidAppear
#else
-(void)viewDidAppear:(BOOL)animated
{
    //    ttLog(@"%@---没有实现viewDidAppear",NSStringFromClass([self class]));
}
#endif
#if IS_IMPLEMENT_viewWillLayoutSubviews
#else
-(void)viewWillLayoutSubviews
{
    //    ttLog(@"%@---没有实现viewWillLayoutSubviews",NSStringFromClass([self class]));
}
#endif
#if IS_IMPLEMENT_viewDidLayoutSubviews
#else
-(void)viewDidLayoutSubviews
{
    //    ttLog(@"%@---没有实现viewDidLayoutSubviews",NSStringFromClass([self class]));
}
#endif
#if IS_IMPLEMENT_viewWillDisappear
#else
-(void)viewWillDisappear:(BOOL)animated
{
    //    ttLog(@"%@---没有实现viewWillDisappear",NSStringFromClass([self class]));
}
#endif
#if IS_IMPLEMENT_viewDidDisappear
#else
-(void)viewDidDisappear:(BOOL)animated
{
    //    ttLog(@"%@---没有实现viewDidDisappear",NSStringFromClass([self class]));
}
#endif

#pragma clang diagnostic pop


@end

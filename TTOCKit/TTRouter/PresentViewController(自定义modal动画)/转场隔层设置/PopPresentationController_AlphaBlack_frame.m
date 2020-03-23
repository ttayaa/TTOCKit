//
//  PopPresentationController_AlphaBlack_frame.m
//  ttayaa微博部署
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import "PopPresentationController_AlphaBlack_frame.h"

#define hScreenBounds [UIScreen mainScreen].bounds
#define RGBA32Color(r, g, b, a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:(a)*1.0]

@implementation PopPresentationController_AlphaBlack_frame

/**
 *  这个方法必须要重写,是一个初始化的方法
    (哈哈感觉有点多余)
 用于创建负责转场动画的对象
 *
 *  @param presentedViewController  被展现的控制器(也就是MidDownMenuController)
 *  @param presentingViewController 发起的控制器(也就是进行modal的控制器)
 *
 *
 *  @return 负责转场动画的对象
 */
-(instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
   return  [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
}

//ViewController都有一个containerView层,view是添加在这个层上面的
//这个方法可以布局 将要转场到的控制器view(self.presentedView)的frame
-(void)containerViewWillLayoutSubviews
{
    //self.containerView 是容器的视图
    //self.presentedView 被展示的控制器的view
    
    //1,设置被展示的控制器的view的frame
    //注意比较结构体的做法 CGRect(默认不设置值则为0 0 0 0)
    if (CGRectEqualToRect(self.presentFrame, CGRectZero) ) {
        self.presentedView.frame =CGRectMake(0, 0, 200, 200);
    }
    else
    {
       self.presentedView.frame =self.presentFrame;
    }

    //2,设置一个蒙版 让用户知道后面是不能点击的
    //虽然已经有了self.containerView,但是我们不要直接操作(私有API),而是创建一个view
     if (self.containerView.subviews.firstObject.tag!=111) {
         
         UIView * HUDview = [UIView new];
         HUDview.frame = hScreenBounds;
         HUDview.backgroundColor = RGBA32Color(22, 22, 22, 0.5);
         
         
         [self.containerView insertSubview:HUDview atIndex:0];
         UIGestureRecognizer *TapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HUDClick)];
         [HUDview addGestureRecognizer:TapGes];
     }
    
}
#define TTRouterAlphaBlackHudViewClick @"TTRouterAlphaBlackHudViewClick"

-(void)HUDClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TTRouterAlphaBlackHudViewClick object:nil userInfo:nil];

    //在这个控制器中可以拿到presentedViewController和presentingViewController
    //dismiss控制器
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

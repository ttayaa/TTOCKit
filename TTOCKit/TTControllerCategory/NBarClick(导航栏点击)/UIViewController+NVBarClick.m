//
//  UIViewController+NVBarClick.m
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 RecruitTreasure. All rights reserved.
//

#import "UIViewController+NVBarClick.h"
#import <objc/runtime.h>


@implementation UIViewController (NVBarClick)

@dynamic TTbackNumb;
-(NSInteger)TTbackNumb
{
    return [objc_getAssociatedObject(self, @selector(TTbackNumb)) integerValue];
}

-(void)setTTbackNumb:(NSInteger)TTbackNumb
{
    objc_setAssociatedObject(self, @selector(TTbackNumb), @(TTbackNumb), OBJC_ASSOCIATION_RETAIN);
}


/**
 *  设置左侧文字形式的BarItem
 */
- (void)TTLeftBarTitle:(NSString*)string textColor:(UIColor*)color
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    /**
     *  设置frame只能控制按钮的大小
     */
    
    btn.frame= CGRectMake(0, 0, 100, 44);
    if (@available(iOS 11.0, *))
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    
    if (color) {
        
        [btn setTitleColor:color forState:UIControlStateNormal];
        
    }
    else
    {
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [btn setTitle:string  forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 17.0];
    [btn addTarget:self action:@selector(tt_leftBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -20+10;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];
    
    
}


/**
 *  设置左侧图片形式的BarItem
 */
- (void)TTLeftBarImage:(NSString *)imageName
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    /**
     *  设置frame只能控制按钮的大小
     */
    btn.frame= CGRectMake(0, 0, 40, 44);
    if (@available(iOS 11.0, *))
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tt_leftBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -25+10;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];
}
/**
 *  设置右侧文字形式的BarItem
 */
- (void)TTRightBarTitle:(NSString*)string textColor:(UIColor*)color
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    /**
     *  设置frame只能控制按钮的大小
     */
    btn.frame= CGRectMake(0, 0, 100, 44);
    
    if (@available(iOS 11.0, *))
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    else
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    
    if (color) {
        
        [btn setTitleColor:color forState:UIControlStateNormal];
        
    }
    else
    {
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [btn setTitle:string  forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 17.0];
    [btn addTarget:self action:@selector(tt_rightBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -20+10;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];
}
/**
 *  设置右侧图片形式的BarItem
 */
- (void)TTRightBarImage:(NSString *)imageName
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    /**
     *  设置frame只能控制按钮的大小
     */
    btn.frame= CGRectMake(0, 0, 40, 44);
    if (@available(iOS 11.0, *))
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    else
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tt_rightBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -25+10;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];
}



#pragma mark 左右两侧NavBarItem事件相应


//默认返回
//重写则覆盖
- (void)tt_leftBarItemAction:(UIBarButtonItem *)BarButtonItem
{
    if(self.navigationController.viewControllers.count>1)
    {
        [self.view endEditing:YES];
        
        //跳回上两个 界面
        int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
        
        //如果没有设置这个属性那么就返回一次
        if (self.TTbackNumb==0) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else//pop回dy_backNumb次数
        {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index - self.TTbackNumb)] animated:YES];
        }
        
        
    }else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
//需重写
- (void)tt_rightBarItemAction:(UIBarButtonItem *)BarButtonItem
{
    
}

- (void)TTTitle:(NSString *)string textColor:(UIColor*)color isShimmering:(BOOL)isShimmering
{
    
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.font = [UIFont boldSystemFontOfSize:18];
    lb.backgroundColor = [UIColor clearColor];
    
    lb.text = string;
    
    if (color) {
        lb.textColor =color;
    }
    else
    {
        lb.textColor = [UIColor colorWithRed:255/255.0 green:194/255.0 blue:1/255.0 alpha:1];
    }
    
    self.navigationItem.titleView = lb;
    
    if (isShimmering) {
        FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        shimmeringView.shimmering = YES;
        shimmeringView.shimmeringOpacity = 0.2;
        shimmeringView.shimmeringBeginFadeDuration = 0.5;
        shimmeringView.shimmeringSpeed = 200;
        shimmeringView.shimmeringAnimationOpacity = 1.0;
        [self.view addSubview:shimmeringView];
        
        
        shimmeringView.contentView = lb;
        
        // Start shimmering.
        shimmeringView.shimmering = YES;
    }
    
    
}

@end

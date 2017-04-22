//
//  UIViewController+AlphaBar.m
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 RecruitTreasure. All rights reserved.
//

#import "UIViewController+AlphaBar.h"
#import "TTControllerCategoryHeader.h"


@interface UIViewController (AlphaBar_ext)
/** 开启半透明,枚举默认是0*/
@property (assign, nonatomic) TTAlphaNaviBarStyle dy_BarStyle;
@property (strong, nonatomic) UIColor *dy_BarBGColor;

@property (strong, nonatomic) UIScrollView *dy_bindScroll;
@end
@implementation UIViewController (AlphaBar_ext)
@dynamic dy_BarStyle;
@dynamic dy_BarBGColor;
@dynamic dy_bindScroll;
@end



@implementation UIViewController (AlphaBar)

ControllerCategoryOverride(TTAlphaNaviBar)

//+(void)LOADEXT
//{
//    
//    Method scrollViewDidScroll = class_getInstanceMethod(self, @selector(scrollViewDidScroll:));
//    Method AlphaBar_scrollViewDidScroll = class_getInstanceMethod(self, @selector(AlphaBar_scrollViewDidScroll:));
//    
//    method_exchangeImplementations(scrollViewDidScroll, AlphaBar_scrollViewDidScroll);
//    
//}

- (void)TTNVAlphaBar:(TTAlphaNaviBarStyle)style BarColor:(UIColor *)color
{
    
    self.dy_BarStyle = style;
    self.dy_BarBGColor = color;
    

    if(self.dy_BarStyle==TTAlphaNaviBarStyle1)
    {
        self.automaticallyAdjustsScrollViewInsets     = NO;//保证从0
        self.bgScrollview.delegate = self;
        
        
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar tt_setBackgroundColor:[UIColor clearColor]];
    }
    
    if(self.dy_BarStyle==TTAlphaNaviBarStyle2)
    {
        self.automaticallyAdjustsScrollViewInsets     = NO;//保证从0
        self.bgScrollview.delegate = self;
        
        
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar tt_setBackgroundColor:[UIColor clearColor]];
    }
    
    
    weakify(self)
    [self WhenViewWillDisappear_offen:^(id args) {
        normalize(self)
        if(style>0)
        {
            [self.navigationController.navigationBar tt_reset];
        }
    }];
}

- (void)TTNVDefaultBarWithImg:(UIImage *)img
{
    self.automaticallyAdjustsScrollViewInsets     = YES;
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    
    
}

- (void)TTNVDefaultBarWithColor:(UIColor *)color
{
    
   UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.navigationController.navigationBar.bounds), CGRectGetHeight(self.navigationController.navigationBar.bounds) + 20)];
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setOverlay:)]) {
        
        [self.navigationController.navigationBar performSelector:@selector(setOverlay:) withObject:view];
    }
    
    
    view.userInteractionEnabled = NO;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight`
    [[self.navigationController.navigationBar.subviews firstObject] insertSubview:view atIndex:0];
        self.automaticallyAdjustsScrollViewInsets     = YES;
    view.backgroundColor = color;
    

}


- (void)TTNVAlphaBar:(TTAlphaNaviBarStyle)style BarColor:(UIColor *)color bindScrollView:(UIScrollView *)scroll
{
    
    self.dy_BarStyle = style;
    self.dy_BarBGColor = color;
    
    
    if(self.dy_BarStyle==TTAlphaNaviBarStyle1)
    {
        self.automaticallyAdjustsScrollViewInsets     = NO;//保证从0
        scroll.delegate = self;
        
        
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar tt_setBackgroundColor:[UIColor clearColor]];
    }
    
    if(self.dy_BarStyle==TTAlphaNaviBarStyle2)
    {
        self.automaticallyAdjustsScrollViewInsets     = NO;//保证从0
        scroll.delegate = self;
        self.dy_bindScroll = scroll;
        
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar tt_setBackgroundColor:[UIColor clearColor]];
    }
    
    
    weakify(self)
    [self WhenViewWillDisappear_offen:^(id args) {
                normalize(self)
        if(style>0)
        {
            [self.navigationController.navigationBar tt_reset];
        }
    }];
}




- (void)AlphaBar_scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if ([self.view isKindOfClass:[UIScrollView class]]) {
        [self initScroll:scrollView];
    }
    
    [self AlphaBar_scrollViewDidScroll:scrollView];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [self TTAlphaNaviBar_scrollViewDidScroll:scrollView];
    
    
    if(self.dy_BarStyle==TTAlphaNaviBarStyle2)
    {

        if ([self.view isKindOfClass:[UIScrollView class]]||[self isKindOfClass:[UICollectionViewController class]]||[self isKindOfClass:[UITableViewController class]]) {
                [self initScroll:scrollView];
        }
        else if(self.dy_bindScroll)
        {
            [self initScroll:self.dy_bindScroll];
        }
        
    }
    
}


-(void)initScroll:(UIScrollView *)scv
{
    
    if(self.dy_BarStyle==TTAlphaNaviBarStyle2)
    {
        CGFloat offsetY = scv.contentOffset.y;
        CGFloat alpha = 0;
        if (offsetY >= 100) {
            
            alpha=((offsetY-100)/100 <= 1.0 ? (offsetY-100)/100:1);
            
            [self.navigationController.navigationBar tt_setBackgroundColor:[self.dy_BarBGColor colorWithAlphaComponent:alpha]];
            
        }else{
            [self.navigationController.navigationBar tt_setBackgroundColor:[UIColor clearColor]];
        }
        
        if (offsetY>=0) {
            //        self.bgScrollview.backgroundColor =RGBACOLOR(215, 77, 66, 1);
//            scv.backgroundColor = [UIColor whiteColor];
            self.navigationController.navigationBar.hidden = NO;
        }
        if (offsetY<0)
        {
            self.navigationController.navigationBar.hidden = YES;
        }
        
    }
}











//外部重写
- (void)TTAlphaNaviBar_scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

@end

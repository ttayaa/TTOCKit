//
//  UIViewController+ViewIsScrollview.m
//  elmsc
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#import "UIViewController+ViewIsScrollview.h"
#import <objc/runtime.h>


@implementation UIViewController (ViewIsScrollview)



-(UIScrollView *)bgScrollview
{
    return objc_getAssociatedObject(self, @selector(bgScrollview));
}

-(void)setBgScrollview:(UIScrollView *)bgScrollview
{
     objc_setAssociatedObject(self, @selector(bgScrollview), bgScrollview, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)useBgScrollview
{
        UIView *view = self.view;
        self.bgScrollview = [[UIScrollView alloc] initWithFrame:view.bounds];
        self.view = self.bgScrollview;
        [self.bgScrollview addSubview:view];
        self.bgScrollview.bounces = YES;

        self.bgScrollview.contentSize = CGSizeMake(0, [UIScreen mainScreen].bounds.size.height+1);

}


@end

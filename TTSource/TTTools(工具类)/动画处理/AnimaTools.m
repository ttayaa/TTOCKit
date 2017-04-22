//
//  AnimaTools.m
//  ttayaa
//
//  Created by apple on 16/6/18.
//  Copyright © 2016年 ttayaa. All rights reserved.
//


#import "AnimaTools.h"

@implementation AnimaTools

//变大并消失的动画
+(void)AnimchangeBigAndDisAppearAnimaWithUIView:(UIView *)view completion:(completion)completion
{
    // 放大动画
    [UIView animateWithDuration:3 animations:^{
        view.transform = CGAffineTransformMakeScale(3, 3);
//        view.transform = CGAffineTransformMakeRotation(360*3.9);
        view.alpha = 0;
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}

+(void)BigToDefaultAnimaWithUIView:(UIView *)view
{
    [UIView animateWithDuration:0.2 animations:^{
        view.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        view.transform = CGAffineTransformIdentity;
    }];
}


@end

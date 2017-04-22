//
//  UIView+TTTransitions.h
//  TTSource
//
//  Created by apple on 2017/2/9.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBA32Color(r, g, b, a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:(a)*1.0]
#define hScreenBounds [UIScreen mainScreen].bounds
#define hScreenHeight [UIScreen mainScreen].bounds.size.height

@interface UIView (TTTransitions)

@property (nonatomic) CGFloat TTTransitions_left;
@property (nonatomic) CGFloat TTTransitions_top;
@property (nonatomic) CGFloat TTTransitions_right;
@property (nonatomic) CGFloat TTTransitions_bottom;
@property (nonatomic) CGFloat TTTransitions_centerX;
@property (nonatomic) CGFloat TTTransitions_centerY;

@property (nonatomic) CGFloat TTTransitions_width;
@property (nonatomic) CGFloat TTTransitions_height;


@property (nonatomic) CGPoint TTTransitions_origin;
@property (nonatomic) CGSize TTTransitions_size;

@end

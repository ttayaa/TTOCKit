//
//  UIView+TTTransitions.m
//  TTSource
//
//  Created by apple on 2017/2/9.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "UIView+TTTransitions.h"



@implementation UIView (TTTransitions)
- (CGFloat)TTTransitions_left {
    return self.frame.origin.x;
}

- (void)setTTTransitions_left:(CGFloat)TTTransitions_left{
    CGRect frame = self.frame;
    frame.origin.x = TTTransitions_left;
    self.frame = frame;
}

- (CGFloat)TTTransitions_top {
    return self.frame.origin.y;
}

- (void)setTTTransitions_top:(CGFloat)TTTransitions_top {
    CGRect frame = self.frame;
    frame.origin.y = TTTransitions_top;
    self.frame = frame;
}

- (CGFloat)TTTransitions_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setTTTransitions_right:(CGFloat)TTTransitions_right {
    CGRect frame = self.frame;
    frame.origin.x = TTTransitions_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)TTTransitions_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setTTTransitions_bottom:(CGFloat)TTTransitions_bottom {
    CGRect frame = self.frame;
    frame.origin.y = TTTransitions_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)TTTransitions_centerX
{
    return self.TTTransitions_left + self.TTTransitions_width * 0.5;
}

- (void)setTTTransitions_centerX:(CGFloat)TTTransitions_centerX
{
    self.TTTransitions_left = TTTransitions_centerX - self.TTTransitions_width * 0.5;
}

- (CGFloat)TTTransitions_centerY
{
    return self.TTTransitions_top + self.TTTransitions_height * 0.5;
}

- (void)setTTTransitions_centerY:(CGFloat)TTTransitions_centerY
{
    self.TTTransitions_top = TTTransitions_centerY - self.TTTransitions_height * 0.5;
}

- (CGFloat)TTTransitions_width {
    return self.frame.size.width;
}

- (void)setTTTransitions_width:(CGFloat)TTTransitions_width {

    CGRect frame = self.frame;
    frame.size.width = TTTransitions_width;
    self.frame = frame;
}

- (CGFloat)TTTransitions_height {
    return self.frame.size.height;
}

- (void)setTTTransitions_height:(CGFloat)TTTransitions_height {

    CGRect frame = self.frame;
    frame.size.height = TTTransitions_height;

    self.frame = frame;
}

- (CGPoint)TTTransitions_origin {
    return self.frame.origin;
}

- (void)setTTTransitions_origin:(CGPoint)TTTransitions_origin {
    CGRect frame = self.frame;
    frame.origin = TTTransitions_origin;
    self.frame = frame;
}

- (CGSize)TTTransitions_size {
    return self.frame.size;
}

- (void)setTTTransitions_size:(CGSize)TTTransitions_size {
    CGRect frame = self.frame;
    frame.size = TTTransitions_size;
    self.frame = frame;
}

@end

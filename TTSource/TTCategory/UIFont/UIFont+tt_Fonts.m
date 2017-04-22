//
//  UIFont+Fonts.m
//  MACProject
//
//  modify by ttayaa on 15/9/10.
//  Copyright (c) 2015年 ttayaa. All rights reserved.

#import "UIFont+tt_Fonts.h"

@implementation UIFont (tt_Fonts)

#pragma mark - Added font.

+ (UIFont *)tt_HYQiHeiWithFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"HYQiHei-BEJF" size:size];
}

#pragma mark - System font.

+ (UIFont *)tt_AppleSDGothicNeoThinWithFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:size];
}

+ (UIFont *)tt_AvenirWithFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"Avenir" size:size];
}

+ (UIFont *)tt_AvenirLightWithFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"Avenir-Light" size:size];
}

+ (UIFont *)tt_HeitiSCWithFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"Heiti SC" size:size];
}

+ (UIFont *)tt_HelveticaNeueFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+ (UIFont *)tt_HelveticaNeueBoldFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

@end

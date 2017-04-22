//
//  NSAttributedString+textSize.m
//  ttCommerce
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import "NSAttributedString+tt_textSize.h"

@implementation NSAttributedString (tt_textSize)

-(CGFloat)tt_attributedtextHeihgt
{
    CGFloat Margin = 10;
    
    // 文字的最大尺寸
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * Margin, MAXFLOAT);
    
    // 计算文字的高度
    // 通过传入文字的样式,计算出self.text的高度
    //    CGFloat textH = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:defaultFont]} context:nil].size.height;
    
    //
    //    NSStringDrawingUsesLineFragmentOrigin = 1 << 0, // The specified origin is the line fragment origin, not the base line origin
    //    NSStringDrawingUsesFontLeading = 1 << 1, // Uses the font leading for calculating line heights
    //    NSStringDrawingUsesDeviceMetrics = 1 << 3, // Uses image glyph bounds instead of typographic bounds
    //    NSStringDrawingTruncatesLastVisibleLine NS_ENUM_AVAILABLE(10_5, 6_0) = 1 << 5, // Truncates and adds the ellipsis character to the last visible line if the text doesn't fit into the bounds specified. Ignored if NSStringDrawingUsesLineFragmentOrigin is not also set.
    
    // 计算富文本的高度
    CGFloat textH = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesDeviceMetrics context:nil].size.height;
    
    
    
    // cell的高度
    return textH ;
}

-(CGFloat)tt_attributedtextHeihgtWithtextWidth:(CGFloat)textwidth
{
    
    // 文字的最大尺寸
    CGSize maxSize = CGSizeMake(textwidth, MAXFLOAT);
    
    // 计算富文本的高度
    CGFloat textH = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    
    // cell的高度
    return textH ;
}
@end

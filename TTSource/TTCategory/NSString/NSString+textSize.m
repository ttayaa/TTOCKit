//
//  NSString+textSize.m
//  ttCommerce
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import "NSString+textSize.h"

@implementation NSString (textSize)

-(CGFloat)textHeihgtWithdefaultFontSize:(CGFloat)defaultFontSize
{
    CGFloat Margin = 10;
    
    // 文字的最大尺寸
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * Margin, MAXFLOAT);
    
    // 计算文字的高度
    // 通过传入文字的样式,计算出self.text的高度
    CGFloat textH = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:defaultFontSize]} context:nil].size.height;
    
    // cell的高度
    return textH ;
}



- (CGSize)textSizeWithContentSize:(CGSize)size font:(UIFont *)font {
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (CGFloat)textHeightWithContentWidth:(CGFloat)width font:(UIFont *)font {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    return [self textSizeWithContentSize:size font:font].height;
}

- (CGFloat)textWidthWithContentHeight:(CGFloat)height font:(UIFont *)font {
    CGSize size = CGSizeMake(MAXFLOAT, height);
    return [self textSizeWithContentSize:size font:font].width;
}

@end

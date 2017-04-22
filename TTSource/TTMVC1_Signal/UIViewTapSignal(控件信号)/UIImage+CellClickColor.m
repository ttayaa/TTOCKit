//
//  UIImage+CellClickColor.m
//  fschat
//
//  Created by apple on 2016/12/12.
//  Copyright © 2016年 丰硕聊天. All rights reserved.
//

#import "UIImage+CellClickColor.h"

@implementation UIImage (CellClickColor)

#pragma mark -
#pragma mark - 以 color 为背景，做一张 image

+ (UIImage *)TT_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 3, 3);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    image = [image stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    
    return image;
}

@end

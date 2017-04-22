//
//  UIImage+processing.m
//  动态背景图
//
//  Created by funeral on 15/9/22.
//  Copyright (c) 2015年 funeral. All rights reserved.
//

#import "UIImage+processing.h"

@implementation UIImage (processing)

#pragma mark - 类方法

/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param imageName 图片名字
 */
+ (instancetype)resizableImageNamed:(NSString *)imageName {
    UIImage *normal = [UIImage imageNamed:imageName];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    return [normal stretchableImageWithLeftCapWidth:w topCapHeight:h];
    // return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

/**
 *  @brief 关闭图片的自动渲染
 *  @param imageName 图片的名字
 *  @return 返回一张默认不渲染的图片(用于添加到navigation上面去)
 */
+ (instancetype)originRenderingImageNamed:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 *  @brief  根据当前传入的imageNamed加载一张图片并且进行裁剪
 *  @param name 图片名称
 *  @return UIImage实例
 */
+ (instancetype)circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] circleImage];
}

/**
 *  @brief  把当前的image裁剪生成一个圆形的image 并且带有边框
 *  @param edgingWidth 边框的宽度
 *  @param edgingColor 边框的颜色
 *  @return UIImage实例
 */
+ (instancetype)circleImageWithImageNamed:(NSString *)name edgingWidth:(CGFloat)edgingWidth color:(UIColor*)edgingColor {
    return [[UIImage imageNamed:name] circleImageWithEdgingWidth:edgingWidth color:edgingColor];
}

/**
 *  @brief  生成带有边框的image实例
 *  @param edgingWidth 边框的宽度
 *  @param edgingColor 边框的颜色
 *  @return UIImage实例
 */
+ (instancetype)imageWithEdgingImageNamed:(NSString *)name width:(CGFloat)edgingWidth color:(UIColor*)edgingColor {
    return [[UIImage imageNamed:name] imageWithEdgingWidth:edgingWidth color:edgingColor];
}

/**
 *  @brief  生成带有边框/圆角的image
 *  @param edgingWidth 边框的宽度
 *  @param edgingColor 边框的颜色
 *  @param radiu 圆角半径
 *  @return UIImage实例
 */
+ (instancetype)imageWithEdgingImageNamed:(NSString *)name width:(CGFloat)edgingWidth color:(UIColor*)edgingColor cornerRadius:(CGFloat)radiu {
    return [[UIImage imageNamed:name] imageWithEdgingWidth:edgingWidth color:edgingColor cornerRadius:radiu];
}

#pragma mark - 对象方法

/**
 *  @brief  把当前的image裁剪生成一个圆形的image
 *  @return UIImage实例
 */
- (instancetype)circleImage
{
    return [self circleImageWithEdgingWidth:0 color:[UIColor clearColor]];
}

/**
 *  @brief  把当前的image裁剪生成一个圆形的image 并且带有边框
 *  @return UIImage实例
 */
- (instancetype)circleImageWithEdgingWidth:(CGFloat)edgingWidth color:(UIColor*)edgingColor {
    CGFloat radiu = edgingWidth + self.size.width/2.0;
    return [self imageWithEdgingWidth:edgingWidth color:edgingColor cornerRadius:radiu];
}

/**
 *  @brief  生成带有边框的image实例
 *  @return UIImage实例
 */
- (instancetype)imageWithEdgingWidth:(CGFloat)edgingWidth color:(UIColor*)edgingColor {
    return [self imageWithEdgingWidth:edgingWidth color:edgingColor cornerRadius:0];
}

/**
 *  @brief  生成带有边框/圆角的image
 *  @return UIImage实例
 */
- (instancetype)imageWithEdgingWidth:(CGFloat)edgingWidth color:(UIColor*)edgingColor cornerRadius:(CGFloat)radiu {
    CGSize drawSize = CGSizeMake(self.size.width+2*edgingWidth, self.size.height+2*edgingWidth);
    // 开启图形上下文
    UIGraphicsBeginImageContext(drawSize);
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 矩形框
    CGRect rect = CGRectMake(edgingWidth, edgingWidth, self.size.width, self.size.height);
    
    UIBezierPath *path;
    if (radiu == 0) {
        path = [UIBezierPath bezierPathWithRect:rect];
    }else {
        path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radiu];
    }
    // 绘制边框圆角矩形
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetLineWidth(ctx, edgingWidth);
    [edgingColor setStroke];
    CGContextStrokePath(ctx);
    
    // 绘制裁剪圆角矩形
    CGContextAddPath(ctx, path.CGPath);
    // 裁剪(裁剪成刚才添加的图形形状)
    CGContextClip(ctx);
    // 往圆上面画一张图片
    [self drawInRect:rect];
    // 获得上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end

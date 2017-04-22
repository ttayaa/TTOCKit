//
//  UIColor+Mac.h
//  MacKit
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIColor(tt)
+ (UIColor *)tt_colorWithMacHex:(UInt32)hex;
+ (UIColor *)tt_colorWithMacHex:(UInt32)hex andAlpha:(CGFloat)alpha;
/**
 *   用HexString 生成 UIColor
 *
 *  @param hexString   #RGB  #ARGB   #RRGGBB  #AARRGGBB 或者不带#
 */
+ (UIColor *)tt_colorWithMacHexString:(NSString *)hexString;
/**
 *  当前UIColor用的HexString
 */
- (NSString *)tt_MacHEXString;
/**
 *  当前UIColor用的RGB(255,255,255,1.0) 用纯数字
 */
+ (UIColor *)tt_colorWithMacWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue
                         alpha:(CGFloat)alpha;


/**
 *  @brief  随机颜色
 *
 *  @return UIColor
 */
+ (UIColor *)tt_RandomColor;

/**
 *  @brief  渐变颜色
 *
 *  @param c1     开始颜色
 *  @param c2     结束颜色
 *  @param height 渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)tt_gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;
@end

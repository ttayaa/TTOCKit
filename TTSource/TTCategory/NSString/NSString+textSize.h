//
//  NSString+textSize.h
//  ttCommerce
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (textSize)

/**默认宽度是屏幕宽度 间距左右各是10*/
-(CGFloat)textHeihgtWithdefaultFontSize:(CGFloat)defaultFontSize;


/**根据字数的不同,返回UILabel中的text文字需要占用多少Size*/
- (CGSize)textSizeWithContentSize:(CGSize)size font:(UIFont *)font;

/**根据字体的宽度 求得text的高度*/
- (CGFloat)textHeightWithContentWidth:(CGFloat)width font:(UIFont *)font;

/**根据字体的高度 求得text的宽度 */
- (CGFloat)textWidthWithContentHeight:(CGFloat)height font:(UIFont *)font;

@end

//
//  NSAttributedString+textSize.h
//  ttCommerce
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (tt_textSize)

-(CGFloat)tt_attributedtextHeihgt;

/**传入宽度 计算出富文本高度*/
-(CGFloat)tt_attributedtextHeihgtWithtextWidth:(CGFloat)textwidth;

@end

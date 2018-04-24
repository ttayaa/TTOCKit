//
//  NSString+TTTextField.h
//  TTDemos
//
//  Created by apple on 2017/3/19.
//  Copyright © 2017年 ttayaa. All rights reserved.
//



#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,TTTextFieldStringType) {
    TTTextFieldStringTypeNumber,         //数字
    TTTextFieldStringTypeLetter,         //字母
    TTTextFieldStringTypeChinese         //汉字
};

@interface NSString (TTTextField)

/**
 某个字符串是不是数字、字母、汉字。
 */
-(BOOL)TT_is:(TTTextFieldStringType)stringType;


/**
 字符串是不是特殊字符，此时的特殊字符就是：出数字、字母、汉字以外的。
 */
-(BOOL)TT_isSpecialLetter;

/**
 获取字符串长度 【一个汉字算2个字符串，一个英文算1个字符串】
 */
-(int)TT_getStrLengthWithCh2En1;


/**
 移除字符串中除exceptLetters外的所有特殊字符
 */
-(NSString *)TT_removeSpecialLettersExceptLetters:(NSArray<NSString *> *)exceptLetters;

@end

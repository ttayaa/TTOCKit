//
//  UITextField+BankNumber.h
//  ZhaoCaiHuiBaoRt
//
//  Created by Wzs 王 on 2017/7/27.
//  Copyright © 2017年 ttayaa. All rights reserved.
//UITextField+insertPosition

#import <UIKit/UIKit.h>

@interface UITextField (TTNumberTF)
- (NSRange)selectedRange;

- (void)setSelectedRange:(NSRange)range;

/**
 *  设置空格插入的位置 使用方式
 *  - textField:shouldChangeCharactersInRange:replacementString:
 *  执行如下代码
 *  NSArray *insertPosition = @[@(6), @(10), @(14), @(18)];
 *  [textField insertWhitSpaceInsertPosition:insertPosition replacementString:string textlength:20];
 *  return NO;
 *
 *  @param insertPosition 插入的位置
 *  @param string         插入的字符串
 *  @param length         文本长度
 */
- (void)insertWhitSpaceInsertPosition:(NSArray *)insertPosition replacementString:(NSString *)string textlength:(NSInteger)length;


//根据insertPosition 插入的位置 返回一个 插入空格的字符串
- (NSString *)insertWhitespaceCharacter:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition insertPosition:(NSArray *)insertPosition ;



@end

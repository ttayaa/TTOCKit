//
//  NSString+HLHanZiToPinYin.h
//  HLHanZiToPinYinDemo
//
//  Created by lhl on 15/4/20.
//  Copyright (c) 2015年 LHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (tt_HanZiToPinYin)

- (NSString*)tt_pinYin;


/**
 *  获取拼音首字母
 *
 *  @return 获取拼音首字母
 */
- (NSString*)tt_firstCharactor;

/**
 *  获取汉字拼音，包括判断返回#
 *
 *  @return 获取汉字拼音
 */
- (NSString*)tt_firstPingYin;
@end

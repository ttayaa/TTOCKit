//
//  NSString+RemoveEmoji.h
//  NSString+RemoveEmoji
//
//
//  Created by ttayaa on 14/12/15.
//  Copyright (c) 2014年 ttayaa All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSString (tt_RemoveEmoji)
/**
 *  是否是emoji
 *
 *  @return 
 */
-(BOOL)tt_isEmoji;
/**
 *  @brief  是否包含emoji
 *
 *  @return 是否包含emoji
 */
- (BOOL)tt_isIncludingEmoji;

/**
 *  @brief  删除掉包含的emoji
 *
 *  @return 清除后的string
 */
- (instancetype)tt_removedEmojiString;

@end

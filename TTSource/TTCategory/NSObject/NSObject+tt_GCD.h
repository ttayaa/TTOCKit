//
//  NSObject+GCD.h
//
//
//  Created by ttayaa on 14/12/15.
//  Copyright (c) 2014年 ttayaa All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSObject (tt_GCD)
/**
 *  @brief  异步执行代码块
 *
 *  @param block 代码块
 */
- (void)tt_performAsynchronous:(void(^)(void))block;
/**
 *  @brief  GCD主线程执行代码块
 *
 *  @param block 代码块
 *  @param wait  是否同步请求
 */
- (void)tt_performOnMainThread:(void(^)(void))block wait:(BOOL)wait;

/**
 *  @brief  延迟执行代码块
 *
 *  @param seconds 延迟时间 秒
 *  @param block   代码块
 */
- (void)tt_performAfter:(NSTimeInterval)seconds block:(void(^)(void))block;
@end

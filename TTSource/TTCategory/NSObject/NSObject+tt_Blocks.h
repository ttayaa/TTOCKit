//
//  NSObject+Blocks.h
//  PSFoundation
//
//
//  Created by ttayaa on 14/12/15.
//  Copyright (c) 2014年 ttayaa All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSObject (tt_Blocks)
+ (id)tt_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
+ (id)tt_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
- (id)tt_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (id)tt_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
+ (void)tt_cancelBlock:(id)block;
+ (void)tt_cancelPreviousPerformBlock:(id)aWrappingBlockHandle __attribute__ ((deprecated));

@end

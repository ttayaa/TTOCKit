//
//  NSRunLoop+PerformBlock.m
//  IOS-Categories
//
//  Created by Jakey on 15/8/7.
//  Copyright © 2015年 www.skyfox.org. All rights reserved.
//

#import "NSRunLoop+tt_PerformBlock.h"

NSString *const tt_NSRunloopTimeoutException = @"NSRunloopTimeoutException";

@implementation NSRunLoop (tt_PerformBlock)

- (void)tt_performBlockAndWait:(void (^)(BOOL *))block
{
    [self tt_performBlockAndWait:block timeoutInterval:10.0];
}

- (void)tt_performBlockAndWait:(void (^)(BOOL *))block timeoutInterval:(NSTimeInterval)timeoutInterval
{
    if (!block || timeoutInterval < 0.0) {
        [NSException raise:NSInvalidArgumentException format:@"%lf is invalid for timeout interval", timeoutInterval];
    }
    
    NSDate *startedDate = [NSDate date];
    BOOL finish = NO;
    
    block(&finish);
    
    while (!finish && [[NSDate date] timeIntervalSinceDate:startedDate] < timeoutInterval) {
        @autoreleasepool {
            [self runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.1]];
        }
    }
    
    if (!finish) {
        [NSException raise:tt_NSRunloopTimeoutException format:@"execution of block timed out in performBlockAndWait:."];
    }
}

@end

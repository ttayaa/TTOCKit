//
//  NSException+Trace.h
//
//
//  Created by ttayaa on 14/12/15.
//  Copyright (c) 2014年 ttayaa All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSException (tt_Trace)
//异常追踪
- (NSArray *)tt_backtrace;
@end

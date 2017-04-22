//
//  NSNumber+CGFloat.m
//
//
//  Created by ttayaa on 14/12/15.
//  Copyright (c) 2014年 ttayaa All rights reserved.
//

#import "NSNumber+tt_CGFloat.h"

@implementation NSNumber (tt_CGFloat)

- (CGFloat)tt_CGFloatValue
{
#if (CGFLOAT_IS_DOUBLE == 1)
    CGFloat result = [self doubleValue];
#else
    CGFloat result = [self floatValue];
#endif
    return result;
}

- (id)tt_initWithCGFloat:(CGFloat)value
{
#if (CGFLOAT_IS_DOUBLE == 1)
    return [self initWithDouble:value];
#else
    return [self initWithFloat:value];
#endif
    return self;
}

+ (NSNumber *)tt_numberWithCGFloat:(CGFloat)value
{
    NSNumber *result = [[self alloc] tt_initWithCGFloat:value];
    return result;
}

@end

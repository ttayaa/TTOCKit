//
//  NSArray+ttSafeAccess.m
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/2/16.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "NSArray+ttSafeAccess.h"

@implementation NSArray (ttSafeAccess)
-(id)tt_objectWithIndex:(NSUInteger)index{
    if (index <self.count) {
        return self[index];
    }else{
        return nil;
    }
}

- (NSString*)tt_stringWithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    return nil;
}


- (NSNumber*)tt_numberWithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}

- (NSDecimalNumber *)tt_decimalNumberWithIndex:(NSUInteger)index{
    id value = [self tt_objectWithIndex:index];
    
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber * number = (NSNumber*)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString * str = (NSString*)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}

- (NSArray*)tt_arrayWithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]])
    {
        return value;
    }
    return nil;
}


- (NSDictionary*)tt_dictionaryWithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return value;
    }
    return nil;
}

- (NSInteger)tt_integerWithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value integerValue];
    }
    return 0;
}
- (NSUInteger)tt_unsignedIntegerWithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value unsignedIntegerValue];
    }
    return 0;
}
- (BOOL)tt_boolWithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value boolValue];
    }
    return NO;
}
- (int16_t)tt_int16WithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int32_t)tt_int32WithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int64_t)tt_int64WithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value longLongValue];
    }
    return 0;
}

- (char)tt_charWithIndex:(NSUInteger)index{
    
    id value = [self tt_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value charValue];
    }
    return 0;
}

- (short)tt_shortWithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (float)tt_floatWithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    return 0;
}
- (double)tt_doubleWithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    return 0;
}

- (NSDate *)tt_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = dateFormat;
    id value = [self tt_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}

//CG
- (CGFloat)tt_CGFloatWithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    
    CGFloat f = [value doubleValue];
    
    return f;
}

- (CGPoint)tt_pointWithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    
    CGPoint point = CGPointFromString(value);
    
    return point;
}
- (CGSize)tt_sizeWithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    
    CGSize size = CGSizeFromString(value);
    
    return size;
}
- (CGRect)tt_rectWithIndex:(NSUInteger)index
{
    id value = [self tt_objectWithIndex:index];
    
    CGRect rect = CGRectFromString(value);
    
    return rect;
}
@end


#pragma --mark NSMutableArray setter
@implementation NSMutableArray (SafeAccess)
-(void)tt_addObj:(id)i{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)tt_addString:(NSString*)i
{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)tt_addBool:(BOOL)i
{
    [self addObject:@(i)];
}
-(void)tt_addInt:(int)i
{
    [self addObject:@(i)];
}
-(void)tt_addInteger:(NSInteger)i
{
    [self addObject:@(i)];
}
-(void)tt_addUnsignedInteger:(NSUInteger)i
{
    [self addObject:@(i)];
}
-(void)tt_addCGFloat:(CGFloat)f
{
    [self addObject:@(f)];
}
-(void)tt_addChar:(char)c
{
    [self addObject:@(c)];
}
-(void)tt_addFloat:(float)i
{
    [self addObject:@(i)];
}
-(void)tt_addPoint:(CGPoint)o
{
    [self addObject:NSStringFromCGPoint(o)];
}
-(void)tt_addSize:(CGSize)o
{
    [self addObject:NSStringFromCGSize(o)];
}
-(void)tt_addRect:(CGRect)o
{
    [self addObject:NSStringFromCGRect(o)];
}
@end

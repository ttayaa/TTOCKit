//
//  NSArray+ttSafeAccess.h
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/2/16.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSArray (ttSafeAccess)
-(id)tt_objectWithIndex:(NSUInteger)index;

- (NSString*)tt_stringWithIndex:(NSUInteger)index;

- (NSNumber*)tt_numberWithIndex:(NSUInteger)index;

- (NSDecimalNumber *)tt_decimalNumberWithIndex:(NSUInteger)index;

- (NSArray*)tt_arrayWithIndex:(NSUInteger)index;

- (NSDictionary*)tt_dictionaryWithIndex:(NSUInteger)index;

- (NSInteger)tt_integerWithIndex:(NSUInteger)index;

- (NSUInteger)tt_unsignedIntegerWithIndex:(NSUInteger)index;

- (BOOL)tt_boolWithIndex:(NSUInteger)index;

- (int16_t)tt_int16WithIndex:(NSUInteger)index;

- (int32_t)tt_int32WithIndex:(NSUInteger)index;

- (int64_t)tt_int64WithIndex:(NSUInteger)index;

- (char)tt_charWithIndex:(NSUInteger)index;

- (short)tt_shortWithIndex:(NSUInteger)index;

- (float)tt_floatWithIndex:(NSUInteger)index;

- (double)tt_doubleWithIndex:(NSUInteger)index;

- (NSDate *)tt_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;
//CG
- (CGFloat)tt_CGFloatWithIndex:(NSUInteger)index;

- (CGPoint)tt_pointWithIndex:(NSUInteger)index;

- (CGSize)tt_sizeWithIndex:(NSUInteger)index;

- (CGRect)tt_rectWithIndex:(NSUInteger)index;
@end


#pragma --mark NSMutableArray setter

@interface NSMutableArray(SafeAccess)

-(void)tt_addObj:(id)i;

-(void)tt_addString:(NSString*)i;

-(void)tt_addBool:(BOOL)i;

-(void)tt_addInt:(int)i;

-(void)tt_addInteger:(NSInteger)i;

-(void)tt_addUnsignedInteger:(NSUInteger)i;

-(void)tt_addCGFloat:(CGFloat)f;

-(void)tt_addChar:(char)c;

-(void)tt_addFloat:(float)i;

-(void)tt_addPoint:(CGPoint)o;

-(void)tt_addSize:(CGSize)o;

-(void)tt_addRect:(CGRect)o;
@end

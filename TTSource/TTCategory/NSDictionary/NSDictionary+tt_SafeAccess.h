//
//  NSDictionary+tt_SafeAccess.h
//  tt_Categories (https://github.com/shaojiankui/tt_Categories)
//
//  Created by Jakey on 15/1/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (tt_SafeAccess)
- (BOOL)tt_hasKey:(NSString *)key;

- (NSString*)tt_stringForKey:(id)key;

- (NSNumber*)tt_numberForKey:(id)key;

- (NSDecimalNumber *)tt_decimalNumberForKey:(id)key;

- (NSArray*)tt_arrayForKey:(id)key;

- (NSDictionary*)tt_dictionaryForKey:(id)key;

- (NSInteger)tt_integerForKey:(id)key;

- (NSUInteger)tt_unsignedIntegerForKey:(id)key;

- (BOOL)tt_boolForKey:(id)key;

- (int16_t)tt_int16ForKey:(id)key;

- (int32_t)tt_int32ForKey:(id)key;

- (int64_t)tt_int64ForKey:(id)key;

- (char)tt_charForKey:(id)key;

- (short)tt_shortForKey:(id)key;

- (float)tt_floatForKey:(id)key;

- (double)tt_doubleForKey:(id)key;

- (long long)tt_longLongForKey:(id)key;

- (unsigned long long)tt_unsignedLongLongForKey:(id)key;

- (NSDate *)tt_dateForKey:(id)key dateFormat:(NSString *)dateFormat;

//CG
- (CGFloat)tt_CGFloatForKey:(id)key;

- (CGPoint)tt_pointForKey:(id)key;

- (CGSize)tt_sizeForKey:(id)key;

- (CGRect)tt_rectForKey:(id)key;
@end

#pragma --mark NSMutableDictionary setter

@interface NSMutableDictionary(tt_SafeAccess)

-(void)tt_setObj:(id)i forKey:(NSString*)key;

-(void)tt_setString:(NSString*)i forKey:(NSString*)key;

-(void)tt_setBool:(BOOL)i forKey:(NSString*)key;

-(void)tt_setInt:(int)i forKey:(NSString*)key;

-(void)tt_setInteger:(NSInteger)i forKey:(NSString*)key;

-(void)tt_setUnsignedInteger:(NSUInteger)i forKey:(NSString*)key;

-(void)tt_setCGFloat:(CGFloat)f forKey:(NSString*)key;

-(void)tt_setChar:(char)c forKey:(NSString*)key;

-(void)tt_setFloat:(float)i forKey:(NSString*)key;

-(void)tt_setDouble:(double)i forKey:(NSString*)key;

-(void)tt_setLongLong:(long long)i forKey:(NSString*)key;

-(void)tt_setPoint:(CGPoint)o forKey:(NSString*)key;

-(void)tt_setSize:(CGSize)o forKey:(NSString*)key;

-(void)tt_setRect:(CGRect)o forKey:(NSString*)key;
@end

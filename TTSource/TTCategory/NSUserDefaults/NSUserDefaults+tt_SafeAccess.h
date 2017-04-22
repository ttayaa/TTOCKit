//
//  NSUserDefaults+SafeAccess.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (tt_SafeAccess)
+ (NSString *)tt_stringForKey:(NSString *)defaultName;

+ (NSArray *)tt_arrayForKey:(NSString *)defaultName;

+ (NSDictionary *)tt_dictionaryForKey:(NSString *)defaultName;

+ (NSData *)tt_dataForKey:(NSString *)defaultName;

+ (NSArray *)tt_stringArrayForKey:(NSString *)defaultName;

+ (NSInteger)tt_integerForKey:(NSString *)defaultName;

+ (float)tt_floatForKey:(NSString *)defaultName;

+ (double)tt_doubleForKey:(NSString *)defaultName;

+ (BOOL)tt_boolForKey:(NSString *)defaultName;

+ (NSURL *)tt_URLForKey:(NSString *)defaultName;

#pragma mark - WRITE FOR STANDARD

+ (void)tt_setObject:(id)value forKey:(NSString *)defaultName;

#pragma mark - READ ARCHIVE FOR STANDARD

+ (id)tt_arcObjectForKey:(NSString *)defaultName;

#pragma mark - WRITE ARCHIVE FOR STANDARD

+ (void)tt_setArcObject:(id)value forKey:(NSString *)defaultName;
@end

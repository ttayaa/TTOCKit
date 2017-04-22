//
//  NSDictionary+tt_Block.h
//  tt_Categories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (tt_Block)

#pragma mark - RX
- (void)tt_each:(void (^)(id k, id v))block;
- (void)tt_eachKey:(void (^)(id k))block;
- (void)tt_eachValue:(void (^)(id v))block;
- (NSArray *)tt_map:(id (^)(id key, id value))block;
- (NSDictionary *)tt_pick:(NSArray *)keys;
- (NSDictionary *)tt_omit:(NSArray *)key;

@end

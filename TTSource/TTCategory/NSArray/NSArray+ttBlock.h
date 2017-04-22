//
//  NSArray+ttBlock.h
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/2/16.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ttBlock)
- (void)tt_each:(void (^)(id object))block;
- (void)tt_eachWithIndex:(void (^)(id object, NSUInteger index))block;
- (NSArray *)tt_map:(id (^)(id object))block;
- (NSArray *)tt_filter:(BOOL (^)(id object))block;
- (NSArray *)tt_reject:(BOOL (^)(id object))block;
- (id)tt_detect:(BOOL (^)(id object))block;
- (id)tt_reduce:(id (^)(id accumulator, id object))block;
- (id)tt_reduce:(id)initial withBlock:(id (^)(id accumulator, id object))block;
@end


//
//  NSNumber+CGFloat.h
//
//
//  Created by ttayaa on 14/12/15.
//  Copyright (c) 2014年 ttayaa All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSNumber (tt_CGFloat)

- (CGFloat)tt_CGFloatValue;

- (id)tt_initWithCGFloat:(CGFloat)value;

+ (NSNumber *)tt_numberWithCGFloat:(CGFloat)value;

@end

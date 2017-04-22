//
//  NSData+APNSToken.h
//
//  Created by ttayaa on 14/12/15.
//  Copyright (c) 2014年 ttayaa All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (tt_APNSToken)
/**
 *  @brief  将APNS NSData类型token 格式化成字符串
 *
 *  @return 整理过后的字符串token
 */
- (NSString *)tt_APNSToken;
@end

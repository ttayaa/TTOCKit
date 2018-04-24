//
//  NSDictionary+MAC.h
//  WeiSchoolTeacher
//
//  Created by ttayaa on 15/12/21.
//  Copyright © 2015年 ttayaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(tt)
/**
 *  @brief  将url参数转换成NSDictionary
 *
 *  @param query url参数
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)tt_dictionaryWithURLQuery:(NSString *)query;
/**
 *  @brief  将NSDictionary转换成url 参数字符串
 *
 *  @return url 参数字符串
 */
- (NSString *)tt_urlQueryString;
/**
 *  @brief NSDictionary转换成JSON字符串
 *
 *  @return  JSON字符串
 */
-(NSString *)tt_JSONString;

-(NSString *)tt_JSONStringNoSpace; //去掉中间的空格


/**
 *  @brief  将NSDictionary转换成XML 字符串
 *
 *  @return XML 字符串
 */
- (NSString *)tt_XMLString;
@end

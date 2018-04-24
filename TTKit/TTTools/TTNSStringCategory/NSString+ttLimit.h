//
//  NSString+Validate.h
//  WellRead
//
//  Created by bevis on 15/12/21.
//  Copyright © 2015年 dyage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ttLimit)
/*邮箱*/
- (BOOL)WXX_validateEmail;

/*手机号码验证*/
- (BOOL)WXX_validateMobile;

/*车牌号验证*/
- (BOOL)WXX_validateCarNo;

/*车型*/
- (BOOL)WXX_validateCarType;

/*用户名*/
- (BOOL)WXX_validateUserName;

/*真实姓名*/
- (BOOL)WXX_validateTrueName;

/*密码*/
- (BOOL)WXX_validatePassword;

/*昵称*/
- (BOOL)WXX_validateNickname;

/*身份证号*/
- (BOOL)WXX_validateIdentityCard;

/*取消多余的0*/
- (NSString *)WXX_cancelRedundant_0;

/*字符长度范围*/
- (BOOL)WXX_validateStringMinLength:(NSInteger)minLength maxLength:(NSInteger)maxLength;

/*
 1470758400 --> yyyy-MM-dd
 **/
- (NSString *)WXX_toDateStr;

/*判断字符串是否为纯数字*/
- (BOOL)WXX_isPureNumandCharacters;

/**将下滑线转为驼峰*/
+ (NSString *)WXX_convertToCamelCaseFromSnakeCase:(NSString *)key;
    
    /*判断内容是否全部为空格  yes 全部为空格  no 不是*/
+ (BOOL) WXX_isEmpty:(NSString *) str ;
    /* 去掉首尾空格*/
+ ( NSString *) WXX_removeEmptyForStartAndEnd:(NSString *) str ;
    
/*时间戳转化为时间 YYYY-MM-dd hh:mm*/
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;

/*时间戳转化为时间 YYYY-MM-dd*/
+ (NSString *)wxx_timeWithYYYY_MM_dd:(NSString *)timeString;

/*时间戳转化为时间*/
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString Format:(NSString *)Format;
/*获取当前时间戳,秒为单位*/
+ (NSString *)getNowTimeTimestamp2;

//去掉首尾空格 并且 移除 内容里面所有换行符号
+ ( NSString *) WXX_removeEmpty_N_ForStartAndEnd:(NSString *) str ;

/**处理银行卡 格式为****1234保留最后4位*/
+ (NSString *)securityBankCard:(NSString *)bankCard ;

/**正常号转银行卡号 － 增加4位间的空格*/
-(NSString *)normalNumToBankNum;

/**银行卡号转正常号 － 去除4位间的空格*/
-(NSString *)bankNumToNormalNum;

/**处理身份证 格式为123456******1234*/
+ (NSString *)securityIDCard:(NSString *)IDCard ;

/**
 * @brief 将数字1234 格式化为1,234
 */
+ (NSString *)decimalStringWithNumber:(id)number;

/**逗号格式化*/
+(NSString *)countNumAndChangeformat:(NSString *)num;
@end

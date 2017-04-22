//
//  NSString+FormatMoneyStr.h
//  fscar
//
//  Created by apple on 2016/11/27.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FormatMoneyStr)

/**逗号格式化*/
+(NSString *)countNumAndChangeformat:(NSString *)num;

/**按照4个一个空格隔开*/
+(NSString *)normalNumToBankNum:(NSString *)num;

// 银行卡号转正常号 － 去除4位间的空格
+(NSString *)bankNumToNormalNum:(NSString *)num;
@end

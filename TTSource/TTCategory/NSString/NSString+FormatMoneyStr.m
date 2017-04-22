

//
//  NSString+FormatMoneyStr.m
//  fscar
//
//  Created by apple on 2016/11/27.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import "NSString+FormatMoneyStr.h"

@implementation NSString (FormatMoneyStr)
+(NSString *)countNumAndChangeformat:(NSString *)num
{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}



// 正常号转银行卡号 － 增加4位间的空格
+(NSString *)normalNumToBankNum:(NSString *)num
{
    
    NSString *tmpStr = [NSString bankNumToNormalNum:num];
    
    NSInteger size = (tmpStr.length / 4);
    
    
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    
    for (int n = 0;n < size; n++)
    {
        [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(n*4, 4)]];
    }
    
    [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(size*4, (tmpStr.length % 4))]];
    
    tmpStr = [tmpStrArr componentsJoinedByString:@" "];
    
    return tmpStr;
}

// 银行卡号转正常号 － 去除4位间的空格
+(NSString *)bankNumToNormalNum:(NSString *)num
{
    return [num stringByReplacingOccurrencesOfString:@" " withString:@""];
}


@end

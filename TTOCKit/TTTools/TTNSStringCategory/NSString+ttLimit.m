//
//  NSString+Validate.m
//  WellRead
//
//  Created by bevis on 15/12/21.
//  Copyright © 2015年 dyage. All rights reserved.
//

#import "NSString+ttLimit.h"

@implementation NSString (ttLimit)
//邮箱
- (BOOL)WXX_validateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


//手机号码验证
- (BOOL)WXX_validateMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}


//车牌号验证
- (BOOL)WXX_validateCarNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}


//车型
- (BOOL)WXX_validateCarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:self];
}


//用户名
- (BOOL)WXX_validateUserName
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:self];
    return B;
}


//真实姓名
- (BOOL)WXX_validateTrueName
{
    NSString *trueNameRegex = @"^[\u4e00-\u9fa5a-zA-Z]+$";
//    NSString *trueNameRegex = @"^([\u4E00-\u9FA5]+|[a-zA-Z]+)$";
    NSPredicate *trueNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",trueNameRegex];
    BOOL B = [trueNamePredicate evaluateWithObject:self];
    return B;
}


//密码
- (BOOL)WXX_validatePassword
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}


//昵称
- (BOOL)WXX_validateNickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}


//身份证号
- (BOOL)WXX_validateIdentityCard
{
    if (self.length != 18) return NO;
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

//取消多余的0
- (NSString *)WXX_cancelRedundant_0
{

    NSString * s = nil;
    NSInteger offset = self.length - 1;
    NSString *str = @".";
    NSString *strTemp = @"";
    
    while (offset)
    {
        strTemp = [self substringToIndex:offset+1];
        
        //在strTemp这个字符串中搜索:. ，判断有没有小数点
        if ([strTemp rangeOfString:str].location != NSNotFound) {//如果有点

            s = [self substringWithRange:NSMakeRange(offset, 1)];
            
            if ([s isEqualToString:@"0"] || [s isEqualToString:@"."])
            {
                offset--;

            }
            else
            {
                break;
            }

        } else{//如果没有点
            
            break;
        }
        
    }
    
    return [self substringToIndex:offset+1];
}



- (BOOL)WXX_validateStringMinLength:(NSInteger)minLength maxLength:(NSInteger)maxLength
{
    return (self.length >= minLength && self.length <= maxLength);
}







/**1470758400 --> yyyy-MM-dd*/
 - (NSString *)WXX_toDateStr{
     
     if (![self WXX_isPureNumandCharacters]) return self;
     
     
     NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self integerValue]] ;
     
     NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
     
     [dateFormat setDateFormat:@"yyyy-MM-dd"];
     
     NSString *dateString = [dateFormat stringFromDate:date];
     
     return dateString;

     
 }
 
 
 //判断字符串是否为纯数字
 - (BOOL)WXX_isPureNumandCharacters{
     
     
     NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
     
     if(str.length > 0)
     {
         return NO;
     }
     return YES;
 }


/**将下滑线转为驼峰*/
+ (NSString *)WXX_convertToCamelCaseFromSnakeCase:(NSString *)key {
    NSMutableString *str = [NSMutableString stringWithString:key];
    while ([str containsString:@"_"]) {
        NSRange range = [str rangeOfString:@"_"];
        if (range.location + 1 < [str length]) {
            char c = [str characterAtIndex:range.location+1];
            [str replaceCharactersInRange:NSMakeRange(range.location, range.length+1) withString:[[NSString stringWithFormat:@"%c",c] uppercaseString]];
        }
    }
    return str;
}

//判断内容是否全部为空格  yes 全部为空格  no 不是
+ (BOOL) WXX_isEmpty:(NSString *) str {
    
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}


//时间戳转化为时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    
    return [NSString timeWithTimeIntervalString:timeString Format:@"YYYY-MM-dd hh:mm"];
}
+ (NSString *)wxx_timeWithYYYY_MM_dd:(NSString *)timeString{
    return [NSString timeWithTimeIntervalString:timeString Format:@"YYYY-MM-dd"];

}

//时间戳转化为时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString Format:(NSString *)Format
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:Format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}
//获取当前时间戳,秒为单位
+ (NSString *)getNowTimeTimestamp2{
    
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    ;
    
    return timeString;
    
}
 //去掉首尾空格
+ ( NSString *) WXX_removeEmptyForStartAndEnd:(NSString *) str {
    
    //特殊的字符
//    NSString *t = @"\r";
//    int l = (int)t.length;
//    if ([str hasPrefix:t]) {
//        NSString *s = [str substringFromIndex:l];
//        
//        return [NSString WXX_removeEmptyForStartAndEnd:s];
//    }
//    
//    if ([str hasSuffix:t]) {
//        NSString *s = [str substringToIndex:str.length - l];
//        
//        return [NSString WXX_removeEmptyForStartAndEnd:s];
//    }

    
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符

    
//    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] ;
    
}

//去掉首尾空格 并且 移除 内容里面所有换行符号
+ ( NSString *) WXX_removeEmpty_N_ForStartAndEnd:(NSString *) str {
    
    //特殊的字符

    
    NSString *s = [str stringByReplacingOccurrencesOfString:@"\r\n" withString:@"   "];
    NSString *t = [s stringByReplacingOccurrencesOfString:@"\\n" withString:@"   "];
    NSString *r = [t stringByReplacingOccurrencesOfString:@"\t" withString:@"   "];
    NSString *a = [r stringByReplacingOccurrencesOfString:@"\r" withString:@"   "];
    
    NSLog(@"%@",str);
    
    
    
    return [a stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
    
    
    //    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] ;
    
}


/**处理银行卡 格式为****1234保留最后4位*/
+ (NSString *)securityBankCard:(NSString *)bankCard {
    if(bankCard.length > 4){
        return [NSString stringWithFormat:@"**********%@",[bankCard substringFromIndex:bankCard.length-4]];
    }
    return bankCard;
}
/**正常号转银行卡号 － 增加4位间的空格*/
-(NSString *)normalNumToBankNum
{
    NSString *tmpStr = [self bankNumToNormalNum];
    
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
/**银行卡号转正常号 － 去除4位间的空格*/
-(NSString *)bankNumToNormalNum
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}
    
/**处理身份证 格式为123456******1234*/
+ (NSString *)securityIDCard:(NSString *)IDCard {
    if(IDCard.length > 10){
        return [NSString stringWithFormat:@"%@********%@",[IDCard substringToIndex:6], [IDCard substringFromIndex:IDCard.length-4]];
    }else if(IDCard.length > 4){
        return [NSString stringWithFormat:@"********%@", [IDCard substringFromIndex:IDCard.length-4]];
    }
    return IDCard;
}
/**
 * @brief 将数字1234 格式化为1,234
 */
+ (NSString *)decimalStringWithNumber:(id)number {
    return [NSString decimalStringWithNumber:number andSuffix:nil];
}
+ (NSString *)decimalStringWithNumber:(NSNumber *)number andSuffix:(NSString *)suffix {
    if(number == nil){
        return @"0";
    }
    if([number isKindOfClass:[NSString class]]){
        number = [NSNumber numberWithDouble:[(NSString *)number doubleValue]];
    }
    if (![number isKindOfClass:[NSNumber class]]) {
        
        return @"0";
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *string = [formatter stringFromNumber:number];
    if(suffix != nil){
        string = [string stringByAppendingString:suffix];
    }
    return string;
}


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
@end

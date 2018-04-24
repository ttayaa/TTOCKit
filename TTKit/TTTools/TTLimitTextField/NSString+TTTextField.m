//
//  NSString+TTTextField.m
//  TTDemos
//
//  Created by apple on 2017/3/19.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "NSString+TTTextField.h"

@implementation NSString (TTTextField)
-(BOOL)TT_is:(TTTextFieldStringType)stringType
{
    return [self matchRegularWith:stringType];
}
-(BOOL)TT_isSpecialLetter
{
    if ([self TT_is:TTTextFieldStringTypeNumber] || [self TT_is:TTTextFieldStringTypeLetter] || [self TT_is:TTTextFieldStringTypeChinese]) {
        return NO;
    }
    return YES;
}
#pragma mark --- 用正则判断条件
-(BOOL)matchRegularWith:(TTTextFieldStringType)type
{
    NSString *regularStr = @"";
    switch (type) {
        case TTTextFieldStringTypeNumber:      //数字
            regularStr = @"^[0-9]*$";
            break;
        case TTTextFieldStringTypeLetter:      //字母
            regularStr = @"^[A-Za-z]+$";
            break;
        case TTTextFieldStringTypeChinese:     //汉字
            regularStr = @"^[\u4e00-\u9fa5]{0,}$";
            break;
        default:
            break;
    }
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularStr];
    
    if ([regextestA evaluateWithObject:self] == YES){
        return YES;
    }
    return NO;
}
-(int)TT_getStrLengthWithCh2En1
{
    int strLength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strLength++;
        }else {
            p++;
        }
    }
    return strLength;
}

-(NSString *)TT_removeSpecialLettersExceptLetters:(NSArray<NSString *> *)exceptLetters
{
    if (self.length > 0) {
        NSMutableString *resultStr = [[NSMutableString alloc]init];
        for (int i = 0; i<self.length; i++) {
            NSString *indexStr = [self substringWithRange:NSMakeRange(i, 1)];
            
            if (![indexStr TT_isSpecialLetter] || (exceptLetters && [exceptLetters containsObject:indexStr])) {
                [resultStr appendString:indexStr];
            }
        }
        if (resultStr.length > 0) {
            return resultStr;
        }else{
            return @"";
        }
    }else{
        return @"";
    }
}
@end

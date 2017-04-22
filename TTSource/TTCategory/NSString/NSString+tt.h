//
//  NSString+MAC.h
//  WeiSchoolTeacher
//
//  Created by ttayaa on 15/12/11.
//  Copyright © 2015年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString(tt)

+(NSString *)tt_utf8ToUnicode:(NSString *)string;


/**
 *  判断字符串是否为空
 */
-(BOOL)tt_isBlank;

/**
 *  MD5加密
 */
-(NSString *)tt_md5String;

/**
 *  计算相应字体下指定宽度的字符串高度
 */
- (CGFloat)tt_stringHeightWithFont:(UIFont *)font width:(CGFloat)width;



/**
 *  JSON字符传转化成字典
 *
 *  @return 返回字典
 */
- (NSDictionary *)tt_jsonStringToDictionary;

/**
 *  取出HTML
 *
 *  @return 返回字符串
 */
-(NSString *)tt_htmlToString;




/**
 *  字符串加密为base64
 *
 *  @return 返回String
 */
-(NSString *)tt_base64StringFromText;

/**
 *  加密字符串解析
 *
 *  @return 返回解析后的字符串
 */
- (NSString *)tt_textFromBase64String;
/**
 *  将字符串转化为NSURL
 *
 *  @return  NSURL地址
 */
-(NSURL *)tt_macUrl;
/**
 *  将资源字符串转化为图片资源
 *
 *  @return  图片
 */
-(UIImage *)tt_macImage;



@end

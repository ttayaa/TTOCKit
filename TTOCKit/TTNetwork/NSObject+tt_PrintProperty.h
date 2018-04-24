//
//  NSObject+runtime.h
//  ttayaa微博部署
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (tt_PrintProperty)

/** 获取对象的所有属性和属性内容 */
- (NSDictionary *)tt_getAllPropertiesAndVaules;

/** 获取对象的所有属性 */
- (NSArray *)tt_getAllProperties;

/** 获取对象的所有方法 */
-(void)tt_getAllMethods;

/** 以字典的形式打印属性和属性值 */
-(void)tt_print;

/** 类名*/
-(NSString *)tt_getclassName;

@end

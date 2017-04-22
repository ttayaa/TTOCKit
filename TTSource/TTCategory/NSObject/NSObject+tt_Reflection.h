//
//  NSObject+tt_Reflection.h
//  NSObject-tt_Reflection
//
//  Created by Jakey on 15/12/22.
//  Copyright © 2015年 Jakey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (tt_Reflection)
//类名
- (NSString *)tt_className;
+ (NSString *)tt_className;
//父类名称
- (NSString *)tt_superClassName;
+ (NSString *)tt_superClassName;

//实例属性字典
-(NSDictionary *)tt_propertyDictionary;

//属性名称列表
- (NSArray*)tt_propertyKeys;
+ (NSArray *)tt_propertyKeys;

//属性详细信息列表
- (NSArray *)tt_propertiesInfo;
+ (NSArray *)tt_propertiesInfo;

//格式化后的属性列表
+ (NSArray *)tt_propertiesWithCodeFormat;

//方法列表
-(NSArray*)tt_methodList;
+(NSArray*)tt_methodList;

-(NSArray*)tt_methodListInfo;

//创建并返回一个指向所有已注册类的指针列表
+ (NSArray *)tt_registedClassList;
//实例变量
+ (NSArray *)tt_instanceVariable;

//协议列表
-(NSDictionary *)tt_protocolList;
+ (NSDictionary *)tt_protocolList;


- (BOOL)tt_hasPropertyForKey:(NSString*)key;
- (BOOL)tt_hasIvarForKey:(NSString*)key;

@end

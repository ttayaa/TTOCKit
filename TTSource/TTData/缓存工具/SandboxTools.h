//
//  SandboxTools.h
//  ttayaa
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SandboxTools : NSObject
/** 将传入字符串拼接到tmp目录后面 */
+(NSString *)tmpDirWithPath :(NSString *)path;

/** 将传入字符串拼接到Document目录后面 */
+(NSString *)DocumentDir:(NSString *)path;

/** 将传入字符串拼接到Library/Caches目录后面 */
+(NSString *)CachesDir:(NSString *)path;


/** 将 实现NSCodeing协议的对象(一般系统的对象都支持)  归档*/
+(void)ArchiverSystemObject:(id) obj forKey:(NSString *)key;

/** 将根据名字实现NSCodeing协议的对象   中的数据*/
+(id)unarchiveSystemObjectKey:(NSString *)key;



/** 将 自定义对象  存入Library/Preference */
+(void)ArchiverObject:(id) obj forKey:(NSString *)key;

/** 将根据名字解档自定义对象    Library/Preference 中的数据*/
+(NSDictionary *)unarchiveDictForKey:(NSString *)key;

/** 将任何  NSObjct数组  (包括自定义类数组)  进行偏好设置归档 */
+(void)ArchiverObjectArray:(id) objs forKey:(NSString *)key;

/** 将任何  NSObjct数组 进行解档 */
+(NSMutableArray<NSDictionary *> *)unarchiveObjectArrForKey:(NSString *)key;


@end

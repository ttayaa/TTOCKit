//
//  SandboxTools.h
//  ttayaa
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Security/Security.h>

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




/**keychain 保存*/
/**
 * 储存字符串到钥匙串
 * @param sValue 对应的Value
 * @param sKey 对应的Key
 */
+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey;

/**
 * 从钥匙串获取字符串
 * @param sKey 对应的Key
 * @return 返回储存的Value
 */
+ (NSString *)readKeychainValue:(NSString *)sKey;

/**
 * 从钥匙串删除字符串
 * @param sKey 对应的Key
 */
+ (void)deleteKeychainValue:(NSString *)sKey;



@end

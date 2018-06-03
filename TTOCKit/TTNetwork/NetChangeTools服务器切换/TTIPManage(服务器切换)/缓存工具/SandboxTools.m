//
//  SandboxTools.m
//  ttayaa
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import "SandboxTools.h"
#import <objc/runtime.h>

@implementation SandboxTools


static  NSMutableArray<NSMutableDictionary *> *KeyNameArr;
+(void)initialize
{
    
    NSString *cachePaht = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachePaht stringByAppendingPathComponent:@"keyNameArr.plist"];
    KeyNameArr = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    if (!KeyNameArr) {
        KeyNameArr = [NSMutableArray<NSMutableDictionary *> array];
    }
    
}

+(void)ArchiverObjectArray:(id) objs forKey:(NSString *)key
{
    
    [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self ArchiverObject:obj forKey:[NSString stringWithFormat:@"%@%ld",key,(long)idx]];
    }];
    
    
    NSArray *arr =(NSArray *)objs;
    
    
    __block BOOL ishaveKey = NO;
    [KeyNameArr enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull keydict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([keydict[@"keyName"] isEqualToString:key]) {
            //说明这个key存在
            //那么就替换这个key的值
            keydict[@"count"] = @(arr.count);
            ishaveKey = YES;
        }
        
    }];
    
    
    if (ishaveKey == NO) {
        //添加这个key
       [KeyNameArr addObject: [NSMutableDictionary dictionaryWithDictionary:@{@"keyName":key,@"count":@(arr.count)}]];
    }
    
    //将keyNameArr保存为keyNameArr.plist
    NSString *cachePaht = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachePaht stringByAppendingPathComponent:@"keyNameArr.plist"];
    
    [KeyNameArr writeToFile:filePath atomically:YES];
    
    
}

+(NSMutableArray<NSDictionary *> *)unarchiveObjectArrForKey:(NSString *)key
{
    //遍历当前的KeyNameArr数组
    for (NSMutableDictionary *Keydict in KeyNameArr) {
        //判断是否有这个key
        
        NSString *keyName = (NSString *)Keydict[@"keyName"];
        //有就开始反序列化
        if ([keyName isEqualToString:key]) {
            NSMutableArray<NSDictionary *> *arr = [NSMutableArray array];
            NSString *countStr = Keydict[@"count"];
            NSInteger count = [countStr integerValue];
            for (NSInteger i=0; i<count; i++) {
                NSDictionary *dict =  [self unarchiveDictForKey:[NSString stringWithFormat:@"%@%ld",key,(long)i]];
                [arr addObject:dict];
            }
            
            //            NSLog(@"%@",arr);
            
            return arr;
            
            
        }
        
    }
    
    return nil;
}


/** 将传入字符串拼接到Library/Caches目录后面 */
+(NSString *)CachesDir:(NSString *)path
{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    return [cachePath stringByAppendingPathComponent:path.lastPathComponent];
    
}

/** 将传入字符串拼接到Document目录后面 */
+(NSString *)DocumentDir:(NSString *)path
{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    return [docPath stringByAppendingPathComponent:path.lastPathComponent];
    
}

/** 将传入字符串拼接到tmp目录后面 */
+(NSString *)tmpDirWithPath :(NSString *)path;
{
    
    NSString *tmpPath =NSTemporaryDirectory();
    
    return [tmpPath stringByAppendingPathComponent:path.lastPathComponent];
    
}




//NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@""];
//NSDictionary * dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
+(NSDictionary *)unarchiveDictForKey:(NSString *)key
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        return data;
    }
    
    return (NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    
}

//将一个OC对象存到硬盘上面
+(void)ArchiverObject:(id) obj forKey:(NSString *)key
{
    
    NSMutableDictionary *dict =  [self getAllPropertiesAndVaulesWithObj:obj];
    
//    NSMutableDictionary *archiverDict = [NSMutableDictionary dictionary];
    
    
    [self convertModelArrInDict:dict];
    
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


//递归处理字典(转换字典中的模型数组 为字典数组)
+(void)convertModelArrInDict:(NSMutableDictionary *)dict
{
    
    //如果字典里面有数组
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[NSArray class]]) {
            
            
            NSArray *arr = (NSArray *)obj;
            NSMutableArray * newArr = [NSMutableArray array];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (
                    ![obj isKindOfClass:[NSArray class]]
                    &&
                    ! [obj isKindOfClass:[NSDictionary class]]
                     &&
                    ! [obj isKindOfClass:[NSSet class]]
                     &&
                    ! [obj isKindOfClass:[NSString class]]
                    &&
                    ! [obj isKindOfClass:[NSValue class]]
                    &&
                    ! [obj isKindOfClass:[UIView class]]
                    ) {
                    
                    //将每一个模型转成字典
                    NSMutableDictionary *Mdict =  [self getAllPropertiesAndVaulesWithObj:obj];
                    
                    [newArr addObject:Mdict];
                    
                    [self convertModelArrInDict:Mdict];
                    
                }
                
            }];
            
            if (newArr.count==0) {
               dict[key] = arr;
            }
            else
            {
                dict[key] = newArr;
            }
            
           
        }
        
    }];
    
}



/* 获取对象的所有属性和属性内容 */
+ (NSMutableDictionary *)getAllPropertiesAndVaulesWithObj:(id)obj
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties =class_copyPropertyList([obj class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);

        NSString * propertyName = [NSString stringWithUTF8String:char_f];
        
        id propertyValue;
        
        @try {
            propertyValue = [obj valueForKey:(NSString *)propertyName];
        }
        @catch (NSException *exception) {
        }
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
        //如果是基本数据类型无法KVC
        else [props setObject:[NSString stringWithFormat:@"%d",(int)propertyValue] forKey:propertyName];
    }
    free(properties);
    
    return props;
}








/** 将 实现NSCodeing协议的对象(一般系统的对象都支持)  归档*/
+(void)ArchiverSystemObject:(id) obj forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
}

/** 将根据名字实现NSCodeing协议的对象   中的数据*/
+(id)unarchiveSystemObjectKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}









+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,
            (__bridge_transfer id)kSecClass,service,
            (__bridge_transfer id)kSecAttrService,service,
            (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,
            (__bridge_transfer id)kSecAttrAccessible,
            nil];
}

+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey {
    NSMutableDictionary * keychainQuery = [self getKeychainQuery:sKey];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:sValue] forKey:(__bridge_transfer id)kSecValueData];
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}

+ (NSString *)readKeychainValue:(NSString *)sKey {
    NSString *ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:sKey];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = (NSString *)[NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", sKey, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)deleteKeychainValue:(NSString *)sKey {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:sKey];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

@end

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


static  NSMutableArray<NSDictionary *> *KeyNameArr;
+(void)initialize
{
    KeyNameArr = [NSMutableArray<NSDictionary *> array];
    
    NSString *cachePaht = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachePaht stringByAppendingPathComponent:@"keyNameArr.plist"];
    KeyNameArr = [NSMutableArray arrayWithContentsOfFile:filePath];
    
}

+(void)ArchiverObjectArray:(id) objs forKey:(NSString *)key
{
    
    [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self ArchiverObject:obj forKey:[NSString stringWithFormat:@"%@%ld",key,(long)idx]];
    }];
    
    
    
    NSArray *arr =(NSArray *)objs;
    //如果key数组 没有当前key,那么将当前key添加到key数组中
    if ( ! [KeyNameArr containsObject:@{@"keyName":key,@"count":@(arr.count)}] ) {
        
        KeyNameArr = [NSMutableArray<NSDictionary *> array];
        
        [KeyNameArr addObject:@{@"keyName":key,@"count":@(arr.count)}];
        
        
        //将keyNameArr保存为keyNameArr.plist
        NSString *cachePaht = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *filePath = [cachePaht stringByAppendingPathComponent:@"keyNameArr.plist"];
        
        [KeyNameArr writeToFile:filePath atomically:YES];
        
    }
    
    
}

+(NSMutableArray<NSDictionary *> *)unarchiveObjectArrForKey:(NSString *)key
{
    //遍历当前的KeyNameArr数组
    for (NSDictionary *Keydict in KeyNameArr) {
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
                
                //将每一个模型转成字典
                NSMutableDictionary *Mdict =  [self getAllPropertiesAndVaulesWithObj:obj];
                
                [newArr addObject:Mdict];
                
                [self convertModelArrInDict:Mdict];
                
                
            }];
            
            dict[key] = newArr;
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

@end

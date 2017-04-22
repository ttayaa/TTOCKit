//
//  NSObject+getVarName.m
//  bssc
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "NSObject+getVarName.h"
#import <objc/runtime.h>


@implementation NSObject (getVarName)


- (NSString *)nameWithInstance:(id)instance
{
    unsigned int numIvars = 0;
    NSString *key=nil;
    Ivar * ivars = class_copyIvarList([self class], &numIvars);
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        const char *type = ivar_getTypeEncoding(thisIvar);
        NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        if (![stringType hasPrefix:@"@"]) {
            continue;
        }
        if ((object_getIvar(self, thisIvar) == instance)) {
            key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
            break;
        }
    }
    free(ivars);
    return key;
}


//
//
//
//static const char MJReplacedKeyFromPropertyNameKey = '\0';
//static const char MJReplacedKeyFromPropertyName121Key = '\0';
//static const char MJNewValueFromOldValueKey = '\0';
//static const char MJObjectClassInArrayKey = '\0';
//
//static const char MJCachedPropertiesKey = '\0';
//
//
//static NSMutableDictionary *replacedKeyFromPropertyNameDict_;
//static NSMutableDictionary *replacedKeyFromPropertyName121Dict_;
//static NSMutableDictionary *newValueFromOldValueDict_;
//static NSMutableDictionary *objectClassInArrayDict_;
//static NSMutableDictionary *cachedPropertiesDict_;
//
//+ (NSMutableArray *)properties
//{
//    NSMutableArray *cachedProperties = [self dictForKey:&MJCachedPropertiesKey][NSStringFromClass(self)];
//
//    if (cachedProperties == nil) {
//        cachedProperties = [NSMutableArray array];
//
//        [self mj_enumerateClasses:^(__unsafe_unretained Class c, BOOL *stop) {
//            // 1.获得所有的成员变量
//            unsigned int outCount = 0;
//            objc_property_t *properties = class_copyPropertyList(c, &outCount);
//
//            // 2.遍历每一个成员变量
//            for (unsigned int i = 0; i<outCount; i++) {
//                MJProperty *property = [MJProperty cachedPropertyWithProperty:properties[i]];
//                // 过滤掉Foundation框架类里面的属性
//                if ([MJFoundation isClassFromFoundation:property.srcClass]) continue;
//                property.srcClass = c;
//                [property setOriginKey:[self propertyKey:property.name] forClass:self];
//                [property setObjectClassInArray:[self propertyObjectClassInArray:property.name] forClass:self];
//                [cachedProperties addObject:property];
//            }
//
//            // 3.释放内存
//            free(properties);
//        }];
//
//        [self dictForKey:&MJCachedPropertiesKey][NSStringFromClass(self)] = cachedProperties;
//    }
//
//    return cachedProperties;
//}
//
//
//+ (NSMutableDictionary *)dictForKey:(const void *)key
//{
//    @synchronized (self) {
//        if (key == &MJReplacedKeyFromPropertyNameKey) return replacedKeyFromPropertyNameDict_;
//        if (key == &MJReplacedKeyFromPropertyName121Key) return replacedKeyFromPropertyName121Dict_;
//        if (key == &MJNewValueFromOldValueKey) return newValueFromOldValueDict_;
//        if (key == &MJObjectClassInArrayKey) return objectClassInArrayDict_;
//        if (key == &MJCachedPropertiesKey) return cachedPropertiesDict_;
//        return nil;
//    }
//}
//
//
//+ (id)propertyKey:(NSString *)propertyName
//{
//    MJExtensionAssertParamNotNil2(propertyName, nil);
//
//    __block id key = nil;
//    // 查看有没有需要替换的key
//    if ([self respondsToSelector:@selector(mj_replacedKeyFromPropertyName121:)]) {
//        key = [self mj_replacedKeyFromPropertyName121:propertyName];
//    }
//    // 兼容旧版本
//    if ([self respondsToSelector:@selector(replacedKeyFromPropertyName121:)]) {
//        key = [self performSelector:@selector(replacedKeyFromPropertyName121) withObject:propertyName];
//    }
//
//    // 调用block
//    if (!key) {
//        [self mj_enumerateAllClasses:^(__unsafe_unretained Class c, BOOL *stop) {
//            MJReplacedKeyFromPropertyName121 block = objc_getAssociatedObject(c, &MJReplacedKeyFromPropertyName121Key);
//            if (block) {
//                key = block(propertyName);
//            }
//            if (key) *stop = YES;
//        }];
//    }
//
//    // 查看有没有需要替换的key
//    if ((!key || [key isEqual:propertyName]) && [self respondsToSelector:@selector(mj_replacedKeyFromPropertyName)]) {
//        key = [self mj_replacedKeyFromPropertyName][propertyName];
//    }
//    // 兼容旧版本
//    if ((!key || [key isEqual:propertyName]) && [self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
//        key = [self performSelector:@selector(replacedKeyFromPropertyName)][propertyName];
//    }
//
//    if (!key || [key isEqual:propertyName]) {
//        [self mj_enumerateAllClasses:^(__unsafe_unretained Class c, BOOL *stop) {
//            NSDictionary *dict = objc_getAssociatedObject(c, &MJReplacedKeyFromPropertyNameKey);
//            if (dict) {
//                key = dict[propertyName];
//            }
//            if (key && ![key isEqual:propertyName]) *stop = YES;
//        }];
//    }
//
//    // 2.用属性名作为key
//    if (!key) key = propertyName;
//
//    return key;
//}
//
//
//+ (Class)propertyObjectClassInArray:(NSString *)propertyName
//{
//    __block id clazz = nil;
//    if ([self respondsToSelector:@selector(mj_objectClassInArray)]) {
//        clazz = [self mj_objectClassInArray][propertyName];
//    }
//    // 兼容旧版本
//    if ([self respondsToSelector:@selector(objectClassInArray)]) {
//        clazz = [self performSelector:@selector(objectClassInArray)][propertyName];
//    }
//
//    if (!clazz) {
//        [self mj_enumerateAllClasses:^(__unsafe_unretained Class c, BOOL *stop) {
//            NSDictionary *dict = objc_getAssociatedObject(c, &MJObjectClassInArrayKey);
//            if (dict) {
//                clazz = dict[propertyName];
//            }
//            if (clazz) *stop = YES;
//        }];
//    }
//
//    // 如果是NSString类型
//    if ([clazz isKindOfClass:[NSString class]]) {
//        clazz = NSClassFromString(clazz);
//    }
//    return clazz;
//}
@end

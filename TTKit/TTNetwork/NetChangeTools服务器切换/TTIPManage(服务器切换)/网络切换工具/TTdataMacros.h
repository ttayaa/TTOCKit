//
//  TTdataMacros.h
//  bssc
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#ifndef TTdataMacros_h
#define TTdataMacros_h




//输出调试
#ifdef DEBUG
#define ttLog(...) NSLog(__VA_ARGS__)
#else
#define ttLog(...)
#endif



//单例
#define interfaceSingleton(name)  +(instancetype)share##name; \
+(void)clear; \

// ARC
#define implementationSingleton(name)  \
+ (instancetype)share##name \
{ \
name *instance = [[self alloc] init]; \
return instance; \
} \
static name *_instance = nil; \
\
\
static dispatch_once_t onceToken; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
\
dispatch_once(&onceToken, ^{ \
_instance = [[super allocWithZone:zone] init]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone{ \
return _instance; \
} \
- (id)mutableCopyWithZone:(NSZone *)zone \
{ \
return _instance; \
}\
+(void)clear{\
    onceToken=0;\
}\






#endif /* TTdataMacros_h */

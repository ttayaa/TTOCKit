//
//  TTdataMacros.h
//  bssc
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#ifndef TTdataMacros_h
#define TTdataMacros_h


#define UserInfoKey @"UserInfoKey"

//弹框
#define KNOTIFICATION_ShowWait @"KNOTIFICATION_ShowWait"
#define KNOTIFICATION_Sucess @"KNOTIFICATION_Sucess"
#define KNOTIFICATION_Error @"KNOTIFICATION_Error"
#define KNOTIFICATION_ShowTip @"KNOTIFICATION_ShowTip"
#define KNOTIFICATION_Dismiss @"KNOTIFICATION_Dismiss"
#define KNOTIFICATION_NetWorkFail @"KNOTIFICATION_NetWorkFail"

#define CommonProgressShowWait(message) [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_ShowWait object:message];

#define CommonProgressSucess(message) [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_Sucess object:message];

#define CommonProgressError(message) [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_Error object:message];

#define CommonProgressShowTip(message) [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_ShowTip object:message];

#define CommonProgressDismiss [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_Dismiss object:nil];

#define CommonProgressNetWorkFail [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_NetWorkFail object:nil];




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

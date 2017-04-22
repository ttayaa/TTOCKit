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





#define TTAppDelegateName(name) \
Class originalClass = NSClassFromString(name);\
Class swizzledClass = [self class];\





#define TTdifferentClassExchangeMethod(SELStr,SELFlag,swizzledSEL)  \
\
SEL originalSelector_##SELFlag = NSSelectorFromString(SELStr);\
SEL swizzledSelector_##SELFlag = @selector(swizzledSEL);\
\
Method originalMethod_##SELFlag = class_getInstanceMethod(originalClass,originalSelector_##SELFlag); \
Method swizzledMethod_##SELFlag = class_getInstanceMethod(swizzledClass,swizzledSelector_##SELFlag); \
\
IMP originalIMP_##SELFlag = method_getImplementation(originalMethod_##SELFlag); \
IMP swizzledIMP_##SELFlag = method_getImplementation(swizzledMethod_##SELFlag); \
\
const char *originalType_##SELFlag = method_getTypeEncoding(originalMethod_##SELFlag); \
const char *swizzledType_##SELFlag = method_getTypeEncoding(swizzledMethod_##SELFlag); \
\
class_replaceMethod(originalClass,swizzledSelector_##SELFlag,originalIMP_##SELFlag,originalType_##SELFlag); \
class_replaceMethod(originalClass,originalSelector_##SELFlag,swizzledIMP_##SELFlag,swizzledType_##SELFlag); \





#import "TTClassInfo.h"
//万能参数宏
typedef void (^TTSetParmDictBlock)(id value);

#define TTParmsInterface \
@property (strong, nonatomic) NSMutableDictionary *modeltoParms;

#define TTParmsImplementation \
-(NSMutableDictionary *)modeltoParms \
{ \
    if (!_modeltoParms) \
        _modeltoParms = [NSMutableDictionary dictionary]; \
    return _modeltoParms; \
} \
\
+(void)load \
{ \
    Method setPropertyMethod = class_getInstanceMethod(self, @selector(setProperty:)); \
    TTClassInfo *clsinfo = [TTClassInfo classInfoWithClass:self];\
    [clsinfo.methodInfos enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, TTClassMethodInfo * _Nonnull methodinfo, BOOL * _Nonnull stop) {\
        if ([key hasPrefix:@"set"]  &&  ! [key isEqualToString:@"setModeltoParms:"]) {\
            method_exchangeImplementations(methodinfo.method, setPropertyMethod);\
        }\
    }];\
}\
-(void)setProperty:(id)value\
{\
    /*截取出get的方法名*/\
\
    NSString * MethodName = NSStringFromSelector(_cmd);\
    NSString *temp = [MethodName substringFromIndex:3];\
    NSRange range = [temp rangeOfString:@":"];\
    temp = [temp substringToIndex:range.location];\
    /*首字母大小处理*/\
    if([self respondsToSelector:@selector(temp)])\
    {\
        /*如果有这个方法直接进来传参*/\
        [self.modeltoParms addEntriesFromDictionary:@{\
                                                      temp:value,\
                                                      }];\
    }\
    else{\
        NSString *tempfirst = [temp substringToIndex:1];\
        tempfirst = [tempfirst lowercaseString];\
        NSString *templast = [temp substringFromIndex:1];\
        /*首字母小写的get方法*/\
        temp = [tempfirst stringByAppendingString:templast];\
        [self.modeltoParms addEntriesFromDictionary:@{\
                                                      temp:value,\
                                                      }];\
    }\
    [self setProperty:value];\
}\



#endif /* TTdataMacros_h */

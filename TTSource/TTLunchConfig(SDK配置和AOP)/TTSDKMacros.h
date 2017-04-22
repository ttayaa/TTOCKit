//
//  TTSDKMacros.h
//  ZPCommon
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 ZengPing. All rights reserved.
//


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

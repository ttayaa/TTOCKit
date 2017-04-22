//
//  NSObject+dy_dynamicProperty.m
//  CategoryPropertyDynamicSupport
//
//  Created by ttayaa on 15/11/20.
//  Copyright © 2015年 NL. All rights reserved.
//

#ifdef DEBUG
#define NLDLogError(xx, ...)  fprintf(stderr, ##__VA_ARGS__)
#else
#define NLDLogError(xx, ...)  ((void)0)
#endif

#import "NSObject+dy_dynamicPropertyStore.h"
#import "NSObject+dy_dynamicPropertySupport.h"

#import "sys/utsname.h"

@implementation NSObject (dy_dynamicPropertyStore)

+ (BOOL)dy_validDynamicProperty:(objc_property_t)objProperty {
  const char *propertyAttributes = property_getAttributes(objProperty);
  
  // 必须是 @dynamic
  static char *const staticDynamicAttribute = ",D,";
  if (strstr(propertyAttributes, staticDynamicAttribute) == NULL) {
    return NO;
  }
  
  // 名字得以 staticPropertyNamePrefix 为前辍
  static const char *staticPropertyNamePrefix = NULL;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    staticPropertyNamePrefix = dy_dynamicPropertyPrefix();
  });
  
  const char *propertyName = property_getName(objProperty);
  if (staticPropertyNamePrefix != NULL && strstr(propertyName, staticPropertyNamePrefix) != propertyName) {
    return NO;
  }
  
  // 不支持普通指针类型
  NSString *propertyAttributesString = [NSString stringWithCString:propertyAttributes encoding:NSUTF8StringEncoding];
  NSString *propertyEncoding = [propertyAttributesString substringToIndex:[propertyAttributesString rangeOfString:@","].location];
  if ([propertyEncoding hasPrefix:@"T*"]) {
    NLDLogError("%s", "nl dynamic property dot not support C character string\n");
    return NO;
  }
  
  if ([propertyEncoding hasPrefix:@"T^"]) {
    NLDLogError("%s\n", "nl dynamic property dot not support point type");
    return NO;
  }
  
  return YES;
}

+ (NSArray *)dy_dynamicPropertyDescriptors {
  NSMutableArray *descriptors = objc_getAssociatedObject(self, _cmd);
  
  if (nil == descriptors) {
    unsigned int outCount, index;
      
      //导入#import "sys/utsname.h"
      struct  utsname systemInfo;
      uname(&systemInfo);
       NSString  *deviceString = [ NSString  stringWithCString:systemInfo.machine encoding: NSUTF8StringEncoding ];
      
      //如果是 模拟器 iphone4,4s和5
       if  ([deviceString isEqualToString:@ "x86_64" ]||[deviceString isEqualToString:@ "iPhone3,1" ]||[deviceString isEqualToString:@ "iPhone4,1" ]||[deviceString isEqualToString:@ "iPhone5,2" ])
       {
            descriptors = [NSMutableArray array];
       }
      //其他设备 用这个初始方法可以提高内存碎片产生
      else
      {
          descriptors = [NSMutableArray arrayWithCapacity:outCount];

      }
      

      descriptors = [NSMutableArray array];
    objc_setAssociatedObject(self, _cmd, descriptors, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    

    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
      
    for (index = 0; index < outCount; ++index) {
      objc_property_t property = properties[index];
      if ([self dy_validDynamicProperty:property]) {
        NLPropertyDescriptor *descriptor = [[NLPropertyDescriptor alloc] initWithObjcProperty:property];
        [descriptors addObject:descriptor];
      }
    }
    
    free(properties);
    
    if (self != [NSObject class]) {
      // 加上父类的属性结构体
      [descriptors addObjectsFromArray:[class_getSuperclass(self) dy_dynamicPropertyDescriptors]];
    }
  }
  
  return descriptors;
}

+ (NLPropertyDescriptor *)dy_descriptorWithSelector:(SEL)selector {
  for (NLPropertyDescriptor *descriptor in [self dy_dynamicPropertyDescriptors]) {
    NSString *selectorName = NSStringFromSelector(selector);
    if ([descriptor.getterName isEqualToString:selectorName] || [descriptor.setterName isEqualToString:selectorName]) {
      return descriptor;
    }
  }
  return nil;
}

+ (NSString *)dy_dynamicPropertyNameWithSelctor:(SEL)selector {
  return [[self dy_descriptorWithSelector:selector] name];
}


- (NSMutableDictionary *)dy_dynamicPropertyDictionary {
  NSMutableDictionary *dynamicProperties = objc_getAssociatedObject(self, _cmd);
  if (!dynamicProperties) {
    dynamicProperties = [NSMutableDictionary dictionaryWithCapacity:2];
    objc_setAssociatedObject(self, _cmd, dynamicProperties, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  return dynamicProperties;
}

- (NSMapTable *)dy_dynamicPropertyWeakDictionary {
  NSMapTable *weakDynamicProperties = objc_getAssociatedObject(self, _cmd);
  if (!weakDynamicProperties) {
    weakDynamicProperties = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSMapTableWeakMemory capacity:2];
    objc_setAssociatedObject(self, _cmd, weakDynamicProperties, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  return weakDynamicProperties;
}

@end

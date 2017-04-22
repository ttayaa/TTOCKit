//
//  NSObject+dy_dynamicProperty.h
//  CategoryPropertyDynamicSupport
//
//  Created by ttayaa on 15/11/20.
//  Copyright © 2015年 NL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "NLPropertyDescriptor.h"

@interface NSObject (dy_dynamicPropertyStore)

/**
 *  @brief  用来存储自动生成的 `getter`、`setter` 操作的数据
 */
@property (nonatomic, strong, readonly) NSMutableDictionary * _Nullable dy_dynamicPropertyDictionary;

/**
 *  @brief 用来存储自动生成的 `getter`、`setter` 操作的 __weak 类型的数据
 */
@property (nonatomic, strong, readonly) NSMapTable * _Nonnull dy_dynamicPropertyWeakDictionary;

/**
 *  @brief 判断属性是否应该自动生成方法
 *
 *  @param objProperty 需要判断的属性
 *
 *  @return 如果是，则返回 YES；否则返回 NO；
 */
+ (BOOL)dy_validDynamicProperty:(_Nonnull objc_property_t)objProperty;

/**
 * 获取该选择子对应的属性名
 */
+ (NSString * _Nullable)dy_dynamicPropertyNameWithSelctor:(_Nonnull SEL)selector;

/**
 * 获取该选择子对应的属性描述器
 */
+ (NLPropertyDescriptor * _Nullable)dy_descriptorWithSelector:(_Nonnull SEL)selector;

/**
 *  @brief  所有需要动态增加 getter、setter 方法的属性描述器
 *
 *  @return NSArray<NLPropertyDescriptor *>
 */
+ (NSArray<NLPropertyDescriptor *> * _Nullable)dy_dynamicPropertyDescriptors;

@end

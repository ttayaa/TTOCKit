//
//  TTOCClsInfo.h
//  bssc
//
//  Created by apple on 2017/3/27.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

/**
 编码类型
 
 */
typedef NS_OPTIONS(NSUInteger, TTEncodingType) {
    TTEncodingTypeMask       = 0xFF, ///< mask of type value
    TTEncodingTypeUnknown    = 0, ///< unknown
    TTEncodingTypeVoid       = 1, ///< void
    TTEncodingTypeBool       = 2, ///< bool
    TTEncodingTypeInt8       = 3, ///< char / BOOL
    TTEncodingTypeUInt8      = 4, ///< unsigned char
    TTEncodingTypeInt16      = 5, ///< short
    TTEncodingTypeUInt16     = 6, ///< unsigned short
    TTEncodingTypeInt32      = 7, ///< int
    TTEncodingTypeUInt32     = 8, ///< unsigned int
    TTEncodingTypeInt64      = 9, ///< long long
    TTEncodingTypeUInt64     = 10, ///< unsigned long long
    TTEncodingTypeFloat      = 11, ///< float
    TTEncodingTypeDouble     = 12, ///< double
    TTEncodingTypeLongDouble = 13, ///< long double
    TTEncodingTypeObject     = 14, ///< id
    TTEncodingTypeClass      = 15, ///< Class
    TTEncodingTypeSEL        = 16, ///< SEL
    TTEncodingTypeBlock      = 17, ///< block
    TTEncodingTypePointer    = 18, ///< void*
    TTEncodingTypeStruct     = 19, ///< struct
    TTEncodingTypeUnion      = 20, ///< union
    TTEncodingTypeCString    = 21, ///< char*
    TTEncodingTypeCArray     = 22, ///< char[10] (for example)
    
    TTEncodingTypeQualifierMask   = 0xFF00,   ///< mask of qualifier
    TTEncodingTypeQualifierConst  = 1 << 8,  ///< const
    TTEncodingTypeQualifierIn     = 1 << 9,  ///< in
    TTEncodingTypeQualifierInout  = 1 << 10, ///< inout
    TTEncodingTypeQualifierOut    = 1 << 11, ///< out
    TTEncodingTypeQualifierBycopy = 1 << 12, ///< bycopy
    TTEncodingTypeQualifierByref  = 1 << 13, ///< byref
    TTEncodingTypeQualifierOneway = 1 << 14, ///< oneway
    
    TTEncodingTypePropertyMask         = 0xFF0000, ///< mask of property
    TTEncodingTypePropertyReadonly     = 1 << 16, ///< readonly
    TTEncodingTypePropertyCopy         = 1 << 17, ///< copy
    TTEncodingTypePropertyRetain       = 1 << 18, ///< retain
    TTEncodingTypePropertyNonatomic    = 1 << 19, ///< nonatomic
    TTEncodingTypePropertyWeak         = 1 << 20, ///< weak
    TTEncodingTypePropertyCustomGetter = 1 << 21, ///< getter=
    TTEncodingTypePropertyCustomSetter = 1 << 22, ///< setter=
    TTEncodingTypePropertyDynamic      = 1 << 23, ///< @dynamic
};




/**
 返回一个 Type-Encoding 字符串.
 
 @discussion See also:
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
 
 @param typeEncoding  A Type-Encoding string.
 @return The encoding type.
 */
TTEncodingType TTEncodingGetType(const char *typeEncoding);



/**
 成员变量信息模型
 */
@interface TTClassIvarInfo : NSObject
@property (nonatomic, assign, readonly) Ivar ivar;              ///< ivar opaque struct
@property (nonatomic, strong, readonly) NSString *name;         ///< Ivar's name
@property (nonatomic, assign, readonly) ptrdiff_t offset;       ///< Ivar's offset
@property (nonatomic, strong, readonly) NSString *typeEncoding; ///< Ivar's type encoding
@property (nonatomic, assign, readonly) TTEncodingType type;    ///< Ivar's type

/**
 Creates and returns an ivar info object.
 
 @param ivar ivar opaque struct
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithIvar:(Ivar)ivar;
@end


/**
 方法模型
 */
@interface TTClassMethodInfo : NSObject
@property (nonatomic, assign, readonly) Method method;                  ///< method opaque struct
@property (nonatomic, strong, readonly) NSString *name;                 ///< method name
@property (nonatomic, assign, readonly) SEL sel;                        ///< method's selector
@property (nonatomic, assign, readonly) IMP imp;                        ///< method's implementation
@property (nonatomic, strong, readonly) NSString *typeEncoding;         ///< method's parameter and return types
@property (nonatomic, strong, readonly) NSString *returnTypeEncoding;   ///< return value's type
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *argumentTypeEncodings; ///< array of arguments' type

/**
 Creates and returns a method info object.
 
 @param method method opaque struct
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithMethod:(Method)method;
@end


/**
 属性模型.
 */
@interface TTClassPropertyInfo : NSObject
@property (nonatomic, assign, readonly) objc_property_t property; ///< property's opaque struct
@property (nonatomic, strong, readonly) NSString *name;           ///< property's name
@property (nonatomic, assign, readonly) TTEncodingType type;      ///< property's type
@property (nonatomic, strong, readonly) NSString *typeEncoding;   ///< property's encoding value
@property (nonatomic, strong, readonly) NSString *ivarName;       ///< property's ivar name
@property (nullable, nonatomic, assign, readonly) Class cls;      ///< may be nil
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *protocols; ///< may nil
@property (nonatomic, assign, readonly) SEL getter;               ///< getter (nonnull)
@property (nonatomic, assign, readonly) SEL setter;               ///< setter (nonnull)

/**
 Creates and returns a property info object.
 
 @param property property opaque struct
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithProperty:(objc_property_t)property;
@end


/**
 类对象模型.
 */
@interface TTClassInfo : NSObject
@property (nonatomic, assign, readonly) Class cls; ///< class object
@property (nullable, nonatomic, assign, readonly) Class superCls; ///< super class object
@property (nullable, nonatomic, assign, readonly) Class metaCls;  ///< class's meta class object
@property (nonatomic, readonly) BOOL isMeta; ///< whether this class is meta class
@property (nonatomic, strong, readonly) NSString *name; ///< class name
@property (nullable, nonatomic, strong, readonly) TTClassInfo *superClassInfo; ///< super class's class info
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, TTClassIvarInfo *> *ivarInfos; ///< ivars
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, TTClassMethodInfo *> *methodInfos; ///< methods
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, TTClassPropertyInfo *> *propertyInfos; ///< properties

/**
 If the class is changed (for example: you add a method to this class with
 'class_addMethod()'), you should call this method to refresh the class info cache.
 
 After called this method, `needUpdate` will returns `YES`, and you should call
 'classInfoWithClass' or 'classInfoWithClassName' to get the updated class info.
 */
- (void)setNeedUpdate;

/**
 If this method returns `YES`, you should stop using this instance and call
 `classInfoWithClass` or `classInfoWithClassName` to get the updated class info.
 
 @return Whether this class info need update.
 */
- (BOOL)needUpdate;

/**
 Get the class info of a specified Class.
 
 @discussion This method will cache the class info and super-class info
 at the first access to the Class. This method is thread-safe.
 
 @param cls A class.
 @return A class info, or nil if an error occurs.
 */
+ (nullable instancetype)classInfoWithClass:(Class)cls;

/**
 Get the class info of a specified Class.
 
 @discussion This method will cache the class info and super-class info
 at the first access to the Class. This method is thread-safe.
 
 @param className A class name.
 @return A class info, or nil if an error occurs.
 */
+ (nullable instancetype)classInfoWithClassName:(NSString *)className;

@end


NS_ASSUME_NONNULL_END

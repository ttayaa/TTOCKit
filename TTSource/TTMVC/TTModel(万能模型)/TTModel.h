//
//  TTModel.h
//  Pods
//
//  Created by apple on 2017/4/23.
//
//





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


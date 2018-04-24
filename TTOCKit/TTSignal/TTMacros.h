//
//  TTMacros.h
//  TTSource
//
//  Created by apple on 2015/2/10.
//  Copyright © 2015年 ttayaa. All rights reserved.
//

#ifndef TTMacros_h
#define TTMacros_h

//一定要导入 因为宏中用到UIKIT的东西 (UIApplication)
#import <UIKit/UIKit.h>

#pragma mark - 颜色相关
///  颜色相关 ---------------------------  ///
#define TTrandomColor TTRGBA32Color(arc4random()%255, arc4random()%255, arc4random()%255, 1.0)
#define TTRGB24Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define TTRGBA32Color(r, g, b, a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:(a)*1.0]
// 灰色
#define TTGrayColor(grayscale) TTRGBA32Color((grayscale), (grayscale), (grayscale),255)

// 统一背景色
#define TTCommonBackgroundColor TTGrayColor(230)
#define TTWhiteColor [UIColor whiteColor]

// 统一字体颜色
#define TTGlobaltextColor TTRGB24Color(255, 109, 0)

#define TTClearColor [UIColor clearColor]

#pragma mark - 快速存储相关
///  快速存储相关 ---------------------------  ///
//偏好设置存储
#define hUserDefaults  [NSUserDefaults standardUserDefaults]

#define UserInfoKey @"UserInfo"


//获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//获取图片资源
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//Library/Caches 文件路径
#define FilePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])
//获取temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]




#pragma mark - 调试相关
///  快速调试(将主窗口的控制器换成 需要调试的控制器) ---------------------------  ///
#define hRootVc [UIApplication sharedApplication].keyWindow.rootViewController


#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


//输出调试
#ifdef DEBUG
#define ttLog(...) NSLog(__VA_ARGS__)
#else
#define ttLog(...)
#endif





#pragma mark - 屏幕尺寸 主窗口
///  屏幕尺寸 主窗口 ---------------------------  ///
#define hKeyWindow [UIApplication sharedApplication].keyWindow
#define hScreenBounds [UIScreen mainScreen].bounds
#define hScreenWidth [UIScreen mainScreen].bounds.size.width
#define hScreenHeight [UIScreen mainScreen].bounds.size.height



//获取View的属性
#define TTViewWidth(view)  view.frame.size.width
#define TTViewHeight(view) view.frame.size.height
#define TTViewX(view)      view.frame.origin.x
#define TTViewY(view)      view.frame.origin.y

CG_INLINE CGRect CGRectMake320(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    float WHScale = [[UIScreen mainScreen] bounds].size.width / 320;
    rect.origin.x = x*WHScale; rect.origin.y = y*WHScale;
    rect.size.width = width*WHScale; rect.size.height = height*WHScale;
    
    return rect;
}
CG_INLINE CGRect CGRectMakes375(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    float WHScale = [[UIScreen mainScreen] bounds].size.width / 375;
    rect.origin.x = x*WHScale; rect.origin.y = y*WHScale;
    rect.size.width = width*WHScale; rect.size.height = height*WHScale;
    
    return rect;
}
CG_INLINE CGRect CGRectMake414(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    float WHScale = [[UIScreen mainScreen] bounds].size.width / 414;
    rect.origin.x = x*WHScale; rect.origin.y = y*WHScale;
    rect.size.width = width*WHScale; rect.size.height = height*WHScale;
    
    return rect;
}


#pragma mark - 设置状态栏颜色
///  设置状态栏颜色 ---------------------------  ///
#define White_StatusBar    do {[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;} while (0)
#define Black_StatusBar     do {[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;} while (0)



#pragma mark - 其他
///  其他 ---------------------------  ///
/**block弱指针
 用法:
 先声明 WEAKSELF;
 然后使用 weakSelf
 */
#define WEAKSELF __weak typeof(self) weakSelf = self;

#define weakify( x )  __weak __typeof__(x) __weak_##x##__ = x;
#define normalize( x ) __typeof__(x) x = __weak_##x##__;

// 是否大于等于IOS7
#define isIOS7                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
// 是否IOS6
#define isIOS6                  ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0)
// 是否大于等于IOS8
#define isIOS8                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0)
// 是否大于IOS9
#define isIOS9                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0)
// 是否大于IOS10
#define isIOS10                 ([[[UIDevice currentDevice]systemVersion]floatValue] >=10.0)

// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 是否iPhoneX
#define isiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)

//通知中心
#define hNotificationCenter     [NSNotificationCenter defaultCenter]

//默认字体
//        #define hDefaultFont(size) [UIFont systemFontOfSize:size]
#define TTFont(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]


//获取导航栏高度
#define hNavigationHeight CGRectGetMaxY([self.navigationController navigationBar].frame)

//根据ihpone屏幕 比例 宽度或高度


#define RATIOIphone5s   hScreenWidth/320  //以5s为主比例
#define RATIOIphone6   hScreenWidth/375  //以6为主比例
#define RATIOIphone6p   hScreenWidth/414  //以6p为主比例


#define TTIphone5sRadio(number) number*RATIOIphone5s    //以5s为主比例
#define TTIphone6Radio(number) number*RATIOIphone6   //以6为主比例
#define TTIphone6pRadio(number) number*RATIOIphone6p   //以6p为主比例
#define TTIphone5sFont(number) [UIFont systemFontOfSize:(number)*RATIOIphone5s]
#define TTIphone6Font(number) [UIFont systemFontOfSize:(number)*RATIOIphone6]
#define TTIphone6pFont(number) [UIFont systemFontOfSize:(number)*RATIOIphone6p]


//角度
#define TTDegreesToRadian(x) (M_PI * (x) / 180.0)
#define TTRadianToDegrees(radian) (radian*180.0)/(M_PI)

#define TTkeyPath(objc,keyPath) @(((void)objc.keyPath, #keyPath))


// 是否空对象
#define IS_NULL_CLASS(OBJECT) [OBJECT isKindOfClass:[NSNull class]]

//如果是模拟器 IS_SIMULATOR 为 1
#if TARGET_IPHONE_SIMULATOR
#define IS_SIMULATOR 1
#elif TARGET_OS_IPHONE
#define IS_SIMULATOR 0
#endif



//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))


//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)




//在Main线程上运行
#define DISPATCH_ON_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

//主线程上Demo
//DISPATCH_ON_MAIN_THREAD(^{
//更新UI
//})



//在Global Queue上运行
#define DISPATCH_ON_GLOBAL_QUEUE_HIGH(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), globalQueueBlocl);
#define DISPATCH_ON_GLOBAL_QUEUE_DEFAULT(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);
#define DISPATCH_ON_GLOBAL_QUEUE_LOW(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), globalQueueBlocl);
#define DISPATCH_ON_GLOBAL_QUEUE_BACKGROUND(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), globalQueueBlocl);


#pragma mark - 单例宏

/**使用单例的类 只要在.h  interfaceSingleton(类名)   ;
 使用单例的类 只要在.m  implementationSingleton(类名)
 一定要写类名,不然.m中编译不通过
 */

//注意不要加错宏名
//.h是interface开头的宏(记得后面加上分号;)  如:interfaceSingleton(className)
//.m是implement开头的宏(后面不用分号)
//.h
#define interfaceSingleton(name)  +(instancetype)share##name;\
+(void)clear; \

//.m
#if __has_feature(objc_arc)
// ARC
#define implementationSingleton(name)  \
static dispatch_once_t onceToken;\
+ (instancetype)share##name \
{ \
name *instance = [[self alloc] init]; \
return instance; \
} \
static name *_instance = nil; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
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
} \
+(void)clear{ \
onceToken=0; \
}\

#else

// MRC
#define implementationSingleton(name)  \
+ (instancetype)share##name \
{ \
name *instance = [[self alloc] init]; \
return instance; \
} \
static name *_instance = nil; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
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
} \
- (oneway void)release \
{ \
} \
- (instancetype)retain \
{ \
return _instance; \
} \
- (id)autorelease \
{ \
return _instance; \
} \
- (NSUInteger)retainCount \
{ \
return  MAXFLOAT; \
}
#endif









#pragma mark - 方法交换

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



#endif /* TTMacros_h */


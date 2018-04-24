//
//  NetDataModel.h
//  testproject
//
//  Created by apple on 2018/3/30.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TTSourceConfig.h"
#import "AFNetworking.h"
//方便打印模型
#import "NSObject+tt_PrintProperty.h"



@interface NetDataModel : NSObject


typedef void (^NetWorkSuccess)(BOOL isCatch,NetDataModel * model,NSMutableArray <NSObject *>*modelArr,id responseObject);
typedef void (^NetWorkFailure)(NSError *error,NSString *errorStr,NSString * status);
typedef void (^NetWorkParmsBlock)(NetDataModel* ParmsModel);

typedef void (^NetWorkExtblock)(void);
typedef void (^NetWorkAFNconfig)(AFHTTPSessionManager * AFNmgr);
typedef void (^NetWorkParmsFillter)(NSMutableDictionary * dict);
typedef void (^NetWorkProgressError)(NSString *text);

typedef void (^NetWorkEachStatusKeyBlock)(void);

#pragma mark - ---- configure ----


/**
 统一的afn处理
 */
+(void)networkConfigureNetWorkAFNconfig:(NetWorkAFNconfig)NetWorkAFNconfigblock;
//配置证书 https
+(void)networkConfigureNetWorkAFNcer:(NSString *)cerName;

/**
 统一的参数处理
 */
+(void)networkConfigureParmsFillter:(NetWorkParmsFillter)netWorkParmsFillterblock;

/**
请求提示控件
 */
+(void)networkConfigureProgress:(NetWorkProgressError)networkConfigureProgressblock;

/**
正式服和测试服 的 ip
 */
+(void)networkConfigureIP:(NSString *)ip test:(NSString *)testIp ext:(NetWorkExtblock)block;

/**
 如:
 statusKeyName @"code" //状态码字段
 dataKeyName @"data"  //数据字段
 msgKeyName @"msg"       //提示字段
 */
+(void)networkConfigureStatusKeyName:(NSString *)statusKey dataKeyName:(NSString *)dataKey msgKeyName:(NSString *)msgKey;

/**
配置请求成功是哪个
 */
+(void)networkConfigureStatusSuceessKey:(NSString *)sucessKey;

/**
 其他状态值的处理
 */
+(void)networkConfigureStatusOtherKey:(NSString *)OtherKey block:(NetWorkEachStatusKeyBlock)block;



#pragma mark -POST

+ (void)POST_idPrams_Progress:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(id)parms progress:(void (^)(NSProgress *progress))progress success:(NetWorkSuccess)success failure:(NetWorkFailure)failure;

+ (void)POST_defaultProgress:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(NetWorkParmsBlock)parmsBlock progress:(void (^)(NSProgress *progress))progress success:(NetWorkSuccess)success failure:(NetWorkFailure)failure;

+ (void)POST_default:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(NetWorkParmsBlock)parmsBlock success:(NetWorkSuccess)success failure:(NetWorkFailure)failure;



#pragma mark -GET
+ (void)GET_idPrams_Progress:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(id)parms progress:(void (^)(NSProgress *progress))progress success:(NetWorkSuccess)success failure:(NetWorkFailure)failure;

+ (void)GET_defaultProgress:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(NetWorkParmsBlock)parmsBlock progress:(void (^)(NSProgress *progress))progress success:(NetWorkSuccess)success failure:(NetWorkFailure)failure;

+ (void)GET_default:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(NetWorkParmsBlock)parmsBlock success:(NetWorkSuccess)success failure:(NetWorkFailure)failure;


#pragma mark -POST images
+ (void)POST_imgs:(NSString *)URLString parameters:(NetWorkParmsBlock)parmsBlock IsShowHud:(BOOL)isshowhud formData:(void (^)(id<AFMultipartFormData> formData))block progress:(void (^)(NSProgress *uploadProgress))progress success:(NetWorkSuccess)success failure:(NetWorkFailure)failure;




#pragma mark - ---- 获取当前请求的URL ----
+(NSString *)GetBaseURL;

@end




#define NetDataModelOverride(datamodelName)\
\
\
\
typedef void (^Success_##datamodelName)(BOOL isCatch,datamodelName * model,NSMutableArray <datamodelName *>*modelArr,id responseObject);\
typedef void (^Failure_##datamodelName)(NSError *error,NSString *errorStr,NSString * status);\
typedef void (^ParmsBlock_##datamodelName)(datamodelName * ParmsModel);\
\
+ (void)POST_idPrams_Progress:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(id)parms progress:(void (^)(NSProgress *progress))progress success:(Success_##datamodelName)success failure:(Failure_##datamodelName)failure;\
\
+ (void)POST_defaultProgress:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(ParmsBlock_##datamodelName)parmsBlock progress:(void (^)(NSProgress *progress))progress success:(Success_##datamodelName)success failure:(Failure_##datamodelName)failure;\
\
+ (void)POST_default:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(ParmsBlock_##datamodelName)parmsBlock success:(Success_##datamodelName)success failure:(Failure_##datamodelName)failure;\
\
\
+ (void)GET_idPrams_Progress:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(id)parms progress:(void (^)(NSProgress *progress))progress success:(Success_##datamodelName)success failure:(Failure_##datamodelName)failure;\
\
+ (void)GET_defaultProgress:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(ParmsBlock_##datamodelName)parmsBlock progress:(void (^)(NSProgress *progress))progress success:(Success_##datamodelName)success failure:(Failure_##datamodelName)failure;\
\
+ (void)GET_default:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(ParmsBlock_##datamodelName)parmsBlock success:(Success_##datamodelName)success failure:(Failure_##datamodelName)failure;\
\
\
+ (void)POST_imgs:(NSString *)URLString parameters:(ParmsBlock_##datamodelName)parmsBlock IsShowHud:(BOOL)isshowhud formData:(void (^)(id<AFMultipartFormData> formData))block progress:(void (^)(NSProgress *uploadProgress))progress success:(Success_##datamodelName)success failure:(Failure_##datamodelName)failure;\

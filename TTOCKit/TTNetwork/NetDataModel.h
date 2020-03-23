//
//  NetDataModel.h
//  testproject
//
//  Created by apple on 2018/3/30.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
//方便打印模型
#import "NSObject+tt_PrintProperty.h"
@class NetDataModel;


#define NetDataModelOverride(datamodelName)\
\
\
\
typedef void (^Success_##datamodelName)(BOOL isCatch,datamodelName * model,NSMutableArray <datamodelName *>*modelArr,id responseObject);\
typedef void (^Failure_##datamodelName)(NSError *error,NSString *errorStr,NSString * status);\
typedef void (^ParmsBlock_##datamodelName)(datamodelName * ParmsModel);\
typedef void (^DatePagingRelativeBlock_##datamodelName)(datamodelName * model,id responseObject);\
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
\
\
+ (void)POST_HeadLoad:(NSString *)URLString ParmsBlock:(ParmsBlock_##datamodelName)parmsBlock reflashScrollView:(UIScrollView *)scrollView arrKeyBlock:(DatePagingRelativeBlock_##datamodelName)arrKeyBlock loadfinish:(void (^)(BOOL isSsucess,id responseObject))finishblock;\
\
+ (void)POST_FootLoad:(NSString *)URLString ParmsBlock:(ParmsBlock_##datamodelName)parmsBlock reflashScrollView:(UIScrollView *)scrollView arrKeyBlock:(DatePagingRelativeBlock_##datamodelName)arrKeyBlock loadfinish:(void (^)(BOOL isSsucess,id responseObject))finishblock;\
\
+ (void)GET_HeadLoad:(NSString *)URLString ParmsBlock:(ParmsBlock_##datamodelName)parmsBlock reflashScrollView:(UIScrollView *)scrollView arrKeyBlock:(DatePagingRelativeBlock_##datamodelName)arrKeyBlock loadfinish:(void (^)(BOOL isSsucess,id responseObject))finishblock;\
\
+ (void)GET_FootLoad:(NSString *)URLString ParmsBlock:(ParmsBlock_##datamodelName)parmsBlock reflashScrollView:(UIScrollView *)scrollView arrKeyBlock:(DatePagingRelativeBlock_##datamodelName)arrKeyBlock loadfinish:(void (^)(BOOL isSsucess,id responseObject))finishblock;\






@interface UIScrollView (DataPaging)
@property (strong, nonatomic) id ttReflashModel;
@property (strong, nonatomic) NSNumber *ttRefleshPage;

@end


@interface NetDataModel : NSObject


typedef void (^NetWorkSuccess)(BOOL isCatch,NetDataModel * model,NSMutableArray <NSObject *>*modelArr,id responseObject);
typedef void (^NetWorkFailure)(NSError *error,NSString *errorStr,NSString * status);
typedef void (^NetWorkParmsBlock)(NetDataModel* ParmsModel);

typedef void (^NetWorkDatePagingRelativeBlock)(id model,id responseObject);


typedef void (^NetWorkExtblock)(void);
typedef void (^NetWorkAFNconfig)(AFHTTPSessionManager * AFNmgr);
typedef void (^NetWorkParmsFillter)(NSMutableDictionary * dict);
typedef void (^NetWorkProgressError)(NSString *text);

typedef void (^NetWorkEachStatusKeyBlock)(void);

typedef void (^NetWorkEachStatusKeyBlockFromTask)(NSURLSessionDataTask * task);


typedef NS_ENUM(NSInteger, NetWorkRequestType) {
    
    NetWorkRequestTypeGET=1,
    NetWorkRequestTypePOST=2,
    NetWorkRequestTypePUT=3,
    NetWorkRequestTypePATCH=4,
    NetWorkRequestTypeDELETE=5,
    NetWorkRequestTypeUPLOAD=6
    
    
    
};
#pragma mark - ---- configure ----


/**
 统一的afn处理
 */
+(void)networkConfigureNetWorkAFNconfig:(NetWorkAFNconfig)netWorkAFNconfigblock;
//配置证书 https
+(void)networkConfigureNetWorkAFNcer:(NSString *)cerName;

/**
 统一的参数处理
 */
+(void)networkConfigureParmsFillter:(NetWorkParmsFillter)netWorkParmsFillterblock;

/**
 错误的时候,请求提示控件
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
 
 并且支持多层嵌套 如
 dataKeyName @"xxx.app.data"  //数据字段
 */
+(void)networkConfigureStatusKeyName:(NSString *)statusKey dataKeyName:(NSString *)dataKey msgKeyName:(NSString *)msgKey;

/**
 配置请求成功是哪个
 */
+(void)networkConfigureStatusSuceessKey:(NSString *)sucessKey;

/**
 其他状态值的处理
 */
+(void)networkConfigureStatusOtherKey:(NSString *)OtherKey block:(NetWorkEachStatusKeyBlock)block NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, "如果需要过滤某些请求的处理请用networkConfigureStatusOtherKeyFromTask");
+(void)networkConfigureStatusOtherKeyFromTask:(NSString *)OtherKey block:(NetWorkEachStatusKeyBlockFromTask)block;


/**
 分页时候的上传参数:默认是@"page"
 */
+(void)networkConfigureDataPagingPageKeyName:(NSString *)pageKeyName;


/**
 是否打印
 */
+(void)networkConfigureLog_logParms:(BOOL)islogPrams logResult:(BOOL)islogResult;


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



#pragma mark - dataPaging 分页
+ (void)POST_HeadLoad:(NSString *)URLString ParmsBlock:(NetWorkParmsBlock)parmsBlock reflashScrollView:(UIScrollView *)scrollView arrKeyBlock:(NetWorkDatePagingRelativeBlock)arrKeyBlock loadfinish:(void (^)(BOOL isSsucess,id responseObject))finishblock;

+ (void)POST_FootLoad:(NSString *)URLString ParmsBlock:(NetWorkParmsBlock)parmsBlock reflashScrollView:(UIScrollView *)scrollView arrKeyBlock:(NetWorkDatePagingRelativeBlock)arrKeyBlock loadfinish:(void (^)(BOOL isSsucess,id responseObject))finishblock;

+ (void)GET_HeadLoad:(NSString *)URLString ParmsBlock:(NetWorkParmsBlock)parmsBlock reflashScrollView:(UIScrollView *)scrollView arrKeyBlock:(NetWorkDatePagingRelativeBlock)arrKeyBlock loadfinish:(void (^)(BOOL isSsucess,id responseObject))finishblock;

+ (void)GET_FootLoad:(NSString *)URLString ParmsBlock:(NetWorkParmsBlock)parmsBlock reflashScrollView:(UIScrollView *)scrollView arrKeyBlock:(NetWorkDatePagingRelativeBlock)arrKeyBlock loadfinish:(void (^)(BOOL isSsucess,id responseObject))finishblock;


#pragma mark - ---- 获取当前请求的URL ----
+(NSString *)GetBaseURL;

+(AFHTTPSessionManager *)GetAFNManager;
+(id)parseResponseObject:(id)responseObject;


@end



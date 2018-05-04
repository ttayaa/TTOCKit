//
//  Network.m
//  testproject
//
//  Created by apple on 2018/3/30.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import "NetDataModel.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "TTDataConfig.h"


#define hScreenWidth [UIScreen mainScreen].bounds.size.width
#define hScreenHeight [UIScreen mainScreen].bounds.size.height
#define weakify( x )  __weak __typeof__(x) __weak_##x##__ = x;
#define normalize( x ) __typeof__(x) x = __weak_##x##__;



@implementation UIScrollView (DataPaging)
@dynamic ttRefleshPage;
-(NSNumber *)ttRefleshPage
{
    NSNumber *ttRefleshPage = objc_getAssociatedObject(self, @selector(ttRefleshPage));
    if (!ttRefleshPage) {
        ttRefleshPage = @(1);
        objc_setAssociatedObject(self, @selector(ttRefleshPage), ttRefleshPage, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return ttRefleshPage;
}
-(void)setTtRefleshPage:(NSNumber *)ttRefleshPage
{
    objc_setAssociatedObject(self, @selector(ttRefleshPage), ttRefleshPage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@dynamic ttReflashModel;
-(id)ttReflashModel
{
    return  objc_getAssociatedObject(self, @selector(ttReflashModel));
}
-(void)setTtReflashModel:(id)ttReflashModel
{
    objc_setAssociatedObject(self, @selector(ttReflashModel), ttReflashModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end





@implementation NetDataModel



#pragma mark - ---- 服务器切换 ----

static AFHTTPSessionManager  * ShareAfnSessionMgr;
static NSString * AFNcerName;


static NetWorkExtblock NetWorkExtblockblock;
static NetWorkAFNconfig NetWorkAFNconfigblock;
static NetWorkParmsFillter NetWorkParmsFillterblock;
static NetWorkProgressError NetWorkProgressblock;
static NSString * statusKeyName;
static NSString * dataKeyName;
static NSString * msgKeyName;

static NSMutableDictionary * statusKeyBlockDict;
static NSString * sucessCode;


static NSString * ttReflashPageKey;

static BOOL NetWorklogRequestParms;
static BOOL NetWorklogResponseResult;

//使用默认地址
+(void)load
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseAFN:) name:@"KNOTIFICATION_CHOOSEIP" object:nil];
    
    statusKeyName = @"code"; //状态码字段
    dataKeyName = @"data";  //数据字段
    msgKeyName = @"msg";       //提示字段
    
    statusKeyBlockDict = [NSMutableDictionary dictionary];
    
    sucessCode = @"1";
    
    ttReflashPageKey = @"page";
}
+(void)chooseAFN:(NSNotification *)noty
{
    
    
    //    if ([noty.object[0] hasPrefix:@"dragonB"]) {
    //设置AFN
    ShareAfnSessionMgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:noty.object[1]]];
    //    //后台返回二进制 json就注释掉
    //    ShareAfnSessionMgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    ShareAfnSessionMgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"text/javascript", nil];
    ShareAfnSessionMgr.requestSerializer.timeoutInterval = 20;
    
    //        如果需要可以在这里添加请求头
    //        [ShareAfnSessionMgr.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"X-Requested-With"];
    //        [ShareAfnSessionMgr.requestSerializer setValue:@"2" forHTTPHeaderField:@"from"];
    //        [ShareAfnSessionMgr.requestSerializer setValue:[self getCurrentVersion] forHTTPHeaderField:@"appv"];
    
    if ([noty.object[1] hasPrefix:@"https"]) {
        
        if (AFNcerName.length>0) {
            ShareAfnSessionMgr.securityPolicy     = [self customSecurityPolicy];
        }
    }
    
    if (NetWorkAFNconfigblock) {
        NetWorkAFNconfigblock(ShareAfnSessionMgr);
    }
}





#pragma mark - ---- configure ----

//+(void)networkConfigureParmsModelName:(NSString *)ParmsModelName DataModelName:(NSString *)DataModelName
//{
//    parmsModelName = ParmsModelName;
//    dataModelName = DataModelName;
//}


+(void)networkConfigureNetWorkAFNconfig:(NetWorkAFNconfig)NetWorkAFNconfigblock
{
    NetWorkAFNconfigblock = NetWorkAFNconfigblock;
}

+(void)networkConfigureNetWorkAFNcer:(NSString *)cerName
{
    if([cerName containsString:@"."])
    {
        AFNcerName = cerName;
        
        if (AFNcerName.length>0) {
            ShareAfnSessionMgr.securityPolicy     = [self customSecurityPolicy];
        }
    }
    else
    {
        @throw [NSException exceptionWithName:@"Certificate_Error" reason:@"您的证书必须有.xxx(如xxx.cer结尾)" userInfo:nil];
    }
}

+(void)networkConfigureParmsFillter:(NetWorkParmsFillter)netWorkParmsFillterblock
{
    NetWorkParmsFillterblock = netWorkParmsFillterblock;
}
+(void)networkConfigureProgress:(NetWorkProgressError)networkConfigureProgressblock
{
    NetWorkProgressblock = networkConfigureProgressblock;
}
+(void)networkConfigureIP:(NSString *)ip test:(NSString *)testIp ext:(NetWorkExtblock)block
{
    [DebugMange addIpModel_toIPArr:[IPModel ipDescWith:ip name:@"正式服务器" flagName:@"ZS"]];
    //testapi.zcb365.cn
    [DebugMange addIpModel_toIPArr:[IPModel ipDescWith:testIp name:@"测试服务器" flagName:@"CS"]];
    
    [DebugMange show:^(NSMutableArray<IPModel *> *IpArr, NSInteger index) {
        
        //正式服点击
        if (index==0) {
            [IpArr enumerateObjectsUsingBlock:^(IPModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.flagName isEqualToString:@"ZS"]) {
                    //发通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_CHOOSEIP object:@[obj.flagName,obj.urlstr]];
                    
                    NSLog(@"当前为:%@",obj.name);
                    [self ProgressShowTip:@[[NSString stringWithFormat:@"当前为:%@",obj.name],@(3)]];
                }
            }];
        }
        //测试服点击
        if (index==1) {
            [IpArr enumerateObjectsUsingBlock:^(IPModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj.flagName isEqualToString:@"CS"]) {
                    //发通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_CHOOSEIP object:@[obj.flagName,obj.urlstr]];
                    
                    NSLog(@"当前为:%@",obj.name);
                    [self ProgressShowTip:@[[NSString stringWithFormat:@"当前为:%@",obj.name],@(3)]];
                }
            }];
        }
        
        
        if (index==2) {
            
            block();
        }
        
        
        
    }];
    
    
    
    
    //默认使用正式服
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_CHOOSEIP object:@[@"ZS",ip]];
    NSLog(@"当前为:正式服务器");
    
    
#ifdef DEBUG
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self ProgressShowTip:@[@"当前为:正式服务器",@(3)]];
    });
    
    
#else
    
    [DebugMange dissmis];
    
#endif
    
}

+(void)networkConfigureStatusKeyName:(NSString *)statusKey dataKeyName:(NSString *)dataKey msgKeyName:(NSString *)msgKey
{
    statusKeyName = statusKey;
    dataKeyName = dataKey;
    msgKeyName = msgKey;
}
/**
 配置请求成功是哪个
 */
+(void)networkConfigureStatusSuceessKey:(NSString *)sucessKey
{
    sucessCode = sucessKey;
}

/**
 其他状态值的处理
 */
+(void)networkConfigureStatusOtherKey:(NSString *)OtherKey block:(NetWorkEachStatusKeyBlock)block
{
    [statusKeyBlockDict addEntriesFromDictionary:@{
                                                   OtherKey:
                                                       block
                                                   }];
}

/**
 分页时候的上传参数:默认是@"page"
 */
+(void)networkConfigureDataPagingPageKeyName:(NSString *)pageKeyName
{
    ttReflashPageKey = pageKeyName;
}
/**
 是否打印
 */
+(void)networkConfigureLog_logParms:(BOOL)islogPrams logResult:(BOOL)islogResult
{
    
}


#pragma mark - ---- public ----
+(NSString *)GetBaseURL
{
    return [ShareAfnSessionMgr.baseURL absoluteString];
}

#pragma mark - ---- private ----
+(NSMutableDictionary *)parmsBlocktoDict:(id)parms Class:(Class)doclass
{
    
    @autoreleasepool {
        NSDictionary * dict;
        NetDataModel * parameter = [doclass new];
        
        if (parms) {
            
            if ([parms isKindOfClass:[NSDictionary class]]) {
                dict = parms;
            }
            else
            {
                NetWorkParmsBlock block = parms;
                block(parameter);
                NSError *error = nil;
                NSString *jsonString = [parameter yy_modelToJSONString];
                NSData *data         = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                dict = [NSJSONSerialization JSONObjectWithData:data?data:[NSData new] options:NSJSONReadingMutableContainers error:&error];
            }
            
        }
        
        return [NSMutableDictionary dictionaryWithDictionary:dict];
    }
}

+(NSMutableDictionary *)dictToDictInBlock:(NetWorkParmsFillter)NetWorkParmsFillterblock parmsDict:(NSMutableDictionary *)dict
{
    @autoreleasepool {
        if (NetWorkParmsFillterblock) {
            NetWorkParmsFillterblock(dict);
            NSError *error = nil;
            NSString *jsonString = [self JSONStringFromDict:dict];
            NSData *data         = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            dict = [NSJSONSerialization JSONObjectWithData:data?data:[NSData new] options:NSJSONReadingMutableContainers error:&error];
        }
        return [NSMutableDictionary dictionaryWithDictionary:dict];
    }
}



+(NSString *)JSONStringFromDict:(NSDictionary *)dict{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (jsonData == nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", dict, error);
#endif
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}


+(id)getDictValueFromDotKeyStr:(NSString *)keyStr inDict:(NSDictionary *)dict
{
    @autoreleasepool {
        __block id temp;
        [[keyStr componentsSeparatedByString:@"."] enumerateObjectsUsingBlock:^(NSString * path, NSUInteger idx, BOOL * _Nonnull stop) {
            temp = dict[path];
        }];
        return temp;
    }
}



#pragma mark -POST
+ (void)POST_idPrams_Progress:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(id)parms progress:(void (^)(NSProgress *progress))progress success:(NetWorkSuccess)success failure:(NetWorkFailure)failure
{
    @autoreleasepool {
        
        
        NSDictionary * dict;
        if ([parms isKindOfClass:[NetDataModel class]]) {
            NSError *error = nil;
            NSString *jsonString = [parms yy_modelToJSONString];
            NSData *data         = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            dict = [NSJSONSerialization JSONObjectWithData:data?data:[NSData new] options:NSJSONReadingMutableContainers error:&error];
        }
        else if([parms isKindOfClass:[NSDictionary class]])
        {
            dict = parms;
        }
        else{
            NetDataModel * parameter = [self.class new];
            NetWorkParmsBlock block = parms;
            block(parameter);
            NSError *error = nil;
            NSString *jsonString = [parameter yy_modelToJSONString];
            NSData *data         = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            dict = [NSJSONSerialization JSONObjectWithData:data?data:[NSData new] options:NSJSONReadingMutableContainers error:&error];
        }
        
        
        //根据服务器要求添加一些参数
        NSMutableDictionary *newDict = [self dictToDictInBlock:NetWorkParmsFillterblock parmsDict:[NSMutableDictionary dictionaryWithDictionary:dict]];
        
        
        //打印请求的接口信息
#ifdef DEBUG
        //        NSLog(@"URL=%@%@",ShareAfnSessionMgr.baseURL,URLString);
        if(NetWorklogRequestParms)
        {
            NSLog(@"parameters======%@",newDict);
        }
#endif
        
        
        __block BOOL catchFlag = value;
        __block NSString *saveKey =[NSString stringWithFormat:@"%@%@",[self JSONStringFromDict:dict],URLString];
        
        if (catchFlag) {
            
            //读取缓存中是否有key
            id data = [SandboxTools unarchiveSystemObjectKey:saveKey];
            if (data) {
                data = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                [self commonDoResponseObject:data success:success failure:failure isCatch:YES isShowHud:isshowhud];
            }
        }
        
        //检测用户是否设置ip
        if (![self checkNetworkIPConfig:failure]) {
            return;
        }
        
        [ShareAfnSessionMgr POST:URLString parameters:newDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //打印请求的结果信息
#ifdef DEBUG
            if(NetWorklogResponseResult)
            {
                NSLog(@"parameters======%@",responseObject);
            }
#endif
            
            responseObject = [self parseResponseObject:responseObject];
            
            //检测用户是否设置状态码
            if (![self checkNetworkCodeConfig:responseObject failure:failure]) {
                return;
            }
            
//            NSString *status = [NSString stringWithFormat:@"%@",responseObject[statusKeyName]];
            NSString *status = [NSString stringWithFormat:@"%@",[self getDictValueFromDotKeyStr:statusKeyName inDict:responseObject]];
            
            if ([status isEqualToString:sucessCode]) {//请求成功
                if (catchFlag) {
                    //存入缓存
                    [[NSUserDefaults standardUserDefaults] setObject:[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil] forKey:saveKey];
                }
            }
            
            [self commonDoResponseObject:responseObject success:success failure:failure isCatch:NO isShowHud:isshowhud];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error,@"请检查您的网络!",@"404");
            
            if (isshowhud) {
                
                if (NetWorkProgressblock) {
                    NetWorkProgressblock(@"请检查您的网络!");
                }
                else
                {
                    [self ProgressShowTip:@[@"请检查您的网络!",@"3"]];
                }
            }
            
        }];
        
        
    }
}

+ (void)POST_defaultProgress:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(NetWorkParmsBlock)parmsBlock progress:(void (^)(NSProgress *progress))progress success:(NetWorkSuccess)success failure:(NetWorkFailure)failure
{
    [self POST_idPrams_Progress:URLString CacheIf:value IsShowHud:isshowhud  parameters:parmsBlock progress:progress success:success failure:failure];
}


+ (void)POST_default:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(NetWorkParmsBlock)parmsBlock success:(NetWorkSuccess)success failure:(NetWorkFailure)failure
{
    [self POST_idPrams_Progress:URLString CacheIf:value IsShowHud:isshowhud  parameters:parmsBlock progress:nil success:success failure:failure];
}


#pragma mark -GET
+ (void)GET_idPrams_Progress:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(id)parms progress:(void (^)(NSProgress *progress))progress success:(NetWorkSuccess)success failure:(NetWorkFailure)failure
{
    @autoreleasepool {
        
        
        NSDictionary * dict;
        if ([parms isKindOfClass:[NetDataModel class]]) {
            NSError *error = nil;
            NSString *jsonString = [parms yy_modelToJSONString];
            NSData *data         = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            dict = [NSJSONSerialization JSONObjectWithData:data?data:[NSData new] options:NSJSONReadingMutableContainers error:&error];
        }
        else if([parms isKindOfClass:[NSDictionary class]])
        {
            dict = parms;
        }
        else{
            NetDataModel * parameter = [self.class new];
            NetWorkParmsBlock block = parms;
            block(parameter);
            NSError *error = nil;
            NSString *jsonString = [parameter yy_modelToJSONString];
            NSData *data         = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            dict = [NSJSONSerialization JSONObjectWithData:data?data:[NSData new] options:NSJSONReadingMutableContainers error:&error];
        }
        
        
        //根据服务器要求添加一些参数
        NSMutableDictionary *newDict = [self dictToDictInBlock:NetWorkParmsFillterblock parmsDict:[NSMutableDictionary dictionaryWithDictionary:dict]];
        
        
        //打印请求的接口信息
#ifdef DEBUG
        //        NSLog(@"URL=%@%@",ShareAfnSessionMgr.baseURL,URLString);
        if(NetWorklogRequestParms)
        {
            NSLog(@"parameters======%@",newDict);
        }
#endif
        
        
        __block BOOL catchFlag = value;
        __block NSString *saveKey =[NSString stringWithFormat:@"%@%@",[self JSONStringFromDict:dict],URLString];
        
        if (catchFlag) {
            
            //读取缓存中是否有key
            id data = [SandboxTools unarchiveSystemObjectKey:saveKey];
            if (data) {
                data = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                [self commonDoResponseObject:data success:success failure:failure isCatch:YES isShowHud:isshowhud];
            }
        }
        
        //检测用户是否设置ip
        if (![self checkNetworkIPConfig:failure]) {
            return;
        }
        
        [ShareAfnSessionMgr GET:URLString parameters:newDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //打印请求的结果信息
#ifdef DEBUG
            if(NetWorklogResponseResult)
            {
                NSLog(@"parameters======%@",responseObject);
            }
#endif
            
            responseObject = [self parseResponseObject:responseObject];
            
            //检测用户是否设置状态码
            if (![self checkNetworkCodeConfig:responseObject failure:failure]) {
                return;
            }
            
//            NSString *status = [NSString stringWithFormat:@"%@",responseObject[statusKeyName]];
             NSString *status = [NSString stringWithFormat:@"%@",[self getDictValueFromDotKeyStr:statusKeyName inDict:responseObject]];
            
            
            if ([status isEqualToString:sucessCode]) {//请求成功
                if (catchFlag) {
                    //存入缓存
                    [[NSUserDefaults standardUserDefaults] setObject:[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil] forKey:saveKey];
                }
            }
            
            [self commonDoResponseObject:responseObject success:success failure:failure isCatch:NO isShowHud:isshowhud];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error,@"请检查您的网络!",@"404");
            
            if (isshowhud) {
                
                if (NetWorkProgressblock) {
                    NetWorkProgressblock(@"请检查您的网络!");
                }
                else
                {
                    [self ProgressShowTip:@[@"请检查您的网络!",@"3"]];
                }
            }
            
        }];
        
        
    }
}

+ (void)GET_defaultProgress:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(NetWorkParmsBlock)parmsBlock progress:(void (^)(NSProgress *progress))progress success:(NetWorkSuccess)success failure:(NetWorkFailure)failure
{
    [self GET_idPrams_Progress:URLString CacheIf:value IsShowHud:isshowhud  parameters:parmsBlock progress:progress success:success failure:failure];
    
}

+ (void)GET_default:(NSString *)URLString CacheIf:(BOOL)value IsShowHud:(BOOL)isshowhud parameters:(NetWorkParmsBlock)parmsBlock success:(NetWorkSuccess)success failure:(NetWorkFailure)failure
{
    [self GET_idPrams_Progress:URLString CacheIf:value IsShowHud:isshowhud  parameters:parmsBlock progress:nil success:success failure:failure];
}

#pragma mark -POST images
+ (void)POST_imgs:(NSString *)URLString parameters:(NetWorkParmsBlock)parmsBlock IsShowHud:(BOOL)isshowhud formData:(void (^)(id<AFMultipartFormData> formData))block progress:(void (^)(NSProgress *uploadProgress))progress success:(NetWorkSuccess)success failure:(NetWorkFailure)failure
{
    //将block转成dict
//    NSMutableDictionary *dict = [self parmsBlocktoDict:parmsBlock ];
    
    NSMutableDictionary *dict = [self parmsBlocktoDict:parmsBlock Class:self.class];
    
    //根据服务器要求添加一些参数
    //        NSMutableDictionary *newDict = [NetRuleManager setupData:dict];
    NSMutableDictionary *newDict = [self dictToDictInBlock:NetWorkParmsFillterblock parmsDict:dict];
    
    
    
    
    //    NSMutableDictionary *imgDic = [NSMutableDictionary dictionary ];
    //    if (images.count>0) {
    //        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
    //            //缩放图片
    //            UIImage *imgScale = image;
    //            //            = [self scaleFromImage: toSize:CGSizeMake(800.0f, 600.0f)];
    //            CGFloat quality = 0.1;
    //            NSData *imgData = UIImageJPEGRepresentation(imgScale, quality);
    //            [imgDic setObject:imgData forKey:[NSString stringWithFormat:@"tt%ld",idx+1]];
    //
    //        }];
    //    }
    //
    
    [ShareAfnSessionMgr POST:URLString parameters:newDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        block(formData);
        
        //        for (NSString *key in imgDic.allKeys) {
        //            NSData *data = [imgDic objectForKey:key];
        //
        //            [formData appendPartWithFileData:data name:@"file" fileName:@"img_shenfenzheng.jpg" mimeType:@"image/jpeg"];
        //        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
        //        NSString *result = [NSString stringWithFormat:@"图片上传进度：%0.0f%%",100.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount];
        //
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            if (imageArr.count>0) {
        //                //                CommonProgressSucess(result)
        //            }
        //        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        responseObject = [self parseResponseObject:responseObject];
        
        //检测用户是否设置状态码
        if (![self checkNetworkCodeConfig:responseObject failure:failure]) {
            return;
        }
        
        
        [self commonDoResponseObject:responseObject success:success failure:failure isCatch:NO isShowHud:isshowhud];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error,@"请检查您的网络!",@"404");
        
        if (isshowhud) {
            if (NetWorkProgressblock) {
                NetWorkProgressblock(@"请检查您的网络!");
            }
            else
            {
                [self ProgressShowTip:@[@"请检查您的网络!",@"3"]];
            }
        }
    }];
}



+(void)commonDoResponseObject:(id )responseObject success:(NetWorkSuccess)success failure:(NetWorkFailure)failure isCatch:(BOOL)value isShowHud:(BOOL)isshowhud
{
    NSDictionary *resultDict = responseObject;
    
//    NSString *status = [NSString stringWithFormat:@"%@",responseObject[statusKeyName]];
//
    NSString *status = [NSString stringWithFormat:@"%@",[self getDictValueFromDotKeyStr:statusKeyName inDict:responseObject]];
    
    
    if ([status isEqualToString:sucessCode]) {//请求成功
        
        
        
        NSObject *model = nil;
        NSMutableArray <NSObject *>*resultmodelArray = [NSMutableArray array];
        if ([[self getDictValueFromDotKeyStr:dataKeyName inDict:responseObject] isKindOfClass:[NSArray class]]) {
            NSArray <NSObject *> *arr = [self getDictValueFromDotKeyStr:dataKeyName inDict:responseObject];
            [arr enumerateObjectsUsingBlock:^(NSObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSObject * resultmodel = [self yy_modelWithDictionary:[self getDictValueFromDotKeyStr:dataKeyName inDict:responseObject][idx]];
                [resultmodelArray addObject:resultmodel];
            }];
            
        }
        else if([[self getDictValueFromDotKeyStr:dataKeyName inDict:responseObject] isKindOfClass:[NSDictionary class]])
        {
            //            model = [NSObject<NetWorkDataModelProtool> tt_modelWithDictionary:responseObject[dataKeyName]];
            model = [self yy_modelWithDictionary:[self getDictValueFromDotKeyStr:dataKeyName inDict:responseObject]];
            
        }
        else//说明服务器没有数据的字段返回,但是还是请求成功了(比如获取短信验证码接口,只有status和message字段没有data字段)
        {
            
        }
        
        if (success) {
            
            success(value,model,resultmodelArray,resultDict);
        }
        
    }else {//token
        
//        [self doOtherStatus:[NSString stringWithFormat:@"%@",resultDict[statusKeyName]]];
        [self doOtherStatus:[NSString stringWithFormat:@"%@",[self getDictValueFromDotKeyStr:statusKeyName inDict:resultDict]]];
        
        
        failure(nil,[self getDictValueFromDotKeyStr:msgKeyName inDict:resultDict],status);
        
        if (isshowhud) {
            if (NetWorkProgressblock) {
                NetWorkProgressblock([self getDictValueFromDotKeyStr:msgKeyName inDict:resultDict]);
            }
            else
            {
                [self ProgressShowTip:@[[self getDictValueFromDotKeyStr:msgKeyName inDict:resultDict],@"2"]];
            }
        }
        
    }
    
}




#pragma -mark othercode
+(void)doOtherStatus:(NSString *)status{
    
    NetWorkEachStatusKeyBlock block = statusKeyBlockDict[status];
    
    if (block) {
        block();
    }
    
}
//+(void)login{
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"KNOTIFICATION_LOSSLOGIN" object:nil];
//
//}



//添加证书,Https必需需要
+ (AFSecurityPolicy *)customSecurityPolicy {
    
    // 先导入证书 证书由服务端生成，具体由服务端人员操作
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:AFNcerName ofType:nil]; //证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:certData, nil];
    return securityPolicy;
}


+(id)parseResponseObject:(id)responseObject
{
    @autoreleasepool {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            id responseObject1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //说明后台返回格式有误(如,写错，),尝试转string
            //这里只处理，的问题
            if (responseObject&&!responseObject1) {
                NSString * jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                
                //如果服务器返回带有unicode的值,先转成utf8
                jsonStr = [self stringByReplaceUnicode:jsonStr];
                
                
                jsonStr=  [jsonStr stringByReplacingOccurrencesOfString:@"，" withString:@","];
                
                
                
                NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            }
            else
            {
                responseObject = responseObject1;
            }
        }
        
        return responseObject;
    }
}

//处理返回的json中包含unicode导致无法解析
+(NSString *)stringByReplaceUnicode:(NSString *)string{
    
    @autoreleasepool {
        
        NSMutableString *convertedString = [string mutableCopy];
        
        [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0,convertedString.length)];
        
        CFStringRef transform = CFSTR("Any-Hex/Java");
        
        CFStringTransform(((__bridge CFMutableStringRef)convertedString),NULL,transform,YES);
        
        return convertedString;
    }
}

+(void)ProgressShowTip:(NSArray *)noty
{
    [[UIApplication sharedApplication].windows enumerateObjectsUsingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj endEditing:YES];
    }];
    
    NSString *msg =[NSString stringWithFormat:@"%@!",[noty firstObject]] ;
    CGFloat secoud = [[noty lastObject] floatValue];
    
    
    CGSize fixsize = CGSizeMake(hScreenWidth-120, MAXFLOAT);
    CGFloat height = [msg boundingRectWithSize:fixsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    
    UILabel *showlb = [[UILabel alloc] initWithFrame:CGRectMake(60, hScreenHeight*3/4-(height+30), hScreenWidth-120, height+30)];
    showlb.text = msg;
    
    showlb.numberOfLines = 0;
    showlb.layer.cornerRadius = 5;
    showlb.layer.masksToBounds = YES;
    showlb.layer.borderWidth = 1;
    showlb.layer.borderColor = [UIColor whiteColor].CGColor;
    
    showlb.textColor = [UIColor whiteColor];
    
    showlb.backgroundColor = [UIColor blackColor];
    
    showlb.textAlignment = NSTextAlignmentCenter;
    [[UIApplication sharedApplication].keyWindow addSubview:showlb];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(secoud * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [showlb removeFromSuperview];
    });
    
    
}


+(BOOL)checkNetworkIPConfig:(NetWorkFailure)failure
{
    if (ShareAfnSessionMgr.baseURL.absoluteString.length<1) {
        
        failure(nil,@"请您使用  networkConfigureIP test 方法来配置您的ip",@"你的NetWork配置不对(network_Confingure_Error)");
        
        return NO;
    }
    return YES;
}

+(BOOL)checkNetworkCodeConfig:(id)responseObject failure:(NetWorkFailure)failure
{
//    if (!responseObject[statusKeyName]) {
    if (![self getDictValueFromDotKeyStr:statusKeyName inDict:responseObject]) {

        failure(nil,@"请您使用  networkConfigureStatusKeyName dataKeyName msgKeyName  方法来配置您的statusKeyName",@"你的NetWork配置不对(network_Confingure_Error)");
        
        return NO;
    }
    if (![self getDictValueFromDotKeyStr:msgKeyName inDict:responseObject]) {
        
        failure(nil,@"请您使用  networkConfigureStatusKeyName: dataKeyName msgKeyName 方法来配置您的msgKeyName",@"你的NetWork配置不对(network_Confingure_Error)");
        return NO;
    }
//    if (!responseObject[dataKeyName]) {
//
//        failure(nil,@"请您使用  networkConfigureStatusKeyName dataKeyName msgKeyName  方法来配置您的dataKeyName",@"你的NetWork配置不对(network_Confingure_Error)");
//
//        return NO;
//    }

    return YES;
}






#pragma mark - dataPaging 分页
+ (void)POST_HeadLoad:(NSString *)URLString ParmsBlock:(NetWorkParmsBlock)parmsBlock reflashScrollView:(UIScrollView *)scrollView arrKeyBlock:(NetWorkDatePagingRelativeBlock)arrKeyBlock loadfinish:(void (^)(BOOL isSsucess,id responseObject))finishblock
{
    weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        normalize(self)
        
        [self ReflashPOST:URLString ParmsBlock:parmsBlock reflashScrollView:scrollView arrKeyBlock:arrKeyBlock Page:@(1) loadfinish:finishblock];
        
    });
}

+ (void)POST_FootLoad:(NSString *)URLString ParmsBlock:(NetWorkParmsBlock)parmsBlock reflashScrollView:(UIScrollView *)scrollView arrKeyBlock:(NetWorkDatePagingRelativeBlock)arrKeyBlock loadfinish:(void (^)(BOOL isSsucess,id responseObject))finishblock
{
    weakify(self)
    weakify(scrollView)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        normalize(self)
        normalize(scrollView)
        [self ReflashPOST:URLString ParmsBlock:parmsBlock reflashScrollView:scrollView arrKeyBlock:arrKeyBlock Page:scrollView.ttRefleshPage loadfinish:finishblock];
    });
}

+ (void)ReflashPOST:(NSString *)URLString ParmsBlock:(NetWorkParmsBlock)parmsBlock reflashScrollView:(UIScrollView *)scrollView arrKeyBlock:(NetWorkDatePagingRelativeBlock)arrKeyBlock Page:(NSNumber *)page loadfinish:(void (^)(BOOL isSsucess,id responseObject))finishblock
{
    __block NSNumber *tempPage = page;
    
    //矫正第一页数值
    if ([tempPage integerValue] ==0) {
        tempPage = @1;
    }
    
    scrollView.ttRefleshPage = tempPage;
    
    //将block转成dict
    NSMutableDictionary *dict = [self parmsBlocktoDict:parmsBlock Class:self.class];
    
    [dict addEntriesFromDictionary:@{
  ttReflashPageKey:scrollView.ttRefleshPage,
                                         }];
    
    weakify(scrollView)
    [self POST_idPrams_Progress:URLString CacheIf:0 IsShowHud:1 parameters:[self.class yy_modelWithDictionary:dict] progress:nil success:^(BOOL isCatch, NetDataModel *model, NSMutableArray<NSObject *> *modelArr, id responseObject) {
        
        finishblock(YES,responseObject);
        
        normalize(scrollView)
        if ([scrollView.ttRefleshPage integerValue]==1) {
            scrollView.ttReflashModel = model;
        }
        
        if ([scrollView.ttRefleshPage integerValue]>1) {
            arrKeyBlock(model);
        }
        
        scrollView.ttRefleshPage = @([scrollView.ttRefleshPage integerValue] + 1);
        
        if ([scrollView respondsToSelector:@selector(reloadData)]) {
            [scrollView performSelector:@selector(reloadData)];
        }
        
    } failure:^(NSError *error, NSString *errorStr, NSString *status) {
        finishblock(NO,@[error?error:@"",errorStr?errorStr:@"",status?status:@""]);
        //        [scrollView.headRefreshControl endRefreshing];
        //        [scrollView.footRefreshControl endRefreshing];
    }];
    

}



@end

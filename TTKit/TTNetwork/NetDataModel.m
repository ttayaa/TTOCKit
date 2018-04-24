//
//  Network.m
//  testproject
//
//  Created by apple on 2018/3/30.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import "NetDataModel.h"
#import "AFNetworking.h"
#import "NSDictionary+tt.h"
#import "SandboxTools.h"

#import "TTDataConfig.h"
#import "YYModel.h"

#define hScreenWidth [UIScreen mainScreen].bounds.size.width
#define hScreenHeight [UIScreen mainScreen].bounds.size.height


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



//使用默认地址
+(void)load
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseAFN:) name:@"KNOTIFICATION_CHOOSEIP" object:nil];
    
    statusKeyName = @"code"; //状态码字段
    dataKeyName = @"data";  //数据字段
    msgKeyName = @"msg";       //提示字段
    
    statusKeyBlockDict = [NSMutableDictionary dictionary];
    
    sucessCode = @"1";
    
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
        
        if (AFNcerName) {
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
    AFNcerName = cerName;
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




#pragma mark - ---- public ----
+(NSString *)GetBaseURL
{
    return [ShareAfnSessionMgr.baseURL absoluteString];
}

#pragma mark - ---- private ----
+(NSMutableDictionary *)parmsBlocktoDict:(id)parms
{
    
    @autoreleasepool {
        NSDictionary * dict;
        NetDataModel * parameter = [self.class new];
        
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
            NSString *jsonString = [dict tt_JSONString];
            NSData *data         = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            dict = [NSJSONSerialization JSONObjectWithData:data?data:[NSData new] options:NSJSONReadingMutableContainers error:&error];
        }
        return [NSMutableDictionary dictionaryWithDictionary:dict];
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
        NSLog(@"parameters======%@",newDict);
#endif
        
        
        __block BOOL catchFlag = value;
        __block NSString *saveKey =[NSString stringWithFormat:@"%@%@",[dict tt_JSONString],URLString];
        
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
            
            responseObject = [self parseResponseObject:responseObject];
            
            //检测用户是否设置状态码
            if (![self checkNetworkCodeConfig:responseObject failure:failure]) {
                return;
            }
            
            NSString *status = [NSString stringWithFormat:@"%@",responseObject[statusKeyName]];
            
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
        NSLog(@"parameters======%@",newDict);
#endif
        
        
        __block BOOL catchFlag = value;
        __block NSString *saveKey =[NSString stringWithFormat:@"%@%@",[dict tt_JSONString],URLString];
        
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
            
            responseObject = [self parseResponseObject:responseObject];
            
            //检测用户是否设置状态码
            if (![self checkNetworkCodeConfig:responseObject failure:failure]) {
                return;
            }
            
            NSString *status = [NSString stringWithFormat:@"%@",responseObject[statusKeyName]];
            
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
    NSMutableDictionary *dict = [self parmsBlocktoDict:parmsBlock];
    
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
    
    NSString *status = [NSString stringWithFormat:@"%@",responseObject[statusKeyName]];
    
    if ([status isEqualToString:sucessCode]) {//请求成功
        
        
        
        NSObject *model = nil;
        NSMutableArray <NSObject *>*resultmodelArray = [NSMutableArray array];
        if ([responseObject[dataKeyName] isKindOfClass:[NSArray class]]) {
            NSArray <NSObject *> *arr = responseObject[dataKeyName];
            [arr enumerateObjectsUsingBlock:^(NSObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSObject * resultmodel = [self yy_modelWithDictionary:responseObject[dataKeyName][idx]];
                [resultmodelArray addObject:resultmodel];
            }];
            
        }else{
            //            model = [NSObject<NetWorkDataModelProtool> tt_modelWithDictionary:responseObject[dataKeyName]];
            model = [self yy_modelWithDictionary:responseObject[dataKeyName]];
            
        }
        
        if (success) {
            
            success(value,model,resultmodelArray,resultDict);
        }
        
    }else {//token
        
        [self doOtherStatus:[NSString stringWithFormat:@"%@",resultDict[statusKeyName]]];
        
        failure(nil,resultDict[msgKeyName],status);
        
        if (isshowhud) {
            if (NetWorkProgressblock) {
                NetWorkProgressblock(resultDict[msgKeyName]);
            }
            else
            {
                [self ProgressShowTip:@[resultDict[msgKeyName],@"2"]];
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
    if (!responseObject[statusKeyName]) {
 
        failure(nil,@"请您使用  networkConfigureStatusKeyName dataKeyName msgKeyName  方法来配置您的statusKeyName",@"你的NetWork配置不对(network_Confingure_Error)");
        
        return NO;
    }
    if (!responseObject[dataKeyName]) {
 
        failure(nil,@"请您使用  networkConfigureStatusKeyName dataKeyName msgKeyName  方法来配置您的dataKeyName",@"你的NetWork配置不对(network_Confingure_Error)");
        
        return NO;
    }
    if (!responseObject[msgKeyName]) {
 
        failure(nil,@"请您使用  networkConfigureStatusKeyName: dataKeyName msgKeyName 方法来配置您的msgKeyName",@"你的NetWork配置不对(network_Confingure_Error)");
        return NO;
    }
    return YES;
}
@end

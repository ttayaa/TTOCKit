//
//  TTRouter.h
//  AFNetworking
//
//  Created by apple on 2020/8/11.
//

#import <Foundation/Foundation.h>
#import "UINavigationController+TTRouter.h"


#define TTRouterRegist(routerName) \
+(void)TRouter_##routerName:(id)parms callBack:(TRouterCallBackBlock)callback

//#define TTRouterRegist(routerName) \
//+(void)TRouter_##routerName:(id)parms callBack:(TRouterParmsBlock)callback

//传入路由名字 和 路由器名字
#define TTMutableRouterRegist(__routerName,__categoryName) \
+(void)TMutableRouter__##__routerName##__##__categoryName:(NSString*)routerName observer:(NSObject*)observer bindParms:(id)bindParms callParms:(id)callParms

typedef void (^TRouterCallBackBlock)(id model);


typedef void(^TTEventBlock)(id info);
@class TTEventSet;


@interface TTRouter : NSObject

+(void)call:(NSString*)routerName parms:(id)parms callBack:(TRouterCallBackBlock)callback;

+(void)mutableCall:(NSString*)routerName parms:(id)parms;

+(void)bindRouter:(NSString*)routerName observer:(NSObject *)observer bindParms:(id)bindParms;

@end


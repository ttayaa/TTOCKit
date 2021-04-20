//
//  TTRouter.m
//  AFNetworking
//
//  Created by apple on 2020/8/11.
//

#import "TTRouter.h"
#import <objc/runtime.h>
#import <objc/message.h>

#define weakify( x )  __weak __typeof__(x) __weak_##x##__ = x;
#define normalize( x ) __typeof__(x) x = __weak_##x##__;

#define tt_dispatch_queue_main_async_safe(block)\
if ([[NSThread currentThread] isMainThread]) {\
    block();\
} else {\
    dispatch_sync(dispatch_get_main_queue(), block);\
}

static NSMutableDictionary<NSString *,NSMapTable<NSString *,TTEventSet *> *> *TRouterEventDict;

@interface TTEventObject : NSObject
@property (nonatomic, copy) TTEventBlock eventBlock;
@end
@implementation TTEventObject
- (void)dealloc{}
@end

@interface TTEventSet : NSObject
@property (nonatomic, strong) NSMutableArray<TTEventObject *> *blockObjectArray;
@end
@implementation TTEventSet
- (NSMutableArray<TTEventObject *> *)blockObjectArray {
    if (_blockObjectArray == nil) {
        _blockObjectArray = [[NSMutableArray alloc] init];
    }
    return _blockObjectArray;
}
- (void)dealloc {

    tt_dispatch_queue_main_async_safe((^{
        
        for (NSString *notiName in TRouterEventDict) {
            NSMapTable *notiDic = [TRouterEventDict valueForKey:notiName];
            if (!notiDic) {
                continue;
            }
            NSString *observerKey = [NSString stringWithFormat:@"%p", self];
            TTEventSet *eventSet = [notiDic objectForKey:observerKey];
            [notiDic removeObjectForKey:observerKey];
            if (!eventSet) {
                continue;
            }
            [eventSet.blockObjectArray removeAllObjects];
        }
        
    }));

}
@end



@interface NSObject (TTRouter)
@property (nonatomic, strong) TTEventSet *eventSet;
-(void)eventName:(NSString*)eventName TTEvent:(TTEventBlock)event;
@end


@implementation NSObject (TTRouter)
-(void)eventName:(NSString*)eventName TTEvent:(TTEventBlock)event;
{
    if (!event) {
        return;
    }
    
    if (!eventName.length) {
        return;
    }
    
    tt_dispatch_queue_main_async_safe((^{

        if (!TRouterEventDict) {
              TRouterEventDict = [NSMutableDictionary dictionary];
           }
           NSMapTable *notiDict = TRouterEventDict[eventName];

        if (!notiDict) {
            notiDict = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
            [TRouterEventDict setValue:notiDict forKey:eventName];

        }
        NSString *observerKey = [NSString stringWithFormat:@"%p", self.eventSet];
        TTEventSet *eventSet = [notiDict objectForKey:observerKey];
        if (!eventSet) {
                   eventSet = self.eventSet;
                   [notiDict setObject:eventSet forKey:observerKey];
               }
        TTEventObject *blockObj = [[TTEventObject alloc] init];
        blockObj.eventBlock = event;
        [eventSet.blockObjectArray addObject:blockObj];
    }));
     
    
}

@dynamic eventSet;
- (TTEventSet *)eventSet
{
    TTEventSet *eventSet = objc_getAssociatedObject(self, @selector(eventSet));
      if (!eventSet) {
          eventSet = [[TTEventSet alloc] init];
          [self setEventSet:eventSet];
      }
    return eventSet;
}

- (void)setEventSet:(TTEventSet *)eventSet
{
    objc_setAssociatedObject(self, @selector(eventSet), eventSet, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end




@implementation TTRouter




+(void)call:(NSString*)routerName parms:(id)parms callBack:(TRouterCallBackBlock)callback;
{

    SEL sel =NSSelectorFromString([NSString stringWithFormat:@"TRouter_%@:callBack:",routerName]);
    if ([self respondsToSelector:sel]) {
        [self performSelector:sel withObject:parms withObject:callback];
    }

}

+(void)mutableCall:(NSString*)routerName parms:(id)parms
{
    tt_dispatch_queue_main_async_safe((^{
        
        NSMapTable *notiDict = [TRouterEventDict valueForKey:routerName];
        if (!notiDict) {
            return;
        }
        for (NSString *obsKey in notiDict) {
            TTEventSet *eventSet = [notiDict objectForKey:obsKey];
            for (TTEventObject *blockObj in eventSet.blockObjectArray) {
                blockObj.eventBlock(parms);
            }
        }
    }));
    

}


+(void)bindRouter:(NSString*)routerName observer:(NSObject *)observer bindParms:(id)bindParms
{
    NSArray*nameArr;
    if ([routerName containsString:@"_"])
        nameArr = [routerName componentsSeparatedByString:@"_"];
    else if ([routerName containsString:@","])
        nameArr = [routerName componentsSeparatedByString:@","];
    else
        @throw [NSException exceptionWithName:@"bindRouter_Error" reason:@"您必须传入 xxx_xxx或xxx,xxx  (您可以到您所在模块的路由分类中复制粘贴括号的内容 )" userInfo:nil];
    
    NSString*name1 = [nameArr.firstObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString*name2 = [nameArr.lastObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    NSString *selstr =[NSString stringWithFormat:@"TMutableRouter__%@__%@:observer:bindParms:callParms:",name1,name2];
    SEL sel = NSSelectorFromString(selstr);
        weakify(self)
        weakify(observer)
       if ([self respondsToSelector:sel]) {
           normalize(observer)
            normalize(self)
           [observer eventName:name1 TTEvent:^(id info) {
               normalize(observer)
               normalize(self)
               ((void (*)(id,SEL,id,NSObject *, id, id))(void *)objc_msgSend)(self, sel,name1,observer,bindParms,info);
           }];
       }
    
//[([((TTEventSet*)(TRouterEventDict[@"ishaveMsg"][@"0x6000038ed0f0"])) blockObjectArray][0]) eventBlock]
}


@end

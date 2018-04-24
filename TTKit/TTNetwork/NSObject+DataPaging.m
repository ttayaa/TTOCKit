//
//  NSObject+DataPaging.m
//  DragonB
//
//  Created by apple on 2018/1/16.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import "NSObject+DataPaging.h"
#import <objc/runtime.h>
#import "YYModel.h"

static NSInteger ttRefleshPageSize = 20;
//#define ttRefleshPageSize 20
#define weakify( x )  __weak __typeof__(x) __weak_##x##__ = x;
#define normalize( x ) __typeof__(x) x = __weak_##x##__;

@implementation NSObject (DataPaging)
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
-(NetDataModel *)ttReflashModel
{
    return  objc_getAssociatedObject(self, @selector(ttReflashModel));
    
}
-(void)setTtReflashModel:(NetDataModel *)ttReflashModel
{
    objc_setAssociatedObject(self, @selector(ttReflashModel), ttReflashModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic ttReflashPageKey;
-(NSString *)ttReflashPageKey
{
    
    NSString *ttReflashPageKey = objc_getAssociatedObject(self, @selector(ttReflashPageKey));
    if (!ttReflashPageKey) {
        ttReflashPageKey = @"page";
        objc_setAssociatedObject(self, @selector(ttReflashPageKey), ttReflashPageKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return ttReflashPageKey;
    
}
-(void)setTtReflashPageKey:(NSString *)ttReflashPageKey
{
    objc_setAssociatedObject(self, @selector(ttReflashPageKey), ttReflashPageKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



#pragma mark - ---- private ----
-(NSDictionary *)parmsBlocktoDict:(NetWorkParmsBlock)parmsBlock
{
    NSDictionary * dict;
    id parameter = [self.class new];
    
    
    
    if (parmsBlock) {
        parmsBlock(parameter);
        NSError *error = nil;
        NSString *jsonString = [parameter yy_modelToJSONString];
        NSData *data         = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    }
    
    return dict;
}


-(void)configurePageKey:(NSString *)pagekey pageSizeKey:(NSString *)pagesizekey
{
    //注意ttReflashPageKey 为懒加载 当没有值的时候是@"page"
    self.ttReflashPageKey = pagekey;
}



-(void)HeadLoad:(NSString *)URLString ParmsBlock:(NetWorkParmsBlock)parmsBlock reflashScrollView:(UIScrollView *)scrollView arrKeyBlock:(arrKeyBlock)arrKeyBlock;
{
    weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        normalize(self)
        
        [self ReflashPOST:URLString ParmsBlock:parmsBlock reflashScrollView:scrollView arrKeyBlock:arrKeyBlock Page:@(1)];
        
    });

}

-(void)FootLoad:(NSString *)URLString ParmsBlock:(NetWorkParmsBlock)parmsBlock reflashScrollView:(UIScrollView *)scrollView arrKeyBlock:(arrKeyBlock)arrKeyBlock
{
    weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        normalize(self)
        
        [self ReflashPOST:URLString ParmsBlock:parmsBlock reflashScrollView:scrollView arrKeyBlock:arrKeyBlock Page:self.ttRefleshPage];
       
    });
}




- (void)ReflashPOST:(NSString *)URLString ParmsBlock:(NetWorkParmsBlock)parmsBlock reflashScrollView:(UIScrollView *)scrollView arrKeyBlock:(arrKeyBlock)arrKeyBlock Page:(NSNumber *)page
{
    __block NSNumber *tempPage = page;
    
    //矫正第一页数值
    if ([tempPage integerValue] ==0) {
        tempPage = @1;
    }
    
    self.ttRefleshPage = tempPage;
    
    
    
    //将block转成dict
    NSDictionary *dict = [self parmsBlocktoDict:parmsBlock];
    
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [tempDict addEntriesFromDictionary:@{
                                         @"page":self.ttRefleshPage,
                                         }];
    
    
    weakify(self)
    [NetDataModel POST_idPrams_Progress:URLString CacheIf:0 IsShowHud:1 parameters:[NetDataModel yy_modelWithDictionary:tempDict] progress:nil success:^(BOOL isCatch, NetDataModel *model, NSMutableArray<NSObject *> *modelArr, id responseObject) {
        normalize(self)
        
        if ([self.ttRefleshPage integerValue]==1) {
            self.ttReflashModel = model;
        }
        
        if ([self.ttRefleshPage integerValue]>1) {
            arrKeyBlock(model);
        }
        
        self.ttRefleshPage = @([self.ttRefleshPage integerValue] + 1);
        
        
        if ([scrollView respondsToSelector:@selector(reloadData)]) {
            [scrollView performSelector:@selector(reloadData)];
        }
    } failure:^(NSError *error, NSString *errorStr, NSString *status) {
        //        [scrollView.headRefreshControl endRefreshing];
        //        [scrollView.footRefreshControl endRefreshing];
    }];
    
    

}

@end

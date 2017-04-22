//
//  UIViewController+Signal.m
//  elmsc
//
//  Created by apple on 16/8/5.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#import "UIViewController+LogDealloc.h"
#import <objc/runtime.h>

//输出调试
#ifdef DEBUG
#define ttLog(...) NSLog(__VA_ARGS__)
#else
#define ttLog(...)
#endif


@implementation UIViewController (LogDealloc)
/**
 *  将所有的方法交换到这个分类来释放
 */

////#if TARGET_IPHONE_SIMULATOR//模拟器
+ (void)load{
    Method deal = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
    Method Signal_deal = class_getInstanceMethod(self, @selector(Signal_dealloc));
    method_exchangeImplementations(deal, Signal_deal);
    
    
    Method viewWillDisappear = class_getInstanceMethod(self, @selector(viewWillDisappear:));
    Method ExtviewWillDisappear_deal = class_getInstanceMethod(self,@selector(viewWillDisappear_deal:));
    method_exchangeImplementations(viewWillDisappear, ExtviewWillDisappear_deal);
}
//#elif TARGET_OS_IPHONE//真机
//+ (void)load{
//
//}

//#endif

static BOOL logswith;


-(void)viewWillDisappear_deal:(BOOL)animated
{
    if (TTConfigOpenVcDeallocLog) {
    
        //处理相册不选择图片的闪退问题
        if ([NSStringFromClass([self class]) isEqualToString:@"PLPhotoTileViewController"])
        {
            logswith = NO;
        }
        else
        {
            logswith = YES;
        }
        
    }
    
   
    [self viewWillDisappear_deal:animated];
}


/**
 *  这个方法 [self Signal_dealloc]
 *  必须放在后面 , 不然死了 就会僵尸对象
 */
- (void)Signal_dealloc
{
    if (TTConfigOpenVcDeallocLog) {
        
        if(logswith)
        {
            ttLog(@"Signal_dealloc ****** %@",self);
            //    [self.view endEditing:YES];
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            
            [self.view endEditing:YES];
            
        }
    }
    
  
    [self Signal_dealloc];
}

@end



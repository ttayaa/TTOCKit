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


static BOOL TTDeallocLog;


@implementation UIViewController (LogDealloc)
/**
 *  将所有的方法交换到这个分类来释放
 */

////#if TARGET_IPHONE_SIMULATOR//模拟器
+ (void)load{
    Method deal = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
    Method LogDealloc_deal = class_getInstanceMethod(self, @selector(LogDealloc_dealloc));
    method_exchangeImplementations(deal, LogDealloc_deal);
    
    
    Method viewWillDisappear = class_getInstanceMethod(self, @selector(viewWillDisappear:));
    Method LogDealloc_viewWillDisappear = class_getInstanceMethod(self,@selector(LogDealloc_viewWillDisappear:));
    method_exchangeImplementations(viewWillDisappear, LogDealloc_viewWillDisappear);
}


static BOOL logswith;


-(void)openDeallocLog:(BOOL)isopen
{
    if (isopen) {
        TTDeallocLog = YES;
    }
    else
    {
        TTDeallocLog = NO;
    }
}

-(void)LogDealloc_viewWillDisappear:(BOOL)animated
{
    
        //处理相册不选择图片的闪退问题
        if ([NSStringFromClass([self class]) isEqualToString:@"PLPhotoTileViewController"])
        {
            logswith = NO;
        }
        else
        {
            logswith = YES;
        }
        
    
   
    [self LogDealloc_viewWillDisappear:animated];
}


/**
 *  这个方法 [self Signal_dealloc]
 *  必须放在后面 , 不然死了 就会僵尸对象
 */
- (void)LogDealloc_dealloc
{
    
        if(logswith)
        {
            if (TTDeallocLog) {
                
                if ([NSStringFromClass([self class]) isEqualToString:@"PLPhotoTileViewController"]) {
                    return;
                }
                
                ttLog(@"LogDealloc_dealloc ****** %@",self);
            
            }
            
                [[NSNotificationCenter defaultCenter] removeObserver:self];
            
            if (self.isViewLoaded) {
                [self.view endEditing:YES];
            }
            
            
        }

  
    [self LogDealloc_dealloc];
    
    
}

@end



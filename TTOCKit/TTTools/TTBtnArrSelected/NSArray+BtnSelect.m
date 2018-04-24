//
//  NSArray+BtnSelect.m
//  DragonB
//
//  Created by apple on 2017/12/1.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "NSArray+BtnSelect.h"
#import <objc/runtime.h>

@implementation NSArray (BtnSelect)
-(BtnSelectClickBlock)BtnSelectClickBlock
{
    return objc_getAssociatedObject(self, @selector(BtnSelectClickBlock));
    
}
-(void)setBtnSelectClickBlock:(BtnSelectClickBlock)BtnSelectClickBlock
{
    objc_setAssociatedObject(self, @selector(BtnSelectClickBlock), BtnSelectClickBlock, OBJC_ASSOCIATION_COPY);
}
-(void)SingleSelectWithDefaultSelectIndex:(NSInteger)index BtnSelectClickBlock:(BtnSelectClickBlock)block
{
    [self enumerateObjectsUsingBlock:^(UIButton *  _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![btn isKindOfClass:[UIButton class]]) {
            return ;
        }
        
        [btn setSelected:NO];
        
        if ( (index+1)<=self.count ) {
            if (index==idx) {
                [btn setSelected:YES];
            }
        }
        
        [btn addTarget:self action:@selector(eachBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    if (self.count>0) {
        self.BtnSelectClickBlock = block;
    }
    
}

-(void)SingleSelectWithDefaultSelectBtnText:(NSString *)str BtnSelectClickBlock:(BtnSelectClickBlock)block
{
    [self enumerateObjectsUsingBlock:^(UIButton *  _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![btn isKindOfClass:[UIButton class]]) {
            return ;
        }
        
        [btn setSelected:NO];
        
        
        if (str) {
            if ([btn.titleLabel.text isEqualToString:str]) {
                [btn setSelected:YES];
            }
        }
        
        [btn addTarget:self action:@selector(eachBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }];
    
    if (self.count>0) {
        self.BtnSelectClickBlock = block;
    }

}

-(void)eachBtnClick:(UIButton *)btn
{
   __block NSInteger index = 0;
    [self enumerateObjectsUsingBlock:^(UIButton *  _Nonnull tempbtn, NSUInteger idx, BOOL * _Nonnull stop) {
        [tempbtn setSelected:NO];
        if (tempbtn == btn) {
            index = idx;
        }
    }];
    
    [btn setSelected:YES];
    
    self.BtnSelectClickBlock(btn,index);
    
}

@end

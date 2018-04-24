//
//  NSArray+BtnSelect.h
//  DragonB
//
//  Created by apple on 2017/12/1.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BtnSelectClickBlock)(UIButton *btn ,NSInteger idx);

@interface NSArray (BtnSelect)

-(void)SingleSelectWithDefaultSelectIndex:(NSInteger)index BtnSelectClickBlock:(BtnSelectClickBlock)block;

-(void)SingleSelectWithDefaultSelectBtnText:(NSString *)str BtnSelectClickBlock:(BtnSelectClickBlock)block;

@end

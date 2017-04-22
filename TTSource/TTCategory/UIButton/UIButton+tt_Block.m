//
//  UIButton+Block.m
//
//  Created by ttayaa on 14/12/15.
//  Copyright (c) 2014年 ttayaa All rights reserved.
//

#import "UIButton+tt_Block.h"
#import <objc/runtime.h>
static const void *tt_UIButtonBlockKey = &tt_UIButtonBlockKey;

@implementation UIButton (tt_Block)
-(void)tt_addActionHandler:(tt_TouchedBlock)touchHandler{
    objc_setAssociatedObject(self, tt_UIButtonBlockKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(tt_actionTouched:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)tt_actionTouched:(UIButton *)btn{
    tt_TouchedBlock block = objc_getAssociatedObject(self, tt_UIButtonBlockKey);
    if (block) {
        block(btn.tag);
    }
}
@end


//
//  UIViewController+TTModelSignal.m
//  bssc
//
//  Created by apple on 2017/3/24.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "UIViewController+TTModelSignal.h"
#import <objc/runtime.h>

@implementation UIViewController (TTModelSignal)
@dynamic loadModelSignalName;
-(NSString *)loadModelSignalName
{
    return objc_getAssociatedObject(self, @selector(clickSignalName));
}
-(void)setLoadModelSignalName:(NSString *)loadModelSignalName
{
    objc_setAssociatedObject(self, @selector(loadModelSignalName), loadModelSignalName, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

@end

//
//  IPModel.m
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "IPModel.h"

@implementation IPModel


+(instancetype)ipDescWith:(NSString *)urlstr name:(NSString *)name flagName:(NSString *)flagName
{
    IPModel *ipm = [self new];
    
    ipm.urlstr = urlstr;
    
    ipm.name = name;
    
    ipm.flagName = flagName;
    
    return ipm;
}
@end

//
//  DebugMange.m
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "DebugMange.h"
#import "DYYFloatWindow.h"
#import "SandboxTools.h"




@interface DebugMange ()
/** 服务器地址表*/
@property (strong, nonatomic) NSMutableArray<IPModel *> *IpArr;

@end

@implementation DebugMange

implementationSingleton(DebugMange)
static DYYFloatWindow *floatWindow;



-(NSMutableArray<IPModel *> *)IpArr
{
    if (!_IpArr) {
        _IpArr = [NSMutableArray array];
    }
    return _IpArr;
}



+(void)addIpModel_toIPArr:(IPModel *)ipmodel
{
    [[DebugMange shareDebugMange].IpArr addObject:ipmodel];
    [SandboxTools ArchiverObjectArray:[DebugMange shareDebugMange].IpArr forKey:IpArrSaveKey];
}


+(void)show:(ipchangefinish)finish
{
    floatWindow = [[DYYFloatWindow alloc]initWithFrame:CGRectMake(0, 300, 50, 50) mainImageName:@"AppIcon.png" imagesAndTitle:@{@"ddd":@"正式ip",@"eee":@"测试ip",@"fff":@"调试页面"} bgcolor:[UIColor lightGrayColor] animationColor:[UIColor purpleColor]];
    
   
    floatWindow.clickBolcks = ^(NSInteger i){
        
        finish([DebugMange shareDebugMange].IpArr,i);
    };
}
+(void)dissmis
{
    floatWindow.hidden = YES;
}


@end

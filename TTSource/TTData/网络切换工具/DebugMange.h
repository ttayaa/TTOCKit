//
//  DebugMange.h
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTdataMacros.h"
#import "IPModel.h"

typedef void (^ipchangefinish)(NSMutableArray<IPModel *> *IpArr,NSInteger index);


#define IpArrSaveKey @"IpArrSaveKey"

//ip改变的通知
#define KNOTIFICATION_CHOOSEIP @"KNOTIFICATION_CHOOSEIP"



@interface DebugMange : NSObject
interfaceSingleton(DebugMange)


//添加ip
+(void)addIpModel_toIPArr:(IPModel *)ipmodel;

//显示debug面板
+(void)show:(ipchangefinish)finish;

+(void)dissmis;
@end

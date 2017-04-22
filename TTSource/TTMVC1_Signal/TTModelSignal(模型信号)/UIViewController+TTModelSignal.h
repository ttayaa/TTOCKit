//
//  UIViewController+TTModelSignal.h
//  bssc
//
//  Created by apple on 2017/3/24.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ttLoadDataSuccess)(id responseObject);
typedef void (^ttLoadDataFailure)(NSError *error);

typedef void (^ttLoadDataArrSuccess)(NSMutableArray *arr,NSInteger cutpage,NSInteger totalpages,NSInteger total);




@interface UIViewController (TTModelSignal)

/** 发送模型更新数据 的 信号*/
@property (strong, nonatomic) NSString *loadModelSignalName;



@end

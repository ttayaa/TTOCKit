//
//  NSDictionary+tt_PrintProperty.h
//  bssc
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <Foundation/Foundation.h>



//根据模型打印出 模型数据方法


#define TTPrintModelDataFun(modelClassName) [NSDictionary PrintFun:modelClassName];


@interface NSDictionary (tt_PrintProperty)


//根据字典嵌套关系  打印出所有模型属性
-(void)printProperty;





//打印数据请求方法
/*

 typedef void (^loadHomeDataSuccess)(BSSC_HOMEDATA *modal);
 typedef void (^loadGuessULoveDataSuccess)(NSMutableArray *arr,NSString *cutpage,NSString *totalpages,NSString *total);

 
 
+(void)loadHomeDataSuccess:(loadHomeDataSuccess)success Failure:(httpRequestFailure)failure;
 **/

+(void)PrintFun:(NSString *)modelClassName;

@end

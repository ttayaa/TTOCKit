//
//  testmodel.m
//  testproject
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import "testmodel.h"

@implementation testmodel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"New_price" : @"new_price",
             @"Operator" : @"operator",
             @"status" : @"_status",
             };
}
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return  @{
              @"quotes":[testmodel class],
              @"bids":[testmodel class],
              @"asks":[testmodel class],
              @"assets":[testmodel class],
              @"records":[testmodel class],
              @"accounts":[testmodel class],
              @"deals":[testmodel class],
              @"entrustments":[testmodel class],
              @"messages":[testmodel class],
              };
}
@end



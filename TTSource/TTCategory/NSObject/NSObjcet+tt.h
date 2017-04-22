//
//  NSObjcet+MAC.h
//  WeiSchoolTeacher
//
//  Created by ttayaa on 15/12/14.
//  Copyright © 2015年 ttayaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(tt)
/**
 * 将Base64Json基类转为Json字典
 */
- (id)tt_jsonBase64Value;

+(NSMutableArray*)tt_macObjectToArray;

@end

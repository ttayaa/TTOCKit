//
//  NSObject+runtime.m
//  ttayaa微博部署
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import "NSObject+tt_PrintProperty.h"
#import <objc/runtime.h>

@implementation NSObject (tt_PrintProperty)


-(NSString *)tt_getclassName
{
    return NSStringFromClass([self class]);
}

/* 获取对象的所有属性和属性内容 */
- (NSDictionary *)tt_getAllPropertiesAndVaules
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties =class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);

        NSString * propertyName = [NSString stringWithUTF8String:char_f];
        
        id propertyValue;
        
        @try {
            propertyValue = [self valueForKey:(NSString *)propertyName];
        }
        @catch (NSException *exception) {
        }
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
        //如果是基本数据类型无法KVC
//        else [props setObject:[NSString stringWithFormat:@"%d",(int)propertyValue] forKey:propertyName];
    }
    free(properties);
    
    return props;
}
/* 获取对象的所有属性 */
- (NSArray *)tt_getAllProperties
{
    u_int count;
    
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    
    free(properties);
    
    NSLog(@"%@",propertiesArray);
    
    return propertiesArray;
}
/* 获取对象的所有方法 */
-(void)tt_getAllMethods
{
    unsigned int mothCout_f =0;
    Method* mothList_f = class_copyMethodList([self class],&mothCout_f);
    for(int i=0;i<mothCout_f;i++)
    {
        Method temp_f = mothList_f[i];
        //        IMP imp_f = method_getImplementation(temp_f);
        //        SEL name_f = method_getName(temp_f);
        const char* name_s =sel_getName(method_getName(temp_f));
        int arguments = method_getNumberOfArguments(temp_f);
        const char* encoding =method_getTypeEncoding(temp_f);
        
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
              arguments,
              [NSString stringWithUTF8String:encoding]);
    }
    free(mothList_f);
}

//以字典的形式打印属性和属性值
-(void)tt_print
{
    //打印属性值
    NSLog(@"%@",[self tt_getAllPropertiesAndVaules]);

}

@end

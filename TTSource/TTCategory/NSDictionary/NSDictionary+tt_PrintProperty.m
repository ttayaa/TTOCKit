//
//  NSDictionary+tt_PrintProperty.m
//  bssc
//
//  Created by apple on 2016/3/14.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "NSDictionary+tt_PrintProperty.h"

#import <objc/runtime.h>

#define TT_DEFAULT_CLASS_NAME @("TT")
#define TT_CLASS       @("\n@interface %@ :NSObject\n%@\n@end\n")
#define TT_PROPERTY(s)    ((s) == 'c' ? @("@property (nonatomic , copy) %@              * %@;\n") : @("@property (nonatomic , strong) %@              * %@;\n"))

#define TT_PROPERTY_ARR   @("@property (nonatomic , strong) %@     <%@   *>* %@;\n")


#define TT_CLASS_M     @("@implementation %@\n\n@end\n")


#define TTSW_CLASS @("\n@objc(%@)\nclass %@ :NSObject{\n%@\n}")
#define TTSW_PROPERTY @("var %@: %@!;\n")


static NSMutableString * classString;
static NSMutableString * classMString;


@implementation NSDictionary (tt_PrintProperty)



+(void)initialize
{
    classString = [NSMutableString string];
    classMString = [NSMutableString string];

}


-(void)printProperty
{
    
    classString = [NSMutableString string];
    classMString = [NSMutableString string];


    [classString deleteCharactersInRange:NSMakeRange(0, classString.length)];
    [classMString deleteCharactersInRange:NSMakeRange(0, classMString.length)];
    
    
    NSString  * className = TT_DEFAULT_CLASS_NAME;


//    [classMString appendFormat:TT_CLASS_M,className];
    [classString appendFormat:TT_CLASS,className,[self handleDataEngine:self key:@""]];
    
    
    
    
//    NSLog(@"%@",classMString);
    NSLog(@"==========================模型属性打印=============================");
    NSLog(@"%@",classString);
    NSLog(@"=============================end===============================");
    
    
}

- (NSString*)handleDataEngine:(id)object key:(NSString*)key{
    if(object){
        NSMutableString  * property = [NSMutableString new];
        if([object isKindOfClass:[NSDictionary class]]){
            NSDictionary  * dict = object;
            NSInteger       count = dict.count;
            NSArray       * keyArr = [dict allKeys];
            for (NSInteger i = 0; i < count; i++) {
                id subObject = dict[keyArr[i]];
                if([subObject isKindOfClass:[NSDictionary class]]){
                    NSString * classContent = [self handleDataEngine:subObject key:keyArr[i]];
                    
                    [property appendFormat:TT_PROPERTY('s'),keyArr[i],keyArr[i]];
                    [classString appendFormat:TT_CLASS,keyArr[i],classContent];
                    [classMString appendFormat:TT_CLASS_M,keyArr[i]];
                    
                }else if ([subObject isKindOfClass:[NSArray class]]){
                    NSString * classContent = [self handleDataEngine:subObject key:keyArr[i]];
                    
//                    [property appendFormat:TT_PROPERTY('s'),@"NSArray",keyArr[i]];
                     [property appendFormat:TT_PROPERTY_ARR,@"NSArray",keyArr[i],keyArr[i]];
                    
                    [classString appendFormat:TT_CLASS,keyArr[i],classContent];
                    [classMString appendFormat:TT_CLASS_M,keyArr[i]];
                    
                }else if ([subObject isKindOfClass:[NSString class]]){
                    
                    [property appendFormat:TT_PROPERTY('c'),@"NSString",keyArr[i]];
                    
                }else if ([subObject isKindOfClass:[NSNumber class]]){
                    
//                    [property appendFormat:TT_PROPERTY('s'),@"NSNumber",keyArr[i]];
                    [property appendFormat:TT_PROPERTY('s'),@"NSString",keyArr[i]];

                }
                else{
                    if(subObject == nil){
                        
                        [property appendFormat:TT_PROPERTY('c'),@"NSString",keyArr[i]];
                        
                    }else if([subObject isKindOfClass:[NSNull class]]){
                        
                        [property appendFormat:TT_PROPERTY('c'),@"NSString",keyArr[i]];
                        
                    }
                }
            }
        }else if ([object isKindOfClass:[NSArray class]]){
            NSArray  * dictArr = object;
            NSUInteger  count = dictArr.count;
            if(count){
                NSObject  * tempObject = dictArr[0];
                for (NSInteger i = 0; i < dictArr.count; i++) {
                    NSObject * subObject = dictArr[i];
                    if([subObject isKindOfClass:[NSDictionary class]]){
                        if(((NSDictionary *)subObject).count > ((NSDictionary *)tempObject).count){
                            tempObject = subObject;
                        }
                    }
                    if([subObject isKindOfClass:[NSDictionary class]]){
                        if(((NSArray *)subObject).count > ((NSArray *)tempObject).count){
                            tempObject = subObject;
                        }
                    }
                }
                [property appendString:[self handleDataEngine:tempObject key:key]];
            }
        }else{
            NSLog(@"key = %@",key);
        }
        return property;
    }
    return @"";
}












#define TT_DATABLOCK     @("typedef void (^load%@Success)(%@ *modal);\n")
#define TT_DATABLOCK_R     @("typedef void (^load%@Failure)(NSError *error);\n")

#define TT_DATABLOCK_PAGE     @("typedef void (^load%@ArrSuccess)(NSMutableArray <%@ *>*arr,NSInteger cutpage,NSInteger totalpages,NSInteger total);\n")
#define TT_DATABLOCK_PAGE_R     @("typedef void (^load%@ArrFailure)(NSError *error);\n")


#define TT_DATAFUN     @("+(void)load%@Success:(load%@Success)success Failure:(load%@Failure)failure;\n")

#define TT_DATAFUN_PAGE     @("+(void)load%@WithPage:(NSString *)page Success:(load%@ArrSuccess)success Failure:(load%@ArrFailure)failure;\n")



+(void)PrintFun:(NSString *)modelClassName
{
    
    NSMutableString * dataFun = [NSMutableString string];
    
    [dataFun appendFormat:@"\n"];
    [dataFun appendFormat:@"\n"];
    [dataFun appendFormat:@"=============================="];
    [dataFun appendFormat:@"============数据方法============"];
    [dataFun appendFormat:@"==============================\n"];
    [dataFun appendFormat:TT_DATABLOCK,modelClassName,modelClassName];
    [dataFun appendFormat:TT_DATABLOCK_R,modelClassName,modelClassName];

    [dataFun appendFormat:@"\n"];
    [dataFun appendFormat:TT_DATABLOCK_PAGE,modelClassName,modelClassName];
    [dataFun appendFormat:TT_DATABLOCK_PAGE_R,modelClassName,modelClassName];

    [dataFun appendFormat:@"\n"];
    [dataFun appendFormat:TT_DATAFUN,modelClassName,modelClassName,modelClassName];
    [dataFun appendFormat:@"\n"];
    [dataFun appendFormat:TT_DATAFUN_PAGE,modelClassName,modelClassName,modelClassName];
    [dataFun appendFormat:@"\n"];
    [dataFun appendFormat:@"\n"];
    [dataFun appendFormat:@"=============================="];
    [dataFun appendFormat:@"============end============"];
    [dataFun appendFormat:@"==============================\n"];
    
    NSLog(@"%@",dataFun);
}





@end

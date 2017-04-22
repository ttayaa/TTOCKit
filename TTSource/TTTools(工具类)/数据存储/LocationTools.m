//
//  LocationTools.m
//  ttayaa
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import "LocationTools.h"

@implementation LocationTools

+(NSDictionary *)loadDictWithLocationFileName:(NSString *)fileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSDictionary dictionary];
    if (data != nil) {
        dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    
    return dict;
}

@end

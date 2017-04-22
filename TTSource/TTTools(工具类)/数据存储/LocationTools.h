//
//  LocationTools.h
//  ttayaa
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationTools : NSObject

/**通过程序路径下的文件名读取字典型文件*/
+(NSDictionary *)loadDictWithLocationFileName:(NSString *)fileName;

@end

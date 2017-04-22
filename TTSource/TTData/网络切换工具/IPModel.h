//
//  IPModel.h
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPModel : NSObject

/** ip
 */
@property (strong, nonatomic) NSString *urlstr;

/** Name*/
@property (strong, nonatomic) NSString *name;

/** flag*/
@property (strong, nonatomic) NSString *flagName;


+(instancetype)ipDescWith:(NSString *)urlstr name:(NSString *)name flagName:(NSString *)flagName;

@end

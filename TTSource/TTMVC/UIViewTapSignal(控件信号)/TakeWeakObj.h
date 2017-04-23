//
//  TakeWeakObj.h
//  fscar
//
//  Created by apple on 2016/11/23.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 一个带有弱对象的类*/
@interface TakeWeakObj : NSObject

@property (weak, nonatomic) UIViewController * weakSignalVc;

@end

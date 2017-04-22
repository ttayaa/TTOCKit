//
//  supportHead.h
//  fscar
//
//  Created by apple on 2016/11/1.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#ifndef supportHead_h
#define supportHead_h

#define weakify( x )  __weak __typeof__(x) __weak_##x##__ = x;
#define normalize( x ) __typeof__(x) x = __weak_##x##__;

#pragma mark - ControllerExtSupport(扩展控制器的支持)
#import "ControllerCategoryOverride.h"

#endif /* supportHead_h */

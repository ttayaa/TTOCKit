//
//  TTSignal.h
//  testproject
//
//  Created by apple on 2018/4/10.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#ifndef TTSignal_h
#define TTSignal_h
#import "UIView+TTSignal.h"
#define TTSignal(SignalName) \
- (void)TTSignal_##SignalName:(UIView *)object
#endif /* TTSignal_h */



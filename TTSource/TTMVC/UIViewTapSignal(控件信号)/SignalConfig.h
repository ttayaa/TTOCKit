//
//  SignalConfig.h
//  elmsc
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#ifndef SignalConfig_h
#define SignalConfig_h

#import "SignalModel.h"

#import "UIView+Contraints.h"

#import "UIView+Signal.h"

#import "UIControl+stopContinuousClick.h"

#import "UIView+TTXIBFontAdapter.h"


#define DefclickSignalName self.clickSignalName

#define SEL_signal [NSString stringWithFormat:@"haveSignal_%@:",DefclickSignalName]


#undef	Click_signal
#define Click_signal(DefclickSignalName) \
- (void)haveSignal_##DefclickSignalName:(SignalModel *)signal


/**
 父控件是 tableView或者colletionView 的控件信号宏
 */



#define NOIMPORT_Click_signal(name) \
- (void)haveSignal_##name:(id)signal

#endif /* SignalConfig_h */

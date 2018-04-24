//
//  DBProgress.h
//  bssc
//
//  Created by apple on 2017/3/3.
//  Copyright © 2017年 ttayaa. All rights reserved.
//
#import <UIKit/UIKit.h>

#define KNOTIFICATION_ShowWait @"KNOTIFICATION_ShowWait"
#define KNOTIFICATION_Sucess @"KNOTIFICATION_Sucess"
#define KNOTIFICATION_Error @"KNOTIFICATION_Error"
#define KNOTIFICATION_ShowTip @"KNOTIFICATION_ShowTip"
#define KNOTIFICATION_Dismiss @"KNOTIFICATION_Dismiss"
#define KNOTIFICATION_NetWorkFail @"KNOTIFICATION_NetWorkFail"

/**API
 弹框宏
 */
#define CommonProgressShowWait(message) [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_ShowWait object:message];

#define CommonProgressSucess(message) [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_Sucess object:message];

#define CommonProgressError(message) [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_Error object:message];

#define CommonProgressShowTip(message,second) [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_ShowTip object:@[message,@(second)]];

#define CommonProgressDismiss [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_Dismiss object:nil];

#define CommonProgressNetWorkFail [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_NetWorkFail object:nil];



@interface DBProgress : NSObject




@end

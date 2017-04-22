//
//  NavigationBarPop_push_Manager.h
//  fscar
//
//  Created by apple on 2016/10/30.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NaviBarAnimationType) {
    NaviBarAnimationRootVcViewNone=0,
    NaviBarAnimationRootVcViewUpDown=1,
    NaviBarAnimationRootVcOnlyPopDown=2,
    NaviBarAnimationRootVcOnlyPushUp=3
};
@interface NavigationBarPop_push_Manager : NSObject

+(void)manageUseAnimationType:(NaviBarAnimationType)type NavigationController:(UINavigationController *)NavigationController;


@end

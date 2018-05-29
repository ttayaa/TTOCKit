//
//  UIViewController+TTAlowPush.h
//  TTOCKitDemo
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TTAlowPush)
/**
 *  是否运行NavigationController 多次push
 */
@property(nonatomic,assign)BOOL TTisCanMutablePush;

@end

@interface UINavigationController (TTAlowPush)

@end

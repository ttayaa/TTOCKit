//
//  TTAlertView.h
//  TTModuleDemo
//
//  Created by ttayaa on 16/10/12.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 [TTAlertView showMultipleButtonsWithTitle:@"提示" Message:@"选择导航方位" Click:^(NSInteger index) {
 if(index==0)
 {
 CLLocationCoordinate2D Coordinate = self.nodeArr.firstObject.pt;
 
 [TTMapNavigationManager showSheetWithCoordinate2D:Coordinate];
 }
 if(index==1)
 {
 CLLocationCoordinate2D Coordinate = self.nodeArr.lastObject.pt;
 
 [TTMapNavigationManager showSheetWithCoordinate2D:Coordinate];
 }
 if(index==2)
 {
 
 }
 
 } Buttons:@{@"TTAlertViewButtonTypeDefault":@"我到起点导航"},@{@"TTAlertViewButtonTypeDefault":@"我到终点导航"},@{@"TTAlertViewButtonTypeCancel":@"取消"},nil];
 */


UIKIT_EXTERN NSString *const TTAlertViewWillShowNotification;
UIKIT_EXTERN NSString *const TTAlertViewDidShowNotification;
UIKIT_EXTERN NSString *const TTAlertViewWillDismissNotification;
UIKIT_EXTERN NSString *const TTAlertViewDidDismissNotification;

typedef void(^clickHandle)(void);

typedef void(^clickHandleWithIndex)(NSInteger index);

typedef NS_ENUM(NSInteger, TTAlertViewButtonType) {
    TTAlertViewButtonTypeDefault = 0,
    TTAlertViewButtonTypeCancel,
    TTAlertViewButtonTypeWarn,
    TTAlertViewButtonTypeNone,
    TTAlertViewButtonTypeHeight
};


@interface TTAlertView : UIView

// ------------------------Show AlertView with title and message----------------------

// show alertView with 1 button
+ (void)showOneButtonWithTitle:(NSString *)title Message:(NSString *)message ButtonType:(TTAlertViewButtonType)buttonType ButtonTitle:(NSString *)buttonTitle Click:(clickHandle)click;

// show alertView with 2 buttons
+ (void)showTwoButtonsWithTitle:(NSString *)title Message:(NSString *)message ButtonType:(TTAlertViewButtonType)buttonType ButtonTitle:(NSString *)buttonTitle Click:(clickHandle)click ButtonType:(TTAlertViewButtonType)buttonType ButtonTitle:(NSString *)buttonType Click:(clickHandle)click;

// show alertView with greater than or equal to 3 buttons
// parameter of 'buttons' , pass by NSDictionary like @{JCAlertViewButtonTypeDefault : @"ok"}
+ (void)showMultipleButtonsWithTitle:(NSString *)title Message:(NSString *)message Click:(clickHandleWithIndex)click Buttons:(NSDictionary *)buttons,... NS_REQUIRES_NIL_TERMINATION;

// ------------------------Show AlertView with customView-----------------------------

// create a alertView with customView.
// 'dismissWhenTouchBackground' : If you don't want to add a button on customView to call 'dismiss' method manually, set this property to 'YES'.
- (instancetype)initWithCustomView:(UIView *)customView dismissWhenTouchedBackground:(BOOL)dismissWhenTouchBackground;

- (void)configAlertViewPropertyWithTitle:(NSString *)title Message:(NSString *)message Buttons:(NSArray *)buttons Clicks:(NSArray *)clicks ClickWithIndex:(clickHandleWithIndex)clickWithIndex;

- (void)show;

// alert will resign keywindow in the completion.
- (void)dismissWithCompletion:(void(^)(void))completion;

@end

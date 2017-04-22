//
//  SignalActionSheet.h
//  fscar
//
//  Created by apple on 2016/11/2.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import <UIKit/UIKit.h>


//外部使用的宏
#define actionSheet(name) -(void)actionSheet_##name:(NSObject *)obj


@interface SignalActionSheet : UIActionSheet<UIActionSheetDelegate>
@property (nonatomic, strong) UIView *				parentView;
@property (nonatomic, strong) NSObject *			userData;

/** <#what is this#>*/
@property (strong, nonatomic) UIViewController *respondVc;



- (void)showInViewController:(UIViewController *)controller;	// samw as presentForController:
- (void)presentForController:(UIViewController *)controller;
- (void)dismissAnimated:(BOOL)animated;

- (void)addCancelTitle:(NSString *)title;
- (void)addCancelTitle:(NSString *)title signal:(NSString *)signal object:(id)object;
- (void)addButtonTitle:(NSString *)title signal:(NSString *)signal;
- (void)addButtonTitle:(NSString *)title signal:(NSString *)signal object:(id)object;
- (void)addDestructiveTitle:(NSString *)title signal:(NSString *)signal;
- (void)addDestructiveTitle:(NSString *)title signal:(NSString *)signal object:(id)object;

@end

//
//  UIView+Signal.h
//  elmsc
//
//  Created by apple on 16/8/5.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TakeWeakObj.h"


@interface UIView (Signal)

/**动态属性 信号名字
 */
@property (strong, nonatomic) NSString *clickSignalName;

/**动态属性 和信号一起传递的参数
 argsObj存放在Signal对象中
*/
@property (strong, nonatomic) NSObject *argsObj;

- (void)setClickSignalName:(NSString *)clickSignalName withObject:(id)argsObj;

/**弱指针 动态属性 信号响应到哪个控制器中
 
 */
@property (weak, nonatomic) UIViewController *clickSignalRespondToController;

/** */
//@property (strong, nonatomic) TakeWeakObj *take_a_WeakValue_Obj;

//@property (assign, nonatomic) BOOL IsDynamicSignal;
@end


@interface UIControl (Signal)
//设置 事件类型
/**
 设置 事件类型
 *必须写在设置信号名之前,才有效果!!!!!!!
 */
-(void)setUIControlEvent:(UIControlEvents)event;
@end



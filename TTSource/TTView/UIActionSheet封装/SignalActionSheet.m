//
//  SignalActionSheet.m
//  fscar
//
//  Created by apple on 2016/11/2.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import "SignalActionSheet.h"
@interface SignalActionSheet()
{
    UIView *				_parentView;
    NSMutableArray *		_actions;
    NSObject *				_userData;
    
}
@end

@implementation SignalActionSheet


- (id)init
{
    self = [super init];
    if ( self )
    {
        self.delegate = self;
        self.title = nil;
        self.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        if ( nil == _actions )
        {
            _actions = [[NSMutableArray alloc] init];
        }
        
    }
    return self;
}

- (void)dealloc
{
    [_actions removeAllObjects];

}

- (void)showFromToolbar:(UIToolbar *)view
{
    self.parentView = view;
    
    [super showFromToolbar:view];
}

- (void)showFromTabBar:(UITabBar *)view
{
    self.parentView = view;
    
    [super showFromTabBar:view];
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated
{
    if ( item.target && [item.target isKindOfClass:[UIView class]] )
    {
        self.parentView = item.target;
    }
    
    [super showFromBarButtonItem:item animated:animated];
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated
{
    self.parentView = view;
    
    [super showFromRect:rect inView:view animated:animated];
}

- (void)showInView:(UIView *)view
{
    self.parentView = view;
    
    [super showInView:view];
}

- (void)showInViewController:(UIViewController *)controller
{
    [self presentForController:controller];
}

- (void)presentForController:(UIViewController *)controller
{
    self.parentView = controller.view;
    
    [self showInView:controller.view];
}

- (void)dismissAnimated:(BOOL)animated
{
    [self dismissWithClickedButtonIndex:self.cancelButtonIndex animated:animated];
}

- (void)addButtonTitle:(NSString *)title signal:(NSString *)signal
{
    [self addButtonTitle:title signal:signal object:nil];
}

- (void)addButtonTitle:(NSString *)title signal:(NSString *)signal object:(id)object
{
    if ( nil == signal )
    {
        signal = @"";
    }
    
    if ( nil == object )
    {
        object = [NSDictionary dictionary];
    }
    
    NSInteger index = [self addButtonWithTitle:title];
    [_actions addObject:[NSArray arrayWithObjects:title, [NSNumber numberWithInt:(int)index], signal, object, nil]];
}

- (void)addCancelTitle:(NSString *)title
{
    self.cancelButtonIndex = [self addButtonWithTitle:title];
}

- (void)addCancelTitle:(NSString *)title signal:(NSString *)signal object:(id)object
{
    if ( nil == signal )
    {
        signal = @"";
    }
    
    if ( nil == object )
    {
        object = [NSDictionary dictionary];
    }
    
    self.cancelButtonIndex = [self addButtonWithTitle:title];
    [_actions addObject:[NSArray arrayWithObjects:title, [NSNumber numberWithInt:(int)self.cancelButtonIndex], signal, object, nil]];
}

- (void)addDestructiveTitle:(NSString *)title signal:(NSString *)signal
{
    [self addDestructiveTitle:title signal:signal object:nil];
}

- (void)addDestructiveTitle:(NSString *)title signal:(NSString *)signal object:(id)object
{
    if ( nil == signal )
    {
        signal = @"";
    }
    
    if ( nil == object )
    {
        object = [NSDictionary dictionary];
    }
    
    self.destructiveButtonIndex = [self addButtonWithTitle:title];
    [_actions addObject:[NSArray arrayWithObjects:title, [NSNumber numberWithInt:(int)self.destructiveButtonIndex], signal, object, nil]];
}

#pragma mark -
#pragma mark UIActionSheetDelegate

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //	NSString * selectTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    
    //用外部输入的名字来确定信号名
    for ( NSArray * array in _actions )
    {
        //		NSString * actionTitle = [array objectAtIndex:0];
        //		if ( NO == [actionTitle isEqualToString:selectTitle] )
        //			continue;
        
        NSNumber * index = [array objectAtIndex:1];
        if ( [index intValue] == buttonIndex )
        {
            NSString * signal = [array objectAtIndex:2];
            if ( signal && [signal length] )
            {
                NSObject * object = ([array count] >= 4) ? [array objectAtIndex:3] : nil;

                id respondObj =  self.respondVc ? self.respondVc : self;
                
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
                SEL sel = NSSelectorFromString([NSString stringWithFormat:@"actionSheet_%@:",signal]);
                
                if ([respondObj respondsToSelector:sel]) {
                     [respondObj performSelector:sel withObject:object];
                }
#pragma clang diagnostic pop
                
            }
            else if ( buttonIndex != self.cancelButtonIndex && buttonIndex != self.destructiveButtonIndex )
            {
                [self dismissWithClickedButtonIndex:buttonIndex animated:YES];
            }
            
            break;
        }
    }
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
}

// before animation and showing view
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
//    [self sendUISignal:BeeUIActionSheet.WILL_PRESENT
//            withObject:nil
//                    to:(_parentView ? _parentView : self)];
  id respondObj =  self.respondVc ? self.respondVc : self;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    
    if ([respondObj respondsToSelector:@selector(actionSheet_willPresentActionSheet)]) {
        [respondObj performSelector:@selector(actionSheet_willPresentActionSheet)];
    }
#pragma clang diagnostic pop
}

// after animation
- (void)didPresentActionSheet:(UIActionSheet *)actionSheet
{
//    [self sendUISignal:BeeUIActionSheet.DID_PRESENT
//            withObject:nil
//                    to:(_parentView ? _parentView : self)];
  id respondObj =  self.respondVc ? self.respondVc : self;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    
    if ([respondObj respondsToSelector:@selector(actionSheet_didPresentActionSheet)]) {
        [respondObj performSelector:@selector(actionSheet_didPresentActionSheet)];
    }
#pragma clang diagnostic pop
}

// before animation and hiding view
- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
//    [self sendUISignal:BeeUIActionSheet.WILL_DISMISS
//            withObject:nil
//                    to:(_parentView ? _parentView : self)];
  id respondObj =  self.respondVc ? self.respondVc : self;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    
    if ([respondObj respondsToSelector:@selector(didDismissWithButtonIndex)]) {
        [respondObj performSelector:@selector(actionSheet_willDismissWithButtonIndex)];
    }
#pragma clang diagnostic pop
    
}

// after animation
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
//    [self sendUISignal:BeeUIActionSheet.DID_DISMISS
//            withObject:nil
//                    to:(_parentView ? _parentView : self)];
  id respondObj =  self.respondVc ? self.respondVc : self;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    
    if ([respondObj respondsToSelector:@selector(didDismissWithButtonIndex:)]) {
        [respondObj performSelector:@selector(actionSheet_didDismissWithButtonIndex)];
    }
#pragma clang diagnostic pop
    
}


/** 获取当前View的控制器对象 */
-(UIViewController *)getActionSheetCurrentViewController{
    UIResponder *next = [self nextResponder];
    
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}
@end

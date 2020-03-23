//
//  UIViewController+easyJump.h
//  elmsc
//
//  Created by apple on 2016/10/17.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^OnceBlock)();

typedef void (^OffenBlock)(id args);


@interface UIViewController (easyJump)



/**这个block只会调用一次  一般用于跳转*/
-(void)WhenViewDidLoad:(OnceBlock)OutsideWilldoblock;
-(void)WhenViewWillLayoutSubviews:(OnceBlock)OutsideWilldoblock;
-(void)WhenViewDidLayoutSubviews:(OnceBlock)OutsideWilldoblock;
-(void)WhenViewWillAppear:(OnceBlock)OutsideWilldoblock;
-(void)WhenViewDidAppear:(OnceBlock)OutsideWilldoblock;
-(void)WhenViewWillDisappear:(OnceBlock)OutsideWilldoblock;
-(void)WhenViewDidDisappear:(OnceBlock)OutsideWilldoblock;



/**这个block只会调用多次  一般用于逆传*/
-(void)WhenViewDidLoad_offen:(OffenBlock)OutsideWilldoblock;
-(void)WhenViewWillLayoutSubviews_offen:(OffenBlock)OutsideWilldoblock;
-(void)WhenViewDidLayoutSubviews_offen:(OffenBlock)OutsideWilldoblock;
-(void)WhenViewWillAppear_offen:(OffenBlock)OutsideWilldoblock;
-(void)WhenViewDidAppear_offen:(OffenBlock)OutsideWilldoblock;
-(void)WhenViewWillDisappear_offen:(OffenBlock)OutsideWilldoblock;
-(void)WhenViewDidDisappear_offen:(OffenBlock)OutsideWilldoblock;




/** 可以将这个参数传出给外部*/
@property (strong, nonatomic) id TTeasyjumpArgs;



@end



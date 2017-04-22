//
//  UIButton+Block.h
//
//
//  Created by ttayaa on 14/12/15.
//  Copyright (c) 2014年 ttayaa All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^tt_TouchedBlock)(NSInteger tag);

@interface UIButton (tt_Block)
-(void)tt_addActionHandler:(tt_TouchedBlock)touchHandler;
@end

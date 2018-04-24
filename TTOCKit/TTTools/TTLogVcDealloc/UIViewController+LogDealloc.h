//
//  UIViewController+Signal.h
//  elmsc
//
//  Created by apple on 16/8/5.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#import <UIKit/UIKit.h>


/**API
 一般在Appdelegate中 [[UIViewController new] openDeallocLog:YES];
 就可以打印
 */

@interface UIViewController (LogDealloc)

-(void)openDeallocLog:(BOOL)isopen;

@end

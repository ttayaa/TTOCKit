//
//  UIViewController+ViewIsScrollview.h
//  elmsc
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ViewIsScrollview)

/** <#what is this#>*/
@property (strong, nonatomic) UIScrollView *bgScrollview;

//使用背景为scrollview
-(void)useBgScrollview;

@end

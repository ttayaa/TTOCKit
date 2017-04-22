//
//  UIBarButtonItem+setimgName.h
//  common
//
//
//  Copyright © 2016年 ttayaa.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (setimgName)
+(UIBarButtonItem *)createUIButtonItemWithImgName:(NSString *)imgName addTarget:(id) obj action:(SEL)sel forControlEvents:(UIControlEvents)UIControlEvents;

@end

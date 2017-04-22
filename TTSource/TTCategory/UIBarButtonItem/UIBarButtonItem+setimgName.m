//
//  UIBarButtonItem+setimgName.m
//  common
//
//
//  Copyright © 2016年 ttayaa.
//

#import "UIBarButtonItem+setimgName.h"

@implementation UIBarButtonItem (setimgName)

/**
图片名字高亮状态 会加上_highlighted 
 */
+(UIBarButtonItem *)createUIButtonItemWithImgName:(NSString *)imgName addTarget:(id) obj action:(SEL)sel forControlEvents:(UIControlEvents)UIControlEvents
{
    UIButton *btn = [UIButton new];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    
    NSString *hightlightName = [NSString stringWithFormat:@"%@_highlighted",imgName];
    
    [btn setImage:[UIImage imageNamed:hightlightName] forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
    
    [btn addTarget:obj action:sel forControlEvents:UIControlEvents];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}


@end

//
//  NSObject+TTPlaceholderPlace.m
//  NewProject
//
//  Created by apple on 2018/3/19.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import "NSObject+TTPlaceholderPlace.h"

@implementation NSObject (TTPlaceholderPlace)


-(void)TTPlaceholderPlaceOnView:(UIView*)view filterType:(TTPlaceholderPlaceType)filterType Color:(UIColor *)color
{
    if (!color) {
        color = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:243/255.0 alpha:1.0];
    }
    
    for (UIView* subView in view.subviews)
    {
        if([subView isKindOfClass:[UILabel class]] && ((filterType&TTPlaceholderPlaceUILabel)==TTPlaceholderPlaceUILabel) )
        {
            UILabel *temp = (UILabel *)subView;
            temp.text = @"                                                       ";
            temp.backgroundColor = color;
            temp.layer.cornerRadius = 5;
            temp.layer.masksToBounds = YES;
        }
        
        if(([subView isKindOfClass:[UITextField class]]||
           [subView isKindOfClass:[UITextView class]]) && ((filterType&TTPlaceholderPlaceUITextField_UITextView)==TTPlaceholderPlaceUITextField_UITextView))
        {
            UITextField *temp = (UITextField *)subView;
            //            temp.text = @"                                                       ";
            temp.placeholder = @"";
            temp.backgroundColor = color;
            temp.layer.cornerRadius = 5;
            temp.layer.masksToBounds = YES;
        }
        
        if([subView isKindOfClass:[UIButton class]] && ((filterType&TTPlaceholderPlaceUIButton)==TTPlaceholderPlaceUIButton) )
        {
            UIButton *temp = (UIButton *)subView;
            [temp setTitle:@"" forState:UIControlStateNormal];
            [temp setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            temp.backgroundColor = color;
            temp.layer.cornerRadius = 5;
            temp.layer.masksToBounds = YES;
        }
        
        if([subView isKindOfClass:[UIView class]] && ((filterType&TTPlaceholderPlaceUIView)==TTPlaceholderPlaceUIView) )
        {
            UIView *temp = (UIView *)subView;
            temp.backgroundColor = color;
            temp.layer.cornerRadius = 5;
            temp.layer.masksToBounds = YES;
        }
        
        
        [self TTPlaceholderPlaceOnView:subView filterType:filterType Color:color];
        
    }
}

@end

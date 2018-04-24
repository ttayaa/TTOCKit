//
//  TTGroupViewVerticalItemMake.h
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/9/2.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTGroupViewBaseMake : NSObject
{
    
@public
    UIView * view;
    
}

-(void)settingRadioHeightWithView:(UIView *)culView fixWitdh:(CGFloat)fixwidth;

-(void)settingAutoLayoutHeightWithView:(UIView *)culView fixWitdh:(CGFloat)fixwidth;

////当 ....才显示
- (TTGroupViewBaseMake *(^)(id))showIf;

@end


@interface TTGroupViewVerticalItemMake : TTGroupViewBaseMake

- (TTGroupViewVerticalItemMake *(^)(NSString *,SEL,id))viewRadioXib;
- (TTGroupViewVerticalItemMake *(^)(NSString *,SEL,id))viewAutoLayoutXib;
- (TTGroupViewVerticalItemMake *(^)(NSString *,SEL,id))viewAutoLayoutCls;
//自定义高度
- (TTGroupViewVerticalItemMake *(^)(CGFloat))viewCustomHeight;

@end



@interface TTGroupViewHorizontalItemMake : TTGroupViewBaseMake

{
    
@public
    NSString * FixWidth;
    NSString * FixHeight;
    
    BOOL isAutoLayout;
}


- (TTGroupViewHorizontalItemMake *(^)(NSString *,SEL,id))viewRadioXib;
- (TTGroupViewHorizontalItemMake *(^)(NSString *,SEL,id))viewAutoLayoutXib;
- (TTGroupViewHorizontalItemMake *(^)(NSString *,SEL,id))viewAutoLayoutCls;

- (TTGroupViewHorizontalItemMake *(^)(CGFloat))viewFixWidth;
- (TTGroupViewHorizontalItemMake *(^)(CGFloat))viewFixHeight;

- (TTGroupViewHorizontalItemMake *(^)(CGFloat,CGFloat))viewCustomWidthHeight;


////自定义高度
//- (TTGroupViewVerticalItemMake *(^)(CGFloat))viewCustomHeight;

@end

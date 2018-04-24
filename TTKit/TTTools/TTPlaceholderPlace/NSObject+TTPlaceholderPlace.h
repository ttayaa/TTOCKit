//
//  NSObject+TTPlaceholderPlace.h
//  NewProject
//
//  Created by apple on 2018/3/19.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

/**DEMO
 -(void)setModel:(NetDataModel *)model
{
    _model=model;
    TTPlaceholderPlaceFromModel(model, TTPlaceholderPlaceUILabel, nil);
}
 */

//如果模型为nil 那么就设置自己下面的控件
#define TTPlaceholderPlaceFromModel(model,filtertype,color) \
if(!model) \
{ \
    [self TTPlaceholderPlaceOnView:self filterType:filtertype Color:color];\
    return; \
} \


typedef NS_OPTIONS(NSUInteger, TTPlaceholderPlaceType) {
    TTPlaceholderPlaceUILabel  = 1 << 0, //  0001  1
    TTPlaceholderPlaceUITextField_UITextView  = 1 << 1, //  0010  2
    TTPlaceholderPlaceUIButton = 1 << 2, //  0100  4
    TTPlaceholderPlaceUIView  = 1 << 3, //  1000  8
};


@interface NSObject (TTPlaceholderPlace)
-(void)TTPlaceholderPlaceOnView:(UIView*)view filterType:(TTPlaceholderPlaceType)filterType Color:(UIColor *)color;
@end

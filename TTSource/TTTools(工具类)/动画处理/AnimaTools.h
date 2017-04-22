//
//  AnimaTools.h
//  ttayaa
//
//  Created by apple on 16/6/18.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^completion)(BOOL finished);

@interface AnimaTools : NSObject

/**放大1.5倍的动画 0.4s*/
+(void)AnimchangeBigAndDisAppearAnimaWithUIView:(UIView *)view completion:(completion)completion;

/**放大又还原 0.2s*/
+(void)BigToDefaultAnimaWithUIView:(UIView *)view;
@end

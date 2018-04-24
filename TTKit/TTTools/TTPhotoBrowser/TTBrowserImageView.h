//
//  SDBrowserImageView.h
//  SDPhotoBrowser
//
//  Created by apple on 2017/5/14.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTWaitingView.h"


@interface TTBrowserImageView : UIImageView <UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign, readonly) BOOL isScaled;
@property (nonatomic, assign) BOOL hasLoadedImage;
@property (nonatomic ,weak)UILabel *leftInfoLabel;
@property (nonatomic ,weak)UILabel *rightInfoLabel;
- (void)eliminateScale; // 清除缩放

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

- (void)doubleTapToZommWithScale:(CGFloat)scale;

- (void)clear;

@end

//
//  UIScrollView+TTRefreshCustom.h
//  bssc
//
//  Created by apple on 2017/4/9.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTRefreshScrollviewPropertyObserve.h"

@interface UIScrollView (TTRefreshCustom)


typedef void (^TTFingerLeaveBlock)(UIView *view);
typedef void (^TTHeadPullRefreshingFinishBlock)(UIView *view);


-(void)TTCustomHeadRefreshWithView:(UIView *)view whenDownPull:(TTScrollviewContentOffsetChangeBlock)block1 RefreshingWaitingTime:(NSTimeInterval)duration whenRefreshing:(TTFingerLeaveBlock)block2 whenRefreshingFinish:(TTHeadPullRefreshingFinishBlock)block3;

@end

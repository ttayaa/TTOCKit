//
//  UIViewController+TTRefresh.h
//  bssc
//
//  Created by apple on 2017/4/9.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "TTRefresh.h"

//外部可以直接使用宏
#define TTRefreshOrPull -(void)loadDataRefreshOrPull:(TTRefreshState)RefreshState


typedef NS_ENUM(NSInteger, TTRefreshState) {
    
    /** 下拉刷新的状态 */
    TTRefreshing,
    /** pull刷新中的状态 */
    TTPulling,
};


@interface UIViewController (TTRefresh)

/**
 *  是否支持下拉刷新 默认为NO
 */
@property (nonatomic,assign) BOOL dy_isRefresh;
/**
 *  是否可以加载更多 默认为NO
 */
@property (nonatomic,assign) BOOL dy_isLoadMore;
/**
 *  当前访问的page 下标
 */
@property (nonatomic,assign) NSInteger dy_page;
/**
 *
 *  获取当下访问接口下标
 */
-(NSNumber *)getCurrentPage;

@end

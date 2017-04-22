//
//  UIScrollView+TTRefresh.h
//  bssc
//
//  Created by apple on 2017/4/8.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>


static dispatch_once_t ContentInsetOnceToken;

@interface UIScrollView (TTRefresh)

/** <#what is this#>*/
@property (assign,nonatomic) BOOL TTisRefreshing;



typedef void (^TTRefreshingBlock)();
-(void)TTHeadRefresh:(TTRefreshingBlock)block;
-(void)TTFootRefresh:(TTRefreshingBlock)block;



@end

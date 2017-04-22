//
//  TTRefreshScrollviewPropertyObserve.h
//  bssc
//
//  Created by apple on 2017/4/8.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TTScrollviewPanstateChangeBlock)();

typedef void (^TTScrollviewContentOffsetChangeBlock)(CGFloat topOffsetY, CGFloat bottomOffsetY,CGFloat leftOffsetX,CGFloat rightOffsetX);

typedef void (^TTScrollviewContentSizeChangeBlock)(CGSize contentSize);

typedef void (^TTScrollviewContentInsetChangeBlock)(UIEdgeInsets contentInset);


@interface TTRefreshScrollviewPropertyObserve : NSObject

/** <#what is this#>*/
@property (weak, nonatomic) UIScrollView *scrollview;




-(void)observeScrollviewPanStateChange:(TTScrollviewPanstateChangeBlock)block;



-(void)observeScrollviewContentOffsetChange:(TTScrollviewContentOffsetChangeBlock)block1 ContentSizeChange:(TTScrollviewContentSizeChangeBlock)block2 ContentInsetChange:(TTScrollviewContentInsetChangeBlock)block3;

@end

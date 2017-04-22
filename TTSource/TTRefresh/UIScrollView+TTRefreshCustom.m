//
//  UIScrollView+TTRefreshCustom.m
//  bssc
//
//  Created by apple on 2017/4/9.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "UIScrollView+TTRefreshCustom.h"

#import "UIScrollView+TTRefresh.h"
#import <objc/runtime.h>

#define weakify( x )  __weak __typeof__(x) __weak_##x##__ = x;
#define normalize( x ) __typeof__(x) x = __weak_##x##__;


@implementation UIScrollView (TTRefreshCustom)



-(TTRefreshScrollviewPropertyObserve *)scrollviewPropertyObserve
{
    return objc_getAssociatedObject(self, @selector(scrollviewPropertyObserve));
    
}
-(void)setScrollviewPropertyObserve:(TTRefreshScrollviewPropertyObserve *)scrollviewPropertyObserve
{
    objc_setAssociatedObject(self, @selector(scrollviewPropertyObserve), scrollviewPropertyObserve, OBJC_ASSOCIATION_RETAIN);
    
}



///////////////原始的尺寸
-(UIEdgeInsets)CustomOriginalContentInset
{
    return [objc_getAssociatedObject(self, @selector(CustomOriginalContentInset)) UIEdgeInsetsValue] ;
}


-(void)setCustomOriginalContentInset:(UIEdgeInsets)CustomOriginalContentInset
{
    objc_setAssociatedObject(self, @selector(CustomOriginalContentInset), [NSValue valueWithUIEdgeInsets:CustomOriginalContentInset], OBJC_ASSOCIATION_RETAIN);
}




-(void)TTCustomHeadRefreshWithView:(UIView *)view whenDownPull:(TTScrollviewContentOffsetChangeBlock)block1 RefreshingWaitingTime:(NSTimeInterval)duration whenRefreshing:(TTFingerLeaveBlock)block2 whenRefreshingFinish:(TTHeadPullRefreshingFinishBlock)block3
{
    
    CGRect viewFrame = view.frame;
    viewFrame.origin.y = -view.frame.size.height;
    view.frame = viewFrame ;
    
    
    [self addSubview:view];
    
    if (!self.scrollviewPropertyObserve) {
        
        self.scrollviewPropertyObserve = [TTRefreshScrollviewPropertyObserve new];
        self.scrollviewPropertyObserve.scrollview = self;
    }
    
     weakify(self)
    [self.scrollviewPropertyObserve observeScrollviewPanStateChange:^{
       normalize(self)
        
        
        
        
        if (self.contentOffset.y<-view.frame.size.height) {
            
            CGPoint offset = self.contentOffset;
            offset.y = -view.frame.size.height;
            
            [UIView animateWithDuration:0.2 animations:^{
                self.contentOffset = offset;
            }];
            
            
            
            
           block2(view); 
            
            dispatch_once(&ContentInsetOnceToken, ^{
                normalize(self)
                self.CustomOriginalContentInset = self.contentInset;
            });
            
            
            //显示正在刷新的状态
//            [UIView animateWithDuration:duration animations:^{
//                normalize(self)
            
                CGFloat insetTop = self.CustomOriginalContentInset.top+view.frame.size.height;
                
                if ([self isKindOfClass:[UITableView class]] && [self getScollviewCurrentViewController].automaticallyAdjustsScrollViewInsets==YES ) {
                    UITableView *table = (UITableView *)self;
                    if (table.tableHeaderView) {
                        
                        insetTop += 20;
                    }
                    
                }
                
                self.contentInset = UIEdgeInsetsMake(insetTop, self.CustomOriginalContentInset.left, self.CustomOriginalContentInset.bottom, self.CustomOriginalContentInset.right);
                
//            }];
            
            
            
            //还原状态
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                normalize(self)
                [UIView animateWithDuration:0.2 animations:^{
                    normalize(self)
                    self.contentInset = self.CustomOriginalContentInset;
                    block3(view);
                    
                    view.hidden = YES;
                    //                    [defaultView.wait_view startAnimating];
                }];
                
                
            });
            
            
            
            
        }
        
    }];
    
    
    
    [self.scrollviewPropertyObserve observeScrollviewContentOffsetChange:^(CGFloat topOffsetY, CGFloat bottomOffsetY, CGFloat leftOffsetX, CGFloat rightOffsetX) {
        normalize(self)
        
        block1(topOffsetY,bottomOffsetY,leftOffsetX,rightOffsetX);
        
        if ( topOffsetY<0 && self.panGestureRecognizer.state==UIGestureRecognizerStateChanged) {

            view.hidden = NO;
            
        }
        
    } ContentSizeChange:^(CGSize contentSize) {
        
    } ContentInsetChange:^(UIEdgeInsets contentInset) {
        
    }];
    
    


    
}


/** 获取当前View的控制器对象 */
-(UIViewController *)getScollviewCurrentViewController{
    UIResponder *next = [self nextResponder];
    
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end

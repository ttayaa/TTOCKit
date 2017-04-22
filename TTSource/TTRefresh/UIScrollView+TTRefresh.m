//
//  UIScrollView+TTRefresh.m
//  bssc
//
//  Created by apple on 2017/4/8.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "UIScrollView+TTRefresh.h"

#import <objc/runtime.h>


#import "TTRefreshScrollviewPropertyObserve.h"

#import "TTRefreshHeadDefaultView.h"
#import "TTRefreshFootDefaultView.h"


#define weakify( x )  __weak __typeof__(x) __weak_##x##__ = x;
#define normalize( x ) __typeof__(x) x = __weak_##x##__;

#define TTkeyPath(objc,keyPath) @(((void)objc.keyPath, #keyPath))

@implementation UIScrollView (TTRefresh)



+ (void)load{
    
    Method dealloc = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
    Method TTRefresh_dealloc = class_getInstanceMethod(self, @selector(TTRefresh_dealloc));
    method_exchangeImplementations(dealloc, TTRefresh_dealloc);


}



-(TTRefreshScrollviewPropertyObserve *)scrollviewPropertyObserve
{
    return objc_getAssociatedObject(self, @selector(scrollviewPropertyObserve));
    
}
-(void)setScrollviewPropertyObserve:(TTRefreshScrollviewPropertyObserve *)scrollviewPropertyObserve
{
    objc_setAssociatedObject(self, @selector(scrollviewPropertyObserve), scrollviewPropertyObserve, OBJC_ASSOCIATION_RETAIN);
    
}



///////////////原始的尺寸
-(UIEdgeInsets)OriginalContentInset
{
    return [objc_getAssociatedObject(self, @selector(OriginalContentInset)) UIEdgeInsetsValue] ;
}


-(void)setOriginalContentInset:(UIEdgeInsets)OriginalContentInset
{
    objc_setAssociatedObject(self, @selector(OriginalContentInset), [NSValue valueWithUIEdgeInsets:OriginalContentInset], OBJC_ASSOCIATION_RETAIN);
}


-(CGSize)OriginalContentSize
{
    return [objc_getAssociatedObject(self, @selector(OriginalContentSize)) CGSizeValue] ;
}

-(void)setOriginalContentSize:(CGSize)OriginalContentSize
{
    objc_setAssociatedObject(self, @selector(OriginalContentSize), [NSValue valueWithCGSize:OriginalContentSize], OBJC_ASSOCIATION_RETAIN);
}
///////////////原始的尺寸



-(void)TTHeadRefresh:(TTRefreshingBlock)block
{
    
    __block TTRefreshHeadDefaultView *defaultView = [[TTRefreshHeadDefaultView alloc] initWithFrame:CGRectMake(0, -60, [UIScreen mainScreen].bounds.size.width, 60)];
   defaultView.backgroundColor = [UIColor clearColor];
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 20,[UIScreen mainScreen].bounds.size.width, 20)];
    lb.font = [UIFont systemFontOfSize:15];
    lb.textAlignment = NSTextAlignmentCenter;
    defaultView.top_lb = lb;
    
    UIActivityIndicatorView *Activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    Activity.frame =  CGRectMake([UIScreen mainScreen].bounds.size.width/2-85, 15, 30, 30);
    
    defaultView.wait_view = Activity;
    
    [defaultView addSubview:lb];
    [defaultView addSubview:Activity];
    
    
    [self addSubview:defaultView];
    
    
    if (!self.scrollviewPropertyObserve) {
        
        self.scrollviewPropertyObserve = [TTRefreshScrollviewPropertyObserve new];
        self.scrollviewPropertyObserve.scrollview = self;
    }
    
    
    weakify(self)
    [self.scrollviewPropertyObserve observeScrollviewPanStateChange:^{
       normalize(self)
        
       
        
        if (self.contentOffset.y<-60) {
            
            
            defaultView.top_lb.text = @"正在帮您刷新...";
            defaultView.wait_view.hidden = NO;
            [defaultView.wait_view startAnimating];
            
            
//            ttLog(@"%@",NSStringFromCGPoint(self.contentOffset));
//            
//            ttLog(@"%@",NSStringFromUIEdgeInsets(self.contentInset));
//            
//            ttLog(@"%d",[self getWebViewCurrentViewController].automaticallyAdjustsScrollViewInsets);
            
           
            dispatch_once(&ContentInsetOnceToken, ^{
                normalize(self)
                self.OriginalContentInset = self.contentInset;
            });
            
            
            //预留60 显示正在刷新的状态
            [UIView animateWithDuration:0.3 animations:^{
                normalize(self)
                
                CGFloat insetTop = self.OriginalContentInset.top+64;
                
                if ([self isKindOfClass:[UITableView class]] && [self getScollviewCurrentViewController].automaticallyAdjustsScrollViewInsets==YES ) {
                    UITableView *table = (UITableView *)self;
                    if (table.tableHeaderView) {
                        
                        insetTop += 20;
                    }
                  
                }
                
                self.contentInset = UIEdgeInsetsMake(insetTop, self.OriginalContentInset.left, self.OriginalContentInset.bottom, self.OriginalContentInset.right);

                
                
            }];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:0.2 animations:^{
                    normalize(self)
                    self.contentInset = self.OriginalContentInset;
                    block();
                    
                    defaultView.wait_view.hidden = YES;
                    defaultView.top_lb.hidden = YES;
                }];
                
                
            });
                       
        }
       
        
    }];
    

    
    [self.scrollviewPropertyObserve observeScrollviewContentOffsetChange:^(CGFloat topOffsetY, CGFloat bottomOffsetY, CGFloat leftOffsetX, CGFloat rightOffsetX) {
        normalize(self)
        

        if (-60<topOffsetY && topOffsetY<0 && self.panGestureRecognizer.state==UIGestureRecognizerStateChanged) {
            defaultView.top_lb.text = @"下拉可以刷新";
            defaultView.top_lb.hidden = NO;
            defaultView.wait_view.hidden = YES;
        }
        if (topOffsetY<-60 && self.panGestureRecognizer.state==UIGestureRecognizerStateChanged) {
            defaultView.top_lb.text = @"松开立即刷新";
            defaultView.top_lb.hidden = NO;
            defaultView.wait_view.hidden = YES;
        }
        
    } ContentSizeChange:^(CGSize contentSize) {
        
    } ContentInsetChange:^(UIEdgeInsets contentInset) {

    }];
    
    

    
    
    
    
}











-(void)TTFootRefresh:(TTRefreshingBlock)block
{

    
    __block TTRefreshFootDefaultView *defaultView = [[TTRefreshFootDefaultView alloc] initWithFrame:CGRectMake(0, -49, [UIScreen mainScreen].bounds.size.width, 49)];
    defaultView.backgroundColor = [UIColor clearColor];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 20,[UIScreen mainScreen].bounds.size.width, 20)];
    lb.font = [UIFont systemFontOfSize:15];
    lb.textAlignment = NSTextAlignmentCenter;
    defaultView.top_lb = lb;
    
    UIActivityIndicatorView *Activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    Activity.frame =  CGRectMake([UIScreen mainScreen].bounds.size.width/2-115, 15, 30, 30);
    
    defaultView.wait_view = Activity;
    
    [defaultView addSubview:lb];
    [defaultView addSubview:Activity];
    
    
    [self addSubview:defaultView];
    
    defaultView.hidden = YES;
    
    
    
    
    
    if (!self.scrollviewPropertyObserve) {
        
        self.scrollviewPropertyObserve = [TTRefreshScrollviewPropertyObserve new];
        self.scrollviewPropertyObserve.scrollview = self;
    }
    
    
    
    weakify(self)
    [self.scrollviewPropertyObserve observeScrollviewPanStateChange:^{
        normalize(self)
        
        CGFloat topOffsetY = self.contentOffset.y;
        
        CGFloat bottomOffsetY = - ( self.contentSize.height - self.frame.size.height - topOffsetY + self.contentInset.bottom );
        
        
        CGFloat heightspace=0;
        //补回高度差
        if (self.frame.size.height>self.contentSize.height) {
            heightspace = self.frame.size.height - self.contentSize.height;
        }
        
        bottomOffsetY = bottomOffsetY-heightspace;

        
        
        
        if (bottomOffsetY>49) {
            defaultView.top_lb.text = @"正在帮您加载更多数据...";
            defaultView.wait_view.hidden = NO;
            [defaultView.wait_view startAnimating];
            
            
            dispatch_once(&ContentInsetOnceToken, ^{
                normalize(self)
                self.OriginalContentInset = self.contentInset;
            });
            
            //预留60 显示正在刷新的状态
            [UIView animateWithDuration:0.3 animations:^{
                normalize(self)
                
                self.TTisRefreshing = YES;
                
                CGFloat insetBottom = self.OriginalContentInset.bottom+49;
                
                self.contentInset = UIEdgeInsetsMake(self.OriginalContentInset.top, self.OriginalContentInset.left, insetBottom, self.OriginalContentInset.right);
                
            }];
            
            //还原状态
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:0.2 animations:^{
                    normalize(self)
                    self.contentInset = self.OriginalContentInset;
                    block();
                    
                    defaultView.top_lb.hidden = YES;
                    defaultView.wait_view.hidden = YES;
//                    [defaultView.wait_view startAnimating];
                    
                    self.TTisRefreshing = NO;
                }];
                
                
            });
            
            
            
        }
        
        
    }];
    
    
    [self.scrollviewPropertyObserve observeScrollviewContentOffsetChange:^(CGFloat topOffsetY, CGFloat bottomOffsetY, CGFloat leftOffsetX, CGFloat rightOffsetX) {
        normalize(self)
        
        
        CGFloat heightspace=0;
        //补回高度差
        if (self.frame.size.height>self.contentSize.height) {
            heightspace = self.frame.size.height - self.contentSize.height;
        }
        
        bottomOffsetY = bottomOffsetY-heightspace;
        
        
        if (0<bottomOffsetY && bottomOffsetY<49 && self.panGestureRecognizer.state==UIGestureRecognizerStateChanged) {
            
            defaultView.top_lb.text = @"上拉可以加载更多";
            defaultView.hidden = NO;
             defaultView.top_lb.hidden = NO;
            defaultView.wait_view.hidden = YES;
        }
        if ( 49<bottomOffsetY && self.panGestureRecognizer.state==UIGestureRecognizerStateChanged) {
          
            defaultView.top_lb.text = @"松开立即刷新";
            defaultView.hidden = NO;
            defaultView.top_lb.hidden = NO;
            defaultView.wait_view.hidden = YES;
        }
        
        
    } ContentSizeChange:^(CGSize contentSize) {
          normalize(self)
        
        CGRect defaultViewFrame = defaultView.frame;
        defaultViewFrame.origin.y = contentSize.height ;
        defaultView.frame = defaultViewFrame ;
        
        
        if ([self isKindOfClass:[UITableView class]] && [self getScollviewCurrentViewController].automaticallyAdjustsScrollViewInsets==YES ) {
            UITableView *table = (UITableView *)self;
            if (table.tableHeaderView) {
                
                CGRect defaultViewFrame = defaultView.frame;
                defaultViewFrame.origin.y += 20  ;
                defaultView.frame = defaultViewFrame ;
                
            }
            
        }

    } ContentInsetChange:^(UIEdgeInsets contentInset) {
        
        
    }];
    
    

}





//因为scrollview比 TTRefreshScrollviewPropertyObserve 先销毁
//scrollview销毁了之后 苹果就会报 TTRefreshScrollviewPropertyObserve 任然监听着scrollview的属性 ,所以在scrollview销毁的时候 先把TTRefreshScrollviewPropertyObserve 监听的属性销毁



-(void)TTRefresh_dealloc
{
    if (self.scrollviewPropertyObserve) {
        
        [self.panGestureRecognizer removeObserver:self.scrollviewPropertyObserve forKeyPath:TTkeyPath(self.panGestureRecognizer, state) context:nil];
        
        [self removeObserver:self.scrollviewPropertyObserve forKeyPath:TTkeyPath(self, contentOffset) context:nil];
        
        [self removeObserver:self.scrollviewPropertyObserve forKeyPath:TTkeyPath(self, contentSize) context:nil];
        
        [self removeObserver:self.scrollviewPropertyObserve forKeyPath:TTkeyPath(self, contentInset) context:nil];
        
        
         ContentInsetOnceToken = 0;

    }
    
    
     [self TTRefresh_dealloc];
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





@dynamic TTisRefreshing;
-(BOOL)TTisRefreshing
{
    return [objc_getAssociatedObject(self, @selector(TTisRefreshing)) boolValue] ;
}

-(void)setTTisRefreshing:(BOOL)TTisRefreshing
{
    objc_setAssociatedObject(self, @selector(TTisRefreshing), @(TTisRefreshing), OBJC_ASSOCIATION_RETAIN);
}




@end

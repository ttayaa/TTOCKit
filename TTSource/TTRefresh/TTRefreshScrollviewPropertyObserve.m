//
//  TTRefreshScrollviewPropertyObserve.m
//  bssc
//
//  Created by apple on 2017/4/8.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "TTRefreshScrollviewPropertyObserve.h"

#import <objc/runtime.h>
#import "TTRefreshWeakScrollView.h"


#define weakify( x )  __weak __typeof__(x) __weak_##x##__ = x;
#define normalize( x ) __typeof__(x) x = __weak_##x##__;

#define TTkeyPath(objc,keyPath) @(((void)objc.keyPath, #keyPath))

@implementation TTRefreshScrollviewPropertyObserve


//包装一个弱Scrollview指针
-(TTRefreshWeakScrollView *)Weak_scrollview
{
    return objc_getAssociatedObject(self, @selector(Weak_scrollview));
}

-(void)setWeak_scrollview:(TTRefreshWeakScrollView *)Weak_scrollview
{
    objc_setAssociatedObject(self, @selector(Weak_scrollview), Weak_scrollview, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



//通过这里获得弱指针scrollview
@dynamic scrollview;

-(UIScrollView *)scrollview
{
    return self.Weak_scrollview.weakScrollView;
}

-(void)setScrollview:(UIScrollView *)scrollview
{
    //懒加载对象
    if (!self.Weak_scrollview) {
        self.Weak_scrollview = [TTRefreshWeakScrollView new];
    }
    self.Weak_scrollview.weakScrollView = scrollview;
}



-(NSMutableArray<TTScrollviewPanstateChangeBlock> *)PanstateChangeblockArr
{
    //懒加载对象
    if (!objc_getAssociatedObject(self, @selector(PanstateChangeblockArr))) {
        self.PanstateChangeblockArr = [NSMutableArray array];
    }
        
    return objc_getAssociatedObject(self, @selector(PanstateChangeblockArr));

}
-(void)setPanstateChangeblockArr:(NSMutableArray<TTScrollviewPanstateChangeBlock> *)PanstateChangeblockArr
{
    objc_setAssociatedObject(self, @selector(PanstateChangeblockArr), PanstateChangeblockArr, OBJC_ASSOCIATION_RETAIN);

}





-(NSMutableArray<TTScrollviewContentOffsetChangeBlock> *)ContentOffsetChangeblockArr
{
    if (!objc_getAssociatedObject(self, @selector(ContentOffsetChangeblockArr))) {
        self.ContentOffsetChangeblockArr = [NSMutableArray array];
    }
    
    
    return objc_getAssociatedObject(self, @selector(ContentOffsetChangeblockArr));
}
-(void)setContentOffsetChangeblockArr:(NSMutableArray<TTScrollviewContentOffsetChangeBlock> *)ContentOffsetChangeblockArr
{
    objc_setAssociatedObject(self, @selector(ContentOffsetChangeblockArr), ContentOffsetChangeblockArr, OBJC_ASSOCIATION_RETAIN);
}




-(NSMutableArray<TTScrollviewContentSizeChangeBlock> *)ContentSizeChangeblockArr
{
    if (!objc_getAssociatedObject(self, @selector(ContentSizeChangeblockArr))) {
        self.ContentSizeChangeblockArr = [NSMutableArray array];
    }
    
    
    return objc_getAssociatedObject(self, @selector(ContentSizeChangeblockArr));
}
-(void)setContentSizeChangeblockArr:(NSMutableArray<TTScrollviewContentSizeChangeBlock> *)ContentSizeChangeblockArr
{
    objc_setAssociatedObject(self, @selector(ContentSizeChangeblockArr), ContentSizeChangeblockArr, OBJC_ASSOCIATION_RETAIN);
}





-(NSMutableArray<TTScrollviewContentInsetChangeBlock> *)ContentInsetChangeblockArr
{
    if (!objc_getAssociatedObject(self, @selector(ContentInsetChangeblockArr))) {
        self.ContentInsetChangeblockArr = [NSMutableArray array];
    }
    
    return objc_getAssociatedObject(self, @selector(ContentInsetChangeblockArr));
}
-(void)setContentInsetChangeblockArr:(NSMutableArray<TTScrollviewContentInsetChangeBlock> *)ContentInsetChangeblockArr
{
    objc_setAssociatedObject(self, @selector(ContentInsetChangeblockArr), ContentInsetChangeblockArr, OBJC_ASSOCIATION_RETAIN);
}








//记录是否已经监听 panstate 了
-(BOOL)IS_setPanKVO
{
    return [objc_getAssociatedObject(self, @selector(IS_setPanKVO)) boolValue] ;
}


-(void)setIS_setPanKVO:(BOOL)IS_setPanKVO
{
    objc_setAssociatedObject(self, @selector(IS_setPanKVO), @(IS_setPanKVO), OBJC_ASSOCIATION_RETAIN);
}




-(void)observeScrollviewPanStateChange:(TTScrollviewPanstateChangeBlock)block
{
    
    [self.PanstateChangeblockArr addObject:block];
//
//    
    //如果没有设置过pan的kvo
    if (!self.IS_setPanKVO) {
   
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
//
        [self.scrollview.panGestureRecognizer addObserver:self forKeyPath:TTkeyPath(self.scrollview.panGestureRecognizer, state) options:options context:nil];
    
        self.IS_setPanKVO = 1;
    }
    
}






//记录是否已经监听 panstate 了
-(BOOL)IS_setScollSizeKVO
{
    return [objc_getAssociatedObject(self, @selector(IS_setScollSizeKVO)) boolValue] ;
}


-(void)setIS_setScollSizeKVO:(BOOL)IS_setScollSizeKVO
{
    objc_setAssociatedObject(self, @selector(IS_setScollSizeKVO), @(IS_setScollSizeKVO), OBJC_ASSOCIATION_RETAIN);
}




-(void)observeScrollviewContentOffsetChange:(TTScrollviewContentOffsetChangeBlock)block1 ContentSizeChange:(TTScrollviewContentSizeChangeBlock)block2 ContentInsetChange:(TTScrollviewContentInsetChangeBlock)block3
{
    
    [self.ContentOffsetChangeblockArr addObject:block1];
    [self.ContentSizeChangeblockArr addObject:block2];
    [self.ContentInsetChangeblockArr addObject:block3];
    
    //如果没有设置过ContentOffset的kvo
    if (!self.IS_setScollSizeKVO) {
        
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        
        [self.scrollview addObserver:self forKeyPath:TTkeyPath(self.scrollview, contentOffset) options:options context:nil];
        
        [self.scrollview addObserver:self forKeyPath:TTkeyPath(self.scrollview, contentSize) options:options context:nil];
        
        [self.scrollview addObserver:self forKeyPath:TTkeyPath(self.scrollview, contentInset) options:options context:nil];
        
        
        self.IS_setScollSizeKVO = 1;
        
    }
}



#warning 已经在scrollview分类中销毁了
//- (void)dealloc
//{
//    [self.scrollview.panGestureRecognizer removeObserver:self forKeyPath:TTkeyPath(self.scrollview.panGestureRecognizer, state) context:nil];
//    
//    [self.scrollview removeObserver:self forKeyPath:TTkeyPath(self.scrollview, contentOffset) context:nil];
//
//}

- (void)dealloc
{
    
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    
    if ([TTkeyPath(self.scrollview.panGestureRecognizer,state) isEqualToString:keyPath])
    {
        NSInteger new = [[change objectForKey:@"new"] integerValue];
//       ttLog(@"%ld",new);
        //如果为松手状态
        if (new==UIGestureRecognizerStateEnded) {

            [self.PanstateChangeblockArr enumerateObjectsUsingBlock:^(TTScrollviewPanstateChangeBlock  _Nonnull block, NSUInteger idx, BOOL * _Nonnull stop) {
                
                block();
                
            }];
        }
        
        
    }
    
    if ([TTkeyPath(self.scrollview,contentOffset) isEqualToString:keyPath])
    {
        
        NSValue *pointValue = (NSValue *)[change objectForKey:@"new"];
        
        CGPoint point = [pointValue CGPointValue];
        
        CGFloat topOffsetY = point.y;
        
        CGFloat bottomOffsetY = - ( self.scrollview.contentSize.height - self.scrollview.frame.size.height - topOffsetY + self.scrollview.contentInset.bottom );
        
        CGFloat leftOffsetX = point.x;
        
        CGFloat rightOffsetX = - ( self.scrollview.contentSize.width - self.scrollview.frame.size.width - leftOffsetX + self.scrollview.contentInset.right );
        
        [self.ContentOffsetChangeblockArr enumerateObjectsUsingBlock:^(TTScrollviewContentOffsetChangeBlock  _Nonnull block, NSUInteger idx, BOOL * _Nonnull stop) {
            
            block(topOffsetY,bottomOffsetY,leftOffsetX,rightOffsetX);
        }];
    
    }
    
    if ([TTkeyPath(self.scrollview,contentSize) isEqualToString:keyPath])
    {
        [self.ContentSizeChangeblockArr enumerateObjectsUsingBlock:^(TTScrollviewContentSizeChangeBlock  _Nonnull block, NSUInteger idx, BOOL * _Nonnull stop) {
            
            block(self.scrollview.contentSize);
        }];
    }
    
    if ([TTkeyPath(self.scrollview,contentInset) isEqualToString:keyPath])
    {
        [self.ContentInsetChangeblockArr enumerateObjectsUsingBlock:^(TTScrollviewContentInsetChangeBlock  _Nonnull block, NSUInteger idx, BOOL * _Nonnull stop) {
            
            block(self.scrollview.contentInset);
        }];
    }

}



@end

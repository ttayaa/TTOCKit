//
//  UIViewController+TTRefresh.m
//  bssc
//
//  Created by apple on 2017/4/9.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "UIViewController+TTRefresh.h"

#define weakify( x )  __weak __typeof__(x) __weak_##x##__ = x;
#define normalize( x ) __typeof__(x) x = __weak_##x##__;

@implementation UIViewController (TTRefresh)


@dynamic dy_page;
@dynamic dy_isRefresh;
@dynamic dy_isLoadMore;


-(void)setDy_isRefresh:(BOOL)dy_isRefresh
{
    
    if (dy_isRefresh) {
        
        
        if ([self respondsToSelector:@selector(setTableView:)]) {
            
            UITableView *table = [self performSelector:@selector(tableView)];
            table.tableFooterView      = [UIView new];
            table.showsHorizontalScrollIndicator = NO;
            table.showsVerticalScrollIndicator   = NO;
            
            weakify(self)
            [table TTHeadRefresh:^{
                normalize(self)
                
                [self loadDataRefreshOrPull:TTRefreshing];
                self.dy_page = 0;
            }];
        }
        
        if ([self respondsToSelector:@selector(setCollectionView:)]) {
            
            UICollectionView *collect = [self performSelector:@selector(collectionView)];
            
            collect.showsHorizontalScrollIndicator = NO;
            collect.showsVerticalScrollIndicator   = NO;
            
            weakify(self)
            [collect TTHeadRefresh:^{
                normalize(self)
                
                [self loadDataRefreshOrPull:TTRefreshing];
                self.dy_page = 0;
            }];
            
        }
    }
    
}


-(void)setDy_isLoadMore:(BOOL)dy_isLoadMore
{
    
    if (dy_isLoadMore) {
        
        if ([self respondsToSelector:@selector(setTableView:)]) {
            
            UITableView *table = [self performSelector:@selector(tableView)];
            table.tableFooterView      = [UIView new];
            table.showsHorizontalScrollIndicator = NO;
            table.showsVerticalScrollIndicator   = NO;
            
            
            
            weakify(self)
            [table TTFootRefresh:^{
                normalize(self)
                
                [self loadDataRefreshOrPull:TTPulling];
                self.dy_page = 0;
            }];
            
        }
        
        
        
        if ([self respondsToSelector:@selector(setCollectionView:)]) {
            
            UICollectionView *collect = [self performSelector:@selector(collectionView)];
            
            collect.showsHorizontalScrollIndicator = NO;
            collect.showsVerticalScrollIndicator   = NO;
            
            weakify(self)
            [collect TTFootRefresh:^{
                normalize(self)
                
                [self loadDataRefreshOrPull:TTPulling];
                self.dy_page = 0;
            }];
            
        }
        
        
    }
    
    
    
}



-(NSNumber *)getCurrentPage{
    return [NSNumber numberWithInteger:++self.dy_page];
}



//这个方法是我们重写的
-(void)loadDataRefreshOrPull:(TTRefreshState)RefreshState
{
    
}


@end

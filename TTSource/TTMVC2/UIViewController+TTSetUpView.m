//
//  UIViewController+TTSetUpView.m
//  bssc
//
//  Created by apple on 2017/3/24.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "UIViewController+TTSetUpView.h"

@implementation UIViewController (TTSetUpView)


-(void)TTSetupTableView:(CGRect)frame separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle tableFooterView:(UIView*)tableFooterView extSetupBlock:(TTTable_extsetUp)extblock
{
    
    
    BOOL isUITableViewController = NO;
    
    if ([self respondsToSelector:@selector(setTableView:)])
    {
        isUITableViewController = YES;
    }
    
    if (isUITableViewController) {
        UITableView *table = [self performSelector:@selector(tableView)];
        table.separatorStyle = separatorStyle;
        table.tableFooterView = tableFooterView;
       
        extblock(table);
    }
    else
    {
        UITableView *table = [[UITableView alloc] initWithFrame:frame];
        
        [self.view addSubview:table];
        table.separatorStyle = separatorStyle;
        table.tableFooterView = tableFooterView;
    }
    
    
}


-(void)TTSetupColletionView:(CGRect)frame Layout:(UICollectionViewLayout *)Layout  extSetupBlock:(TTColletion_extsetUp)extblock
{
    BOOL isUICollectionViewController = NO;
    
    if ([self respondsToSelector:@selector(setCollectionView:)]) {
        {
            isUICollectionViewController = YES;
        }
        
        if (isUICollectionViewController) {
            UICollectionView *collection = [self performSelector:@selector(collectionView)];
            
            [NSException raise:@"UICollectionViewController中必须重写init方法添加布局对象" format:@"- (instancetype)init{UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];return [super initWithCollectionViewLayout:flowLayout];}"];
            
            collection.collectionViewLayout = Layout;
            
            extblock(collection);
        }
        else
        {
            
            
            UICollectionView *collection = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:Layout];
            
            extblock(collection);
            
        }
        
    }
}
@end

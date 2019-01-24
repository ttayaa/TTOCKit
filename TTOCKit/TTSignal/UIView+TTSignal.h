//
//  UIView+TTSignal.h
//  testproject
//
//  Created by apple on 2018/4/10.
//  Copyright © 2018年 ttayaa. All rights reserved.
//




#import <UIKit/UIKit.h>

@interface UIView (TTSignal)
/**signal name*/
@property (nonatomic,copy)NSString *clickSignalName;

@property (nonatomic,readonly)NSIndexPath *indexPath;

@property (nonatomic,strong)UITableViewCell *TableViewCell;
@property (nonatomic,strong)UICollectionViewCell *CollectionViewCell;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,assign)UIView *(^setSignalName)(NSString * signalName);

@property (nonatomic,assign)UIView *(^enforceTarget)(NSObject *target);

@end

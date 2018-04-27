//
//  UIView+TTSignal.h
//  testproject
//
//  Created by apple on 2018/4/10.
//  Copyright © 2018年 ttayaa. All rights reserved.
//




#import <UIKit/UIKit.h>

@interface UIView (TTSignal)
@property(nonatomic,readonly)UIViewController* viewController;
/**signal name*/
@property (nonatomic,copy)NSString *clickSignalName;

@property (nonatomic,readonly)NSIndexPath *indexPath;

@property (nonatomic,copy)UITableViewCell *TableViewCell;
@property (nonatomic,copy)UICollectionViewCell *CollectionViewCell;

@property (nonatomic,assign)UIView *(^setSignalName)(NSString * signalName);

@property (nonatomic,assign)UIView *(^enforceTarget)(NSObject *target);

@property (nonatomic,assign)UIView *(^controlEvents)(UIControlEvents event);

@property (nonatomic,assign,readonly)NSUInteger sections;//returns nil or a integer,when you want to use it,you should associated  UITableViewHeaderFooterView "tag" protery assignment a intgeter value

@property(nonatomic,assign) UIControlEvents allControlEvents;
@end

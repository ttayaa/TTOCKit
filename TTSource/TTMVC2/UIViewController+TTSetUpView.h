//
//  UIViewController+TTSetUpView.h
//  bssc
//
//  Created by apple on 2017/3/24.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TTTable_extsetUp)(UITableView * tableView);
typedef void (^TTColletion_extsetUp)(UICollectionView * tableView);


@interface UIViewController (TTSetUpView)

-(void)TTSetupTableView:(CGRect)frame separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle tableFooterView:(UIView*)tableFooterView extSetupBlock:(TTTable_extsetUp)extblock;


-(void)TTSetupColletionView:(CGRect)frame Layout:(UICollectionViewLayout *)Layout  extSetupBlock:(TTColletion_extsetUp)extblock;

@end

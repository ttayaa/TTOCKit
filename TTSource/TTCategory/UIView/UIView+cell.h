//
//  UIView+cell.h
//  ttayaa微博部署
//
//  Created by apple on 16/5/22.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (cell)

+ (instancetype)tableViewCellFromXib:(UITableView *)tableview;
//按照宽度比例计算出cell的高度
+(CGFloat)XibHeight:(CGFloat)tableViewWidth;


+ (instancetype)tableViewCellFromDaiMa:(UITableView *)tableview;

+ (instancetype)CollectionViewCellFromXib:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

+ (instancetype)CollectionViewCellFromDaiMa:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

+ (instancetype)ViewFromXib;
@end

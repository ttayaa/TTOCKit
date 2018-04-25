//
//  UIView+cell.m
//  ttayaa微博部署
//
//  Created by apple on 16/5/22.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import "UIView+cell.h"

@implementation UIView (cell)

static NSString * CellID = @"cell";

/**带有标识的Cell,并且注册,外部不需要注册  */
+ (instancetype)tableViewCellFromXib:(UITableView *)tableview;
{
    
    
    //如果在cellForItemAtIndexPath 数据源方法调用时才注册   注册多次 这个和tableview是有区别的
    //如果在cellForItemAtIndexPath 数据源方法调用前 注册  只用注册一次 (哈哈为了调用方便还是每次都调吧)
    
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
    [tableview registerNib:nib forCellReuseIdentifier:NSStringFromClass(self)];
    
    //如果缓存池没有ID标识的 ,因为注册过了系统会自动创建这个ID标识的Cell
    UITableViewCell * cell = [tableview dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    
    //取消cell选中状态
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


+(CGFloat)XibHeight:(CGFloat)tableViewWidth;
{
    UIView *view = [self ViewFromXib];
    
    CGRect frame = view.frame;
    //    保证xib的height原始比
    CGFloat WHscale = frame.size.width/frame.size.height;
    frame.size.width = tableViewWidth;
    frame.size.height =tableViewWidth / WHscale;
    
    return frame.size.height;
}




/**非循环利用就使用这个加载XIB的cell*/
+ (instancetype)ViewFromXib
{
    
    return [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


+ (instancetype)ViewFromXibWithIndex:(NSInteger)idx
{
    
    return [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] objectAtIndex:idx];
}


+ (instancetype)CollectionViewCellFromXib:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath
{
    //只用注册一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UINib *nib = [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
        [collectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass(self)];
    });
    
    //如果缓存池没有ID标识的 ,因为注册过了系统会自动创建这个ID标识的Cell
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self) forIndexPath:indexPath];
    
    
    return cell;
    
}

+ (instancetype)tableViewCellFromCode:(UITableView *)tableview
{
    //只用注册一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [tableview registerClass:[self class] forCellReuseIdentifier:NSStringFromClass(self)];
    });
    
    //如果缓存池没有ID标识的 ,因为注册过了系统会自动创建这个ID标识的Cell
    UITableViewCell * cell = [tableview dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    
    return cell;
    
}

+ (instancetype)CollectionViewCellFromCode:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;
{
    
    //如果在cellForItemAtIndexPath 数据源方法调用时才注册   注册多次 这个和tableview是有区别的
    //如果在cellForItemAtIndexPath 数据源方法调用前 注册  只用注册一次 (哈哈为了调用方便还是每次都调吧)
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass(self)];
    
    
    //如果缓存池没有ID标识的 ,因为注册过了系统会自动创建这个ID标识的Cell
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self) forIndexPath:indexPath];
    return cell;
}




@end

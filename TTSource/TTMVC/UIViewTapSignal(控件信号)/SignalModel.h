//
//  Signal.h
//  elmsc
//
//  Created by apple on 16/8/5.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignalModel : NSObject

/** 存储事件*/
@property (strong, nonatomic) NSSet<UITouch *> * touches;

/** 存储点击的view 这个view设置了clicksignal属性*/
@property (strong, nonatomic) UIView *view;

///** 存储点击的view 这个view是当前页面你点击最顶端的view 不一定设置clicksignal属性*/
//@property (strong, nonatomic) UIView *clickView;

/** 存储手势针对 UIControl类型*/
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;

/** 存储点击的tableViewCell  比如可以做动画啊*/
@property (strong, nonatomic) UITableViewCell *tableViewCell;

/** 存储点击的collectionViewCell  比如可以做动画啊*/
@property (strong, nonatomic) UICollectionViewCell *collectionViewCell;

/**子控件传递进来的参数obj*/
@property (strong, nonatomic) id argsObj;

/** 存储点击cell的indexPath*/
@property (strong, nonatomic) NSIndexPath *indexPath;

/** 存储点击的tableview或者Collectionview*/
@property (strong, nonatomic) UIScrollView *targetView;



/**如果是tableview 存储被点击的cell的tableview*/
@property (strong, nonatomic) UITableView *tableview;

/**如果是CollectionView 存储被点击的cell的tableview*/
@property (strong, nonatomic) UICollectionView *collectionView;


/**如果是tableview中嵌套collectionview （点击collectionview中的collectionview的cellhead头这个属性会有值）*/
@property (nonatomic,strong) NSIndexPath *tableviewIndexPath;
/**如果是tableview中嵌套collectionview （点击collectionview中的collectionview的cellhead头这个属性会有值）*/
@property (nonatomic,strong) NSArray<NSIndexPath *> * collectionviewIndexPathArr;


/**如果是collectionview中嵌套tableview （点击tableview中的tableview的cellhead这个属性会有值）*/
@property (nonatomic,strong) NSIndexPath *collectionviewIndexPath;

@end

//
//  UIView+TTVM.h
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/8/25.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTGroupViewBaseMake.h"

@interface UIView (TTVM)


@property (assign,nonatomic) CGFloat TTVMx;
@property (assign,nonatomic) CGFloat TTVMy;
@property (nonatomic, assign) CGFloat TTVMwidth;
@property (nonatomic, assign) CGFloat TTVMheight;




typedef void (^TTGroupViewCountBlock)(NSInteger groupCount);
typedef void (^TTGroupViewObserver)(TTGroupViewCountBlock CountBlock);


typedef void (^TTGroupViewVerticalItemMakeBlock)(TTGroupViewVerticalItemMake *makeItem,NSInteger row);

typedef void (^TTGroupViewHorizontalItemMakeBlock)(TTGroupViewHorizontalItemMake *makeItem,NSInteger row);



typedef void (^TTGroupViewEachViewBlock)(UIView *view,NSInteger row);


//类方法
+(UIView *)TTGroupView_VerticalLayout:(TTGroupViewObserver)groupViewCountBlock eachItem:(TTGroupViewVerticalItemMakeBlock)groupViewItemMakeBlock eachView:(TTGroupViewEachViewBlock)groupViewEachViewBlock;


//类方法
+(UIView *)TTGroupView_horizontalLayout:(TTGroupViewObserver)groupViewObserver eachItem:(TTGroupViewHorizontalItemMakeBlock)eachGroupViewHorizontalItemMakeBlock eachView:(TTGroupViewEachViewBlock)eachGroupViewEachViewBlock;


//对象方法(调用这个方法可以刷新数据)
-(void)reloadTTGroupView;


@end

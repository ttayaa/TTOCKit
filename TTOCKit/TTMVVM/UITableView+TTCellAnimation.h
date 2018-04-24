//
//  UITableView+TTCellAnimation.h
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,TTTableCellAnimationType){
    TTTableCellAnimationTypeMove = 0,//左边弹簧依次出来
    TTTableCellAnimationTypeAlpha,//从上到下渐变出来
    TTTableCellAnimationTypeFall,//从上到下掉下来 先掉最后一个
    TTTableCellAnimationTypeShake,//左右弹簧交叉出来
    TTTableCellAnimationTypeOverTurn,//从上到下依次上下翻滚出来
    TTTableCellAnimationTypeToTop,//从下往上出来 先出第一个
    TTTableCellAnimationTypeSpringList,//从上到下掉下来 先掉第一个
    TTTableCellAnimationTypeShrinkToTop,//每个cell 往上靠近自己的位置
    TTTableCellAnimationTypeLayDown,//从上到下 层叠出来
    TTTableCellAnimationTypeRote,//从上到下 左右翻滚出来
};

@interface TTTableCellAnimate : NSObject<UICollisionBehaviorDelegate>

+ (void)showWithAnimationType:(TTTableCellAnimationType)animationType tableView:(UITableView *)tableView;

+ (void)moveAnimationWithTableView:(UITableView *)tableView;
+ (void)alphaAnimationWithTableView:(UITableView *)tableView;
+ (void)fallAnimationWithTableView:(UITableView *)tableView;
+ (void)shakeAnimationWithTableView:(UITableView *)tableView;
+ (void)overTurnAnimationWithTableView:(UITableView *)tableView;
+ (void)toTopAnimationWithTableView:(UITableView *)tableView;
+ (void)springListAnimationWithTableView:(UITableView *)tableView;
+ (void)shrinkToTopAnimationWithTableView:(UITableView *)tableView;
+ (void)layDownAnimationWithTableView:(UITableView *)tableView;
+ (void)roteAnimationWithTableView:(UITableView *)tableView;

@end


@interface UITableView (TTCellAnimation)
- (void)TTTableCellAnimationWithType:(TTTableCellAnimationType )animationType;

@end

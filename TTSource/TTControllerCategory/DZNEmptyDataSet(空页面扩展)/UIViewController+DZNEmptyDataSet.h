//
//  UIViewController+DZNEmptyDataSet.h
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 RecruitTreasure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTControllerCategoryHeader.h"
#import "UIScrollView+EmptyDataSet.h"

@interface UIViewController (DZNEmptyDataSet)<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

/**
 *  是否展示空白页 默认为YES
 */
@property(nonatomic,assign)BOOL dy_isShowEmpty;

/**
 *  空白页的标题 默认为 “" 为空不显示
 */
@property(nonatomic,copy) NSString *dy_titleForEmpty;
/**
 *  空白页的副标题 默认为 “" 为空不显示
 */
@property(nonatomic,copy) NSString *dy_descriptionForEmpty;
/**
 *  空白页展位图名称 默认为 “img_placehoder_icon" 为空或nil无图片
 */
@property(nonatomic,copy) NSString *dy_imageNameForEmpty;

@end

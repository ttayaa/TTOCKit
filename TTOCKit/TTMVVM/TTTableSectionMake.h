//
//  TTTableSectionMake.h
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/8/31.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTTableBaseMake : NSObject

-(CGFloat)culRadioHeightWithtempView:(UIView *)tempView;

-(CGFloat)culAutoLayoutHeightWithtempView:(UIView *)tempView table:(UITableView *)tableView;

@end

@interface TTTableItemMake : TTTableBaseMake
{
    @public
    
    NSString * _cellCustomHeight;
}



//根据xib中的比例布局
- (TTTableItemMake *(^)(NSString *,SEL,id))CellRadioXib;
//当 ....才显示
//根据xib中的自动布局
- (TTTableItemMake *(^)(NSString *,SEL,id))CellAutoLayoutXib;
//根据 非xib类 中的自动布局
- (TTTableItemMake *(^)(NSString *,SEL,id))CellAutoLayoutCls;

//自定义高度
- (TTTableItemMake *(^)(CGFloat))CellCustomHeight;
//当 ....才显示
- (TTTableItemMake *(^)(id))CellshowIf;


@property (nonatomic,copy) CGFloat (^CellHeight)(UITableView *tableView,NSIndexPath* indexPath);
@property (nonatomic,copy) UITableViewCell* (^Cell)(UITableView *tableView,NSIndexPath* indexPath);
@property (nonatomic,copy) void (^SelectRow)(UITableView *tableView,NSIndexPath* indexPath);

@end



@interface TTTableSectionMake : TTTableBaseMake
{
    @public
    
    NSInteger _rows;

    NSString * _headerCustomHeight;
    
    NSString * _footerCustomHeight;
}






- (TTTableSectionMake *(^)(NSInteger))rows;

- (TTTableSectionMake *(^)(NSString *,SEL,id))HeaderRadioXib;
- (TTTableSectionMake *(^)(NSString *,SEL,id))HeaderAutoLayoutXib;
- (TTTableSectionMake *(^)(NSString *,SEL,id))HeaderAutoLayoutCls;
//自定义高度
- (TTTableSectionMake *(^)(CGFloat))HeaderCustomHeight;
//当 ....才显示
- (TTTableSectionMake *(^)(id))HeaderShowIf;


- (TTTableSectionMake *(^)(NSString *,SEL,id))FooterRadioXib;
- (TTTableSectionMake *(^)(NSString *,SEL,id))FooterAutoLayoutXib;
- (TTTableSectionMake *(^)(NSString *,SEL,id))FooterAutoLayoutCls;
//自定义高度
- (TTTableSectionMake *(^)(CGFloat))FooterCustomHeight;
//当 ....才显示
- (TTTableSectionMake *(^)(id))FooterShowIf;


@property (nonatomic,copy) UIView* (^viewForHeaderInSection)(UITableView *tableView,NSInteger section);
@property (nonatomic,copy) CGFloat (^heightForHeaderInSection)(UITableView *tableView,NSInteger section);

@property (nonatomic,copy) UIView* (^viewForFooterInSection)(UITableView *tableView,NSInteger section);
@property (nonatomic,copy) CGFloat (^heightForFooterInSection)(UITableView *tableView,NSInteger section);


@property (strong, nonatomic) NSMutableArray<TTTableItemMake*> *TTTableItemMakeArr;
@end

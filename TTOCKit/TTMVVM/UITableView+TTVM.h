//
//  UITableView+TTVM.h
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/8/30.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTableSectionMake.h"




@interface UITableView (TTVM)

typedef void (^TTTableSectionCountBlock)(NSInteger groupCount);
typedef void (^TTTableConfigureBlock)(TTTableSectionCountBlock SectionCount);

typedef void (^EachSectionBlock)(TTTableSectionMake *makeSection, NSInteger section);
typedef void (^EachSectionItemBlock)(TTTableItemMake * makeItem,NSInteger section,NSInteger row);
typedef void (^EachCellBlock)(UITableViewCell *cell,NSInteger section,NSInteger row);
typedef void (^EachCellHeaderFooterBlock)(UITableViewHeaderFooterView *cellHeader,UITableViewHeaderFooterView *cellFooter,NSInteger section);


@property (strong, nonatomic) EachSectionBlock eachSectionBlock;
@property (strong, nonatomic) EachSectionItemBlock eachSectionItemBlock;
@property (strong, nonatomic) EachCellBlock eachCellBlock;
@property (strong, nonatomic) EachCellHeaderFooterBlock eachCellHeaderFooterBlock;




-(NSMutableDictionary *)HeightCatchDict;

@property (strong, nonatomic) NSMutableArray<TTTableSectionMake*> *TTTableSectionMakeArr;



-(void)TTGroup:(TTTableConfigureBlock)configureBlock eachSection:(EachSectionBlock)sectionBlock eachSectionItemCell:(EachSectionItemBlock)sectionItemBlock eachCellBlock:(EachCellBlock)cellBlock eachCellHeaderFooterBlock:(EachCellHeaderFooterBlock)cellHeaderFooterBlock;

@end


/* 这里代理方法的宏已经帮您写好
 
 你只用在控制器写上 TTTableViewDatasoureDelegate 即可
 
 
 或者您可以分别导入 比如某个代理方法您需要自定义
 **/


#define TTTableViewDatasoureDelegate \
TT_numberOfSectionsInTableView \
TT_numberOfRowsInSection \
TT_cellForRowAtIndexPath \
TT_estimatedHeightForRowAtIndexPath \
TT_heightForRowAtIndexPath \
TT_viewForHeaderInSection \
TT_estimatedHeightForHeaderInSection \
TT_heightForHeaderInSection \
TT_viewForFooterInSection \
TT_estimatedHeightForFooterInSection \
TT_heightForFooterInSection \




#define TT_numberOfSectionsInTableView \
        -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { \
            tableView.estimatedRowHeight = 0; \
            tableView.estimatedSectionHeaderHeight = 0; \
            tableView.estimatedSectionFooterHeight = 0;\
            if (tableView.TTTableSectionMakeArr) { \
                return tableView.TTTableSectionMakeArr.count; \
            } \
            return 0; \
        } \

#define TT_numberOfRowsInSection \
        -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { \
            if (tableView.TTTableSectionMakeArr[section].TTTableItemMakeArr) { \
                return tableView.TTTableSectionMakeArr[section].TTTableItemMakeArr.count; \
            } \
            return 0; \
        } \

#define TT_cellForRowAtIndexPath \
        -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { \
            if (tableView.TTTableSectionMakeArr[indexPath.section].TTTableItemMakeArr[indexPath.row]) { \
                UITableViewCell *cell = tableView.TTTableSectionMakeArr[indexPath.section].TTTableItemMakeArr[indexPath.row].Cell(tableView,indexPath); \
                return cell; \
            } \
            return nil; \
        } \


#define TT_estimatedHeightForRowAtIndexPath \
        -(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath { \
            if (tableView.TTTableSectionMakeArr[indexPath.section].TTTableItemMakeArr[indexPath.row]) { \
                CGFloat height = tableView.TTTableSectionMakeArr[indexPath.section].TTTableItemMakeArr[indexPath.row].CellHeight(tableView,indexPath); \
                return height; \
            } \
            return 44; \
        } \

#define TT_heightForRowAtIndexPath \
        -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath { \
            if (tableView.TTTableSectionMakeArr[indexPath.section].TTTableItemMakeArr[indexPath.row]) { \
                CGFloat height = tableView.TTTableSectionMakeArr[indexPath.section].TTTableItemMakeArr[indexPath.row].CellHeight(tableView,indexPath); \
                return height; \
            } \
            return 0; \
        } \

#define TT_viewForHeaderInSection \
        - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section { \
            if (tableView.TTTableSectionMakeArr[section]) { \
                return tableView.TTTableSectionMakeArr[section].viewForHeaderInSection(tableView,section); \
            } \
            return nil; \
        } \

#define TT_estimatedHeightForHeaderInSection \
        -(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section { \
            if (tableView.TTTableSectionMakeArr[section]) { \
                return tableView.TTTableSectionMakeArr[section].heightForHeaderInSection(tableView,section); \
            } \
            return 0; \
        } \

#define TT_heightForHeaderInSection \
        - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section { \
            if (tableView.TTTableSectionMakeArr[section]) { \
                return tableView.TTTableSectionMakeArr[section].heightForHeaderInSection(tableView,section); \
            } \
            return 0; \
        } \

#define TT_viewForFooterInSection \
        -(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section { \
            if (tableView.TTTableSectionMakeArr[section]) { \
                return tableView.TTTableSectionMakeArr[section].viewForFooterInSection(tableView,section); \
            } \
            return nil; \
        } \

#define TT_estimatedHeightForFooterInSection \
        -(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section { \
            if (tableView.TTTableSectionMakeArr[section]) { \
                CGFloat height = tableView.TTTableSectionMakeArr[section].heightForFooterInSection(tableView,section); \
                return height; \
            } \
            return 0; \
        } \

#define TT_heightForFooterInSection \
        - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section \
        { \
            if (tableView.TTTableSectionMakeArr[section]) { \
                return tableView.TTTableSectionMakeArr[section].heightForFooterInSection(tableView,section); \
            } \
            return 0; \
        } \







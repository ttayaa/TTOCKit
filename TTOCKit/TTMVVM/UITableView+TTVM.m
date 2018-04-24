//
//  UITableView+TTVM.m
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/8/30.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "UITableView+TTVM.h"
#import <objc/runtime.h>

#define hScreenWidth [UIScreen mainScreen].bounds.size.width
#define weakify( x )  __weak __typeof__(x) __weak_##x##__ = x;
#define normalize( x ) __typeof__(x) x = __weak_##x##__;

@implementation UITableView (TTVM)

-(TTTableConfigureBlock)configureBlock
{
    return objc_getAssociatedObject(self, @selector(configureBlock));
    
}
-(void)setConfigureBlock:(TTTableConfigureBlock)configureBlock
{
    objc_setAssociatedObject(self, @selector(configureBlock), configureBlock, OBJC_ASSOCIATION_COPY);
}
-(EachSectionBlock)eachSectionBlock
{
    return objc_getAssociatedObject(self, @selector(eachSectionBlock));

}
-(void)setEachSectionBlock:(EachSectionBlock)eachSectionBlock
{
    objc_setAssociatedObject(self, @selector(eachSectionBlock), eachSectionBlock, OBJC_ASSOCIATION_COPY);
}

-(EachSectionItemBlock)eachSectionItemBlock
{
    return objc_getAssociatedObject(self, @selector(eachSectionItemBlock));

}
-(void)setEachSectionItemBlock:(EachSectionItemBlock)eachSectionItemBlock
{
    objc_setAssociatedObject(self, @selector(eachSectionItemBlock), eachSectionItemBlock, OBJC_ASSOCIATION_COPY);
}
-(EachCellBlock)eachCellBlock
{
    return objc_getAssociatedObject(self, @selector(eachCellBlock));
    
}
-(void)setEachCellBlock:(EachCellBlock)eachCellBlock
{
    objc_setAssociatedObject(self, @selector(eachCellBlock), eachCellBlock, OBJC_ASSOCIATION_COPY);
}
-(EachCellHeaderFooterBlock)eachCellHeaderFooterBlock
{
    return objc_getAssociatedObject(self, @selector(eachCellHeaderFooterBlock));
    
}
-(void)setEachCellHeaderFooterBlock:(EachCellHeaderFooterBlock)eachCellHeaderFooterBlock
{
    objc_setAssociatedObject(self, @selector(eachCellHeaderFooterBlock), eachCellHeaderFooterBlock, OBJC_ASSOCIATION_COPY);
}


-(BOOL)CanReloadFlag
{
    return [objc_getAssociatedObject(self, @selector(CanReloadFlag)) boolValue] ;
}
-(void)setCanReloadFlag:(BOOL)CanReloadFlag
{
    objc_setAssociatedObject(self, @selector(CanReloadFlag), @(CanReloadFlag), OBJC_ASSOCIATION_RETAIN);
}


-(TTTableSectionCountBlock)TableSectionCount
{
    return objc_getAssociatedObject(self, @selector(TableSectionCount));
    
}
-(void)setTableSectionCount:(TTTableSectionCountBlock)TableSectionCount
{
    objc_setAssociatedObject(self, @selector(TableSectionCount), TableSectionCount, OBJC_ASSOCIATION_COPY);
}



+(void)load
{
    //================================启动
    Method reloadData = class_getInstanceMethod(self, @selector(reloadData));
    
    Method TTVM_reloadData = class_getInstanceMethod(self, @selector(TTVM_reloadData));
    
    method_exchangeImplementations(reloadData, TTVM_reloadData);
    
}

-(void)TTVM_reloadData
{
    if (self.CanReloadFlag) {
        
        self.configureBlock(self.TableSectionCount);
    }
     [self TTVM_reloadData];
    
    //适配UIScrollView+EmptyDataSet
    if ([self  respondsToSelector:@selector(dzn_reloadEmptyDataSet)]) {
        [self performSelector:@selector(dzn_reloadEmptyDataSet)];

    }
    
}









//高度缓存
-(NSMutableDictionary *)HeightCatchDict
{
    
    NSMutableDictionary *HeightCatchDict = objc_getAssociatedObject(self, @selector(HeightCatchDict));
    if (!HeightCatchDict) {
        HeightCatchDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, @selector(HeightCatchDict), HeightCatchDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return HeightCatchDict;
}


-(void)setHeightCatchDict:(NSMutableDictionary *)HeightCatchDict
{
    objc_setAssociatedObject(self, @selector(HeightCatchDict), HeightCatchDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(void)setTTTableSectionMakeArr:(NSMutableArray<TTTableSectionMake *> *)TTTableSectionMakeArr
{
    objc_setAssociatedObject(self, @selector(TTTableSectionMakeArr), TTTableSectionMakeArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(NSMutableArray<TTTableSectionMake *> *)TTTableSectionMakeArr
{
    return objc_getAssociatedObject(self, @selector(TTTableSectionMakeArr));

}


-(UIViewController *)getCurrentContrller{
    
    UIResponder *next = [self nextResponder];
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}




-(void)TTGroup:(TTTableConfigureBlock)configureBlock eachSection:(EachSectionBlock)sectionBlock eachSectionItemCell:(EachSectionItemBlock)sectionItemBlock eachCellBlock:(EachCellBlock)cellBlock eachCellHeaderFooterBlock:(EachCellHeaderFooterBlock)cellHeaderFooterBlock
{
    

    
    
    self.CanReloadFlag = YES;
  
    self.configureBlock = configureBlock;
    self.eachSectionBlock = sectionBlock;
    self.eachSectionItemBlock = sectionItemBlock;
    self.eachCellBlock = cellBlock;
    self.eachCellHeaderFooterBlock = cellHeaderFooterBlock;
    
    weakify(self)
    self.TableSectionCount = ^(NSInteger groupCount){
      normalize(self)
        if (groupCount>=0) {
            //
            //设置代理
            id vc = [self getCurrentContrller];
            if (!self.dataSource) {
                self.dataSource = vc;
            }
            if (!self.delegate) {
                self.delegate = vc;
            }
            
            
            //创建组 数组
            self.TTTableSectionMakeArr = [NSMutableArray<TTTableSectionMake *> array];
            
            //重置缓存
            self.HeightCatchDict = [NSMutableDictionary dictionary];
            
            
            //创建组数据
            for (int i=0; i <= groupCount-1; i++) {
                @autoreleasepool {
                    //创建组
                    TTTableSectionMake *sectionMake = [TTTableSectionMake new];
                    
                    sectionMake.viewForHeaderInSection = ^UIView *(UITableView *tableView, NSInteger section) {
                        return nil;
                    };
                    sectionMake.heightForHeaderInSection = ^CGFloat(UITableView *tableView, NSInteger section) {
                        return 0;
                    };
                    sectionMake.viewForFooterInSection = ^UIView *(UITableView *tableView, NSInteger section) {
                        return nil;
                    };
                    sectionMake.heightForFooterInSection = ^CGFloat(UITableView *tableView, NSInteger section) {
                        return 0;
                    };
                    
                    
                    self.eachSectionBlock(sectionMake,i);
                    
                    [self.TTTableSectionMakeArr addObject:sectionMake];
                    
                    
                    sectionMake.TTTableItemMakeArr = [NSMutableArray<TTTableItemMake *> array];
                    
                    for (int j=0; j<= (sectionMake ->_rows) - 1; j++) {
                        @autoreleasepool {
                            
                            TTTableItemMake *itemMake = [TTTableItemMake new];
                            itemMake.Cell = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                                
                                return [UITableViewCell new];
                            };
                            itemMake.CellHeight = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
                                return 0;
                            };
                            
                            
                            self.eachSectionItemBlock(itemMake,i,j);
                            
                            [sectionMake.TTTableItemMakeArr addObject:itemMake];
                            
                        }
                    }
                    
                }
                
            }
        }

    };
    
    
    
    
    
}

@end






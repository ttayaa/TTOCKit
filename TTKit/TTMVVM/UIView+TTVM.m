//
//  UIView+TTVM.m
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/8/25.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "UIView+TTVM.h"
#import <objc/runtime.h>

#define hScreenWidth [UIScreen mainScreen].bounds.size.width
#define weakify( x )  __weak __typeof__(x) __weak_##x##__ = x;
#define normalize( x ) __typeof__(x) x = __weak_##x##__;
@implementation UIView (TTVM)




- (void)setTTVMx:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setTTVMy:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)TTVMx
{
    return self.frame.origin.x;
}

- (CGFloat)TTVMy
{
    return self.frame.origin.y;
}



- (CGFloat)TTVMwidth;
{
    return CGRectGetWidth([self frame]);
}



- (void)setTTVM:(CGFloat)width;
{
    CGRect frame = [self frame];
    frame.size.width = width;
    
    [self setFrame:CGRectStandardize(frame)];
}

- (CGFloat)TTVMheight;
{
    return CGRectGetHeight([self frame]);
}

- (void)setTTVMheight:(CGFloat)height;
{
    CGRect frame = [self frame];
    frame.size.height = height;
    [self setFrame:CGRectStandardize(frame)];
}







-(void)reloadTTGroupView
{
    
    if ([self isKindOfClass:[UITableView class]]) {

        UITableView *table = self;
        
        if (table.tableHeaderView.eachGroupViewVerticalItemMakeBlock) {
            table.tableHeaderView.groupViewObserver(table.tableHeaderView.groupViewCountBlock);
        }
        if (table.tableFooterView.eachGroupViewVerticalItemMakeBlock) {
            table.tableFooterView.groupViewObserver(table.tableFooterView.groupViewCountBlock);
        }
        
        if (table.tableHeaderView.eachGroupViewHorizontalItemMakeBlock) {
            table.tableHeaderView.groupViewObserver(table.tableHeaderView.groupViewCountBlock);
        }
        if (table.tableFooterView.eachGroupViewHorizontalItemMakeBlock) {
            table.tableFooterView.groupViewObserver(table.tableFooterView.groupViewCountBlock);
        }
    }
    else
    {
        if (self.eachGroupViewVerticalItemMakeBlock) {
            self.groupViewObserver(self.groupViewCountBlock);
        }
        
        if (self.eachGroupViewHorizontalItemMakeBlock) {
            self.groupViewObserver(self.groupViewCountBlock);
        }
    }
    

    
}



-(TTGroupViewObserver)groupViewObserver
{
    return objc_getAssociatedObject(self, @selector(groupViewObserver));
    
}
-(void)setGroupViewObserver:(TTGroupViewObserver)groupViewObserver
{
    objc_setAssociatedObject(self, @selector(groupViewObserver), groupViewObserver, OBJC_ASSOCIATION_COPY);
}

-(TTGroupViewVerticalItemMakeBlock)eachGroupViewVerticalItemMakeBlock
{
    return objc_getAssociatedObject(self, @selector(eachGroupViewVerticalItemMakeBlock));
    
}
-(void)setEachGroupViewVerticalItemMakeBlock:(TTGroupViewVerticalItemMakeBlock)eachGroupViewVerticalItemMakeBlock
{
    objc_setAssociatedObject(self, @selector(eachGroupViewVerticalItemMakeBlock), eachGroupViewVerticalItemMakeBlock, OBJC_ASSOCIATION_COPY);
}


-(TTGroupViewHorizontalItemMakeBlock)eachGroupViewHorizontalItemMakeBlock
{
    return objc_getAssociatedObject(self, @selector(eachGroupViewHorizontalItemMakeBlock));
    
}
-(void)setEachGroupViewHorizontalItemMakeBlock:(TTGroupViewHorizontalItemMakeBlock)eachGroupViewHorizontalItemMakeBlock
{
    objc_setAssociatedObject(self, @selector(eachGroupViewHorizontalItemMakeBlock), eachGroupViewHorizontalItemMakeBlock, OBJC_ASSOCIATION_COPY);
}



-(TTGroupViewEachViewBlock)eachGroupViewEachViewBlock
{
    return objc_getAssociatedObject(self, @selector(eachGroupViewEachViewBlock));
    
}
-(void)setEachGroupViewEachViewBlock:(TTGroupViewEachViewBlock)eachGroupViewEachViewBlock
{
    objc_setAssociatedObject(self, @selector(eachGroupViewEachViewBlock), eachGroupViewEachViewBlock, OBJC_ASSOCIATION_COPY);
}



-(TTGroupViewCountBlock)groupViewCountBlock
{
    return objc_getAssociatedObject(self, @selector(groupViewCountBlock));
    
}
-(void)setGroupViewCountBlock:(TTGroupViewCountBlock)groupViewCountBlock
{
    objc_setAssociatedObject(self, @selector(groupViewCountBlock), groupViewCountBlock, OBJC_ASSOCIATION_COPY);
}



+(UIView *)TTGroupView_VerticalLayout:(TTGroupViewObserver)groupViewObserver eachItem:(TTGroupViewVerticalItemMakeBlock)eachGroupViewVerticalItemMakeBlock eachView:(TTGroupViewEachViewBlock)eachGroupViewEachViewBlock
{
    UIView *GroupView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, hScreenWidth, 0)];
    [GroupView setAutoresizesSubviews:NO];//父控件尺寸改变不影响子控件
    
    GroupView.groupViewObserver = groupViewObserver;
    GroupView.eachGroupViewVerticalItemMakeBlock = eachGroupViewVerticalItemMakeBlock;
    GroupView.eachGroupViewEachViewBlock = eachGroupViewEachViewBlock;
    
    weakify(GroupView)
    GroupView.groupViewCountBlock= ^(NSInteger groupCount){
        normalize(GroupView)
        if (groupCount>=0) {
            
            //高度清0
            GroupView.TTVMheight = 0;
            //子控件清0
            [GroupView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
                [subview removeFromSuperview];
            }];
            
            //根据最新的数量创建子控件
            for (int i=0; i<= groupCount - 1; i++) {
                
                TTGroupViewVerticalItemMake *itemMake = [TTGroupViewVerticalItemMake new];
                
                GroupView.eachGroupViewVerticalItemMakeBlock(itemMake,i);
                
                itemMake->view.TTVMy = GroupView.TTVMheight;
                
                GroupView.TTVMheight +=  itemMake->view.TTVMheight;
                
                [GroupView addSubview:itemMake->view];
                
                GroupView.eachGroupViewEachViewBlock(itemMake->view,i);
            }
            
        }
    };
    
    
    return GroupView;
}






+(UIView *)TTGroupView_horizontalLayout:(TTGroupViewObserver)groupViewObserver eachItem:(TTGroupViewHorizontalItemMakeBlock)eachGroupViewHorizontalItemMakeBlock eachView:(TTGroupViewEachViewBlock)eachGroupViewEachViewBlock
{
    UIView *GroupView =  [[UIView alloc] initWithFrame:CGRectZero];
    [GroupView setAutoresizesSubviews:NO];//父控件尺寸改变不影响子控件
    
    GroupView.groupViewObserver = groupViewObserver;
    GroupView.eachGroupViewHorizontalItemMakeBlock = eachGroupViewHorizontalItemMakeBlock;
    GroupView.eachGroupViewEachViewBlock = eachGroupViewEachViewBlock;
    
    weakify(GroupView)
    GroupView.groupViewCountBlock= ^(NSInteger groupCount){
        normalize(GroupView)
        if (groupCount>=0) {
            
            
            //尺寸清0
            GroupView.frame = CGRectZero;
            //子控件清0
            [GroupView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
                [subview removeFromSuperview];
            }];
            
            //当前布局行的最大高度
            CGFloat curMaxY = 0.0;
            
            //上一行的最大高度
            CGFloat lastMaxY = 0.0;

            
            //根据最新的数量创建子控件
            for (int i=0; i<= groupCount - 1; i++) {
                
                TTGroupViewHorizontalItemMake *itemMake = [TTGroupViewHorizontalItemMake new];
                
                GroupView.eachGroupViewHorizontalItemMakeBlock(itemMake,i);
                
                
                UIView *lastView = [GroupView.subviews lastObject];
                
                if (lastView) {
                    
                    CGFloat nextViewX = lastView.TTVMx + lastView.TTVMwidth;
                    CGFloat nextViewY = lastView.TTVMy;
                    //如果新控件的尺寸超出屏幕
                    //那么另起一行
                    if ( (nextViewX + itemMake->view.TTVMwidth) > hScreenWidth ) {
                        
                        nextViewX = 0;
                        nextViewY = curMaxY;
                        lastMaxY = curMaxY;
                        curMaxY = nextViewY + itemMake->view.TTVMheight;
                        
                    }
                    else//如果新控件的没有超出屏幕宽度
                    {
                        //判断该控件是否是该行中最高的//如果是就修改curMaxY
                        if ( (curMaxY - lastMaxY) < itemMake->view.TTVMheight) {
                            curMaxY = itemMake->view.TTVMheight + lastMaxY;
                        }
                    }
                    
                    itemMake->view.TTVMx = nextViewX;
                    itemMake->view.TTVMy = nextViewY;
                    
                }
                else//说明是第一个
                {
                    GroupView.frame = itemMake->view.frame;
                    
                    curMaxY = itemMake->view.TTVMheight;
                    lastMaxY = 0;
                }
                
                
                GroupView.TTVMwidth = hScreenWidth;
                GroupView.TTVMheight = curMaxY;
                
                [GroupView addSubview:itemMake->view];
                
                GroupView.eachGroupViewEachViewBlock(itemMake->view,i);
            }
            
            
            
        }
    };
    
    
    return GroupView;
}



@end




//
//  TTTableSectionMake.m
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/8/31.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "TTTableSectionMake.h"
#import "UITableView+TTVM.h"
#import <objc/runtime.h>

#define TTFirstBundleView(nibName) [[[NSBundle bundleForClass:[NSClassFromString(nibName) class]] loadNibNamed:nibName owner:nil options:nil] firstObject]
#define hScreenWidth [UIScreen mainScreen].bounds.size.width
#define weakify( x )  __weak __typeof__(x) __weak_##x##__ = x;
#define normalize( x ) __typeof__(x) x = __weak_##x##__;


@interface NSObject (TTVMEXT)
- (instancetype)initWithIdentifier;
@end
@implementation NSObject (TTVMEXT)

- (instancetype)initWithIdentifier
{
    return self;
}

@end

@implementation TTTableBaseMake

-(CGFloat)culRadioHeightWithtempView:(UIView *)tempView
{
    
    NSHashTable *hash = [[NSHashTable alloc] init];
    __block CGFloat maxHeight = 0;
    [tempView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectGetMaxY(subview.frame)>maxHeight) {
            maxHeight = CGRectGetMaxY(subview.frame);
        }
        
        CGFloat subviewHeight = [subview systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        //说明该子控件没有设置比例
        if (subviewHeight == subview.frame.size.height) {
            
        }
        else//说明已经设置了比例,只有设置了比例的view 才参与比例
        {
            for (int i = subview.frame.origin.y ; i<=subview.frame.size.height + subview.frame.origin.y; i++) {
                [hash addObject:@(i)];
            }
        }
        
    }];
    
    if (tempView.frame.size.height>maxHeight) {
        maxHeight = tempView.frame.size.height;
        
    }
    
    //如果是当前xib宽度等于屏幕直接返回xib的高度
    if (tempView.frame.size.width == hScreenWidth) {
        return maxHeight;
    }
    
    int ignoreHeight = 0;
    for (int i= 0 ; i <= maxHeight; i++) {
        if (![hash containsObject:@(i)]) {
            ignoreHeight++;
        }
    }
    CGRect frame = tempView.frame;
    CGFloat WHscale = frame.size.width/(frame.size.height-ignoreHeight);
    frame.size.width = hScreenWidth;
    frame.size.height =hScreenWidth / WHscale + ignoreHeight;
    tempView.frame = frame;
    tempView.autoresizingMask = UIViewAutoresizingNone;
    
    return CGRectGetHeight([tempView frame]);
    
    
}

-(CGFloat)culAutoLayoutHeightWithtempView:(UIView *)tempView table:(UITableView *)tableView
{
    if ([tempView isKindOfClass:[UITableViewCell class]]) {
        
        UITableViewCell *cell = (UITableViewCell *)tempView;
        
        CGFloat contentViewWidth = CGRectGetWidth(tableView.frame);
        cell.bounds = CGRectMake(0.0f, 0.0f, contentViewWidth, CGRectGetHeight(cell.bounds));
        CGFloat accessroyTypeWidth = 0;
        if (cell.accessoryView) {//if a cell has accessorynview or system accessory type ,its content view's width smaller than origin.we can do this fix this problem.
            accessroyTypeWidth = 16 + CGRectGetWidth(cell.accessoryView.frame);
        } else {
            static const CGFloat systemAccessoryWidths[] = {
                [UITableViewCellAccessoryNone] = 0,
                [UITableViewCellAccessoryDisclosureIndicator] = 34,
                [UITableViewCellAccessoryDetailDisclosureButton] = 68,
                [UITableViewCellAccessoryCheckmark] = 40,
                [UITableViewCellAccessoryDetailButton] = 48
            };
            accessroyTypeWidth = systemAccessoryWidths[cell.accessoryType];
        }
        contentViewWidth -= accessroyTypeWidth;
        
        
        // If not using auto layout, you have to override "-sizeThatFits:" to provide a fitting size by yourself.
        // This is the same height calculation passes used in iOS8 self-sizing cell's implementation.
        //
        // 1. Try "- systemLayoutSizeFittingSize:" first. (skip this step if 'fd_enforceFrameLayout' set to YES.)
        // 2. Warning once if step 1 still returns 0 when using AutoLayout
        // 3. Try "- sizeThatFits:" if step 1 returns 0
        // 4. Use a valid height or default row height (44) if not exist one
        CGFloat fittingHeight = 0;
        
        
        // Add a hard width constraint to make dynamic content views (like labels) expand vertically instead
        // of growing horizontally, in a flow-layout manner.
        NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
        
        //        // [bug fix] after iOS 10.3, Auto Layout engine will add an additional 0 width constraint onto cell's content view, to avoid that, we add constraints to content view's left, right, top and bottom.
        //        static BOOL isSystemVersionEqualOrGreaterThen10_2 = NO;
        //        static dispatch_once_t onceToken;
        //        dispatch_once(&onceToken, ^{
        //            isSystemVersionEqualOrGreaterThen10_2 = [UIDevice.currentDevice.systemVersion compare:@"10.2" options:NSNumericSearch] != NSOrderedAscending;
        //        });
        
        NSArray<NSLayoutConstraint *> *edgeConstraints;
        //        if (isSystemVersionEqualOrGreaterThen10_2) {
        // To avoid confilicts, make width constraint softer than required (1000)
        widthFenceConstraint.priority = UILayoutPriorityRequired - 1;
        
        // Build edge constraints
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeRight multiplier:1.0 constant:accessroyTypeWidth];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        edgeConstraints = @[leftConstraint, rightConstraint, topConstraint, bottomConstraint];
        [cell addConstraints:edgeConstraints];
        
        
        [cell.contentView addConstraint:widthFenceConstraint];
        
        //            fittingHeight = 44.;
        // Auto layout engine does its math
        
        fittingHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        // Clean-ups
        [cell.contentView removeConstraint:widthFenceConstraint];
        //            if (isSystemVersionEqualOrGreaterThen10_2) {
        [cell removeConstraints:edgeConstraints];
        //            }
        //        }
        
        if (fittingHeight == 0) {
#if DEBUG
            // Warn if using AutoLayout but get zero height.
            if (cell.contentView.constraints.count > 0) {
                if (!objc_getAssociatedObject(self, _cmd)) {
                    NSLog(@"[TTMVVM] Warning once only: Cannot get a proper cell height (now 0) from '- systemFittingSize:'(AutoLayout). You should check how constraints are built in cell, making it into 'self-sizing' cell.");
                    objc_setAssociatedObject(self, _cmd, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                }
            }
#endif
            // Try '- sizeThatFits:' for frame layout.
            // Note: fitting height should not include separator view.
            fittingHeight = [cell sizeThatFits:CGSizeMake(contentViewWidth, 0)].height;
        }
        
        // Still zero height after all above.
        if (fittingHeight == 0) {
            // Use default row height.
            fittingHeight = 44;
        }
        
        // Add 1px extra space for separator line if needed, simulating default UITableViewCell.
        if (tableView.separatorStyle != UITableViewCellSeparatorStyleNone) {
            fittingHeight += 1.0 / [UIScreen mainScreen].scale;
        }
        return fittingHeight;
        
    }
    
    
    
    
    
    
    
    
    BOOL autolayoutFlag = tempView.translatesAutoresizingMaskIntoConstraints;
    
    tempView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:tempView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:hScreenWidth];
    [tempView addConstraint:widthFenceConstraint];
    
    CGFloat fittingHeight = [tempView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    [tempView removeConstraint:widthFenceConstraint];
    
    //分割线处理
    if (tableView.separatorStyle != UITableViewCellSeparatorStyleNone) {
        fittingHeight += 1.0 / [UIScreen mainScreen].scale;
    }
    
    tempView.translatesAutoresizingMaskIntoConstraints = autolayoutFlag;
    
    
    return fittingHeight;
}


@end



@implementation TTTableSectionMake




- (TTTableSectionMake *(^)(NSInteger))rows
{
    weakify(self)
    return ^TTTableSectionMake *(NSInteger rows) {
        normalize(self)
        
        _rows = rows;
        
        return self;
    };
}





//自定义高度
- (TTTableSectionMake *(^)(CGFloat))HeaderCustomHeight
{
    weakify(self)
    return ^TTTableSectionMake *(CGFloat height) {
        normalize(self)
        
        _headerCustomHeight =[NSString stringWithFormat:@"%f",height];
        
        self.heightForHeaderInSection = ^CGFloat(UITableView *tableView, NSInteger section) {
            normalize(self)
            tableView.eachSectionBlock(self, section);
            return [_headerCustomHeight floatValue];
        };
        
        return self;
    };
}
//当 ....才显示头部
- (TTTableSectionMake *(^)(id))HeaderShowIf
{
    weakify(self)
    return ^TTTableSectionMake *(id showif) {
        normalize(self)
        
        //        if (!showif) {
        //            _headerCustomHeight = @"0";
        //        }
        //
        
        
        if (showif) {
            if ([showif boolValue] || [showif integerValue] || [showif floatValue]) {
                
            }
            else
            {
                self.viewForHeaderInSection = ^UIView *(UITableView *tableView, NSInteger section) {
                    return [UIView new];
                };
                self.heightForHeaderInSection = ^CGFloat(UITableView *tableView, NSInteger section) {
                    return 0;
                };
                
                
            }
        }
        else{
            
            self.viewForHeaderInSection = ^UIView *(UITableView *tableView, NSInteger section) {
                return [UIView new];
            };
            self.heightForHeaderInSection = ^CGFloat(UITableView *tableView, NSInteger section) {
                return 0;
            };
        }
        
        
        
        
        return self;
    };
}
- (TTTableSectionMake *(^)(NSString *,SEL,id))HeaderRadioXib
{
    weakify(self)
    return ^TTTableSectionMake *(NSString *name,SEL sel,id data) {
        normalize(self)
        
        self.viewForHeaderInSection = ^UIView *(UITableView *tableView, NSInteger section) {
            
            UITableViewHeaderFooterView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:name];
            
            if (!view) {
                view = TTFirstBundleView(name);
            }
            
            if ([view respondsToSelector:sel]) {
                [view performSelector:sel withObject:data];
            }
            
            tableView.eachCellHeaderFooterBlock(view,nil,section);
            
            return view;
            
        };
        weakify(self)
        self.heightForHeaderInSection = ^CGFloat(UITableView *tableView, NSInteger section) {
            normalize(self)
            
            
            //根据数据进行缓存
            NSObject *dataObj = data;
            
            //如果缓存中有高
            if(tableView.HeightCatchDict[@(dataObj.hash)])
            {
                return [tableView.HeightCatchDict[@(dataObj.hash)] floatValue];
            }
            else//使用一个临时的View计算高度并缓存
            {
                
                UITableViewHeaderFooterView * tempview = TTFirstBundleView(name);
                CGFloat height;
                
                
                if ([tempview isKindOfClass:[UITableViewHeaderFooterView class]]) {
                    if (tempview.contentView.subviews.count>0) {
                        height = [self culRadioHeightWithtempView:tempview.contentView];
                    }
                    else
                    {
                        height = [self culRadioHeightWithtempView:tempview];
                    }
                }
                else
                {
                    height = [self culRadioHeightWithtempView:tempview];
                }
                
                [tableView.HeightCatchDict addEntriesFromDictionary:@{
                                                                      name:@(height)
                                                                      }];
                
                
                return height;
            }
            
        };
        
        
        return self;
    };
}
- (TTTableSectionMake *(^)(NSString *,SEL,id))HeaderAutoLayoutXib
{
    weakify(self)
    return ^TTTableSectionMake *(NSString *name,SEL sel,id data) {
        normalize(self)
        
        self.viewForHeaderInSection = ^UIView *(UITableView *tableView, NSInteger section) {
            
            UITableViewHeaderFooterView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:name];
            
            if (!view) {
                view = TTFirstBundleView(name);
            }
            
            if ([view respondsToSelector:sel]) {
                [view performSelector:sel withObject:data];
            }
            
            tableView.eachCellHeaderFooterBlock(view,nil,section);
            
            return view;
            
        };
        weakify(self)
        self.heightForHeaderInSection = ^CGFloat(UITableView *tableView, NSInteger section) {
            normalize(self)
            
            
            //如果缓存中有高
            if(tableView.HeightCatchDict[@(section+11111)])
            {
                return [tableView.HeightCatchDict[@(section+11111)] floatValue];
            }
            else//使用一个临时的View计算高度并缓存
            {
                
                UITableViewHeaderFooterView *view = TTFirstBundleView(name);
                
                //传入数据来计算
                if ([view respondsToSelector:sel]) {
                    [view performSelector:sel withObject:data];
                }
                

                CGFloat height = [self culAutoLayoutHeightWithtempView:view table:tableView];

                
                [tableView.HeightCatchDict addEntriesFromDictionary:@{
                                                                      @(section+11111):@(height)
                                                                      }];
                
                return height;
                
            }
        };
        
        
        return self;
    };
    
}
- (TTTableSectionMake *(^)(NSString *,SEL,id))HeaderAutoLayoutCls
{
    weakify(self)
    return ^TTTableSectionMake *(NSString *name,SEL sel,id data) {
        normalize(self)
        
        self.viewForHeaderInSection = ^UIView *(UITableView *tableView, NSInteger section) {
            
            UITableViewHeaderFooterView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:name];
            
            if (!view) {
                view = [NSClassFromString(name) new];
            }
            
            if ([view respondsToSelector:sel]) {
                [view performSelector:sel withObject:data];
            }
            
            tableView.eachCellHeaderFooterBlock(view,nil,section);
            
            return view;
            
        };
        self.heightForHeaderInSection = ^CGFloat(UITableView *tableView, NSInteger section) {
            normalize(self)
            
            
            //根据数据进行缓存
            NSObject *dataObj = data;
            //如果缓存中有高
            if(tableView.HeightCatchDict[@(dataObj.hash)])
            {
                return [tableView.HeightCatchDict[@(dataObj.hash)] floatValue];
            }
            else//使用一个临时的View计算高度并缓存
            {
                normalize(self)
                
                //如果用户自定义高
                if (_headerCustomHeight) {
                    return [_headerCustomHeight floatValue];
                }
                
                
                //如果缓存中有高
                if(tableView.HeightCatchDict[@(section+11111)])
                {
                    return [tableView.HeightCatchDict[@(section+11111)] floatValue];
                }
                else//使用一个临时的View计算高度并缓存
                {
                    
                    UITableViewHeaderFooterView *view = [NSClassFromString(name) new];
                    
                    //传入数据来计算
                    if ([view respondsToSelector:sel]) {
                        [view performSelector:sel withObject:data];
                    }
                    
                    CGFloat height = [self culAutoLayoutHeightWithtempView:view table:tableView];
                    
                    [tableView.HeightCatchDict addEntriesFromDictionary:@{
                                                                          @(section+11111):@(height)
                                                                          }];
                    
                    return height;
                    
                }
                
            }
        };
        
        
        return self;
        
    };
    
}





//自定义高度
- (TTTableSectionMake *(^)(CGFloat))FooterCustomHeight
{
    weakify(self)
    return ^TTTableSectionMake *(CGFloat height) {
        normalize(self)
        
        _footerCustomHeight =[NSString stringWithFormat:@"%f",height];
        
        self.heightForFooterInSection = ^CGFloat(UITableView *tableView, NSInteger section) {
            normalize(self)
            tableView.eachSectionBlock(self, section);
            return [_footerCustomHeight floatValue];
        };
        
        return self;
    };
}
//当 ....才显示
- (TTTableSectionMake *(^)(id))FooterShowIf
{
    weakify(self)
    return ^TTTableSectionMake *(id showif) {
        normalize(self)
        
        if (showif) {
            if ([showif boolValue] || [showif integerValue] || [showif floatValue]) {
                
            }
            else
            {
                self.viewForFooterInSection = ^UIView *(UITableView *tableView, NSInteger section) {
                    return [UIView new];
                };
                self.heightForFooterInSection = ^CGFloat(UITableView *tableView, NSInteger section) {
                    return 0;
                };
                
                
            }
        }
        else{
            
            self.viewForFooterInSection = ^UIView *(UITableView *tableView, NSInteger section) {
                return [UIView new];
            };
            self.heightForFooterInSection = ^CGFloat(UITableView *tableView, NSInteger section) {
                return 0;
            };
        }
        
        
        return self;
    };
}
- (TTTableSectionMake *(^)(NSString *,SEL,id))FooterRadioXib
{
    weakify(self)
    return ^TTTableSectionMake *(NSString *name,SEL sel,id data) {
        normalize(self)
        
        self.viewForFooterInSection = ^UIView *(UITableView *tableView, NSInteger section) {
            
            UITableViewHeaderFooterView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:name];
            
            if (!view) {
                view = TTFirstBundleView(name);
            }
            
            if ([view respondsToSelector:sel]) {
                [view performSelector:sel withObject:data];
            }
            
            tableView.eachCellHeaderFooterBlock(nil,view,section);
            
            return view;
            
        };
        self.heightForFooterInSection = ^CGFloat(UITableView *tableView, NSInteger section) {
            normalize(self)
            
            
            //如果缓存中有高
            if(tableView.HeightCatchDict[name])
            {
                return [tableView.HeightCatchDict[name] floatValue];
            }
            else//使用一个临时的View计算高度并缓存
            {
                UITableViewHeaderFooterView * tempview = TTFirstBundleView(name);
                CGFloat height;
                
                if ([tempview isKindOfClass:[UITableViewHeaderFooterView class]]) {
                    if (tempview.contentView.subviews.count>0) {
                        height = [self culRadioHeightWithtempView:tempview.contentView];
                    }
                    else
                    {
                        height = [self culRadioHeightWithtempView:tempview];
                    }
                }
                else
                {
                    height = [self culRadioHeightWithtempView:tempview];
                }
                
                [tableView.HeightCatchDict addEntriesFromDictionary:@{
                                                                      name:@(height)
                                                                      }];
                //                CGFloat height = [self culRadioHeightWithtempView:TTFirstBundleView(name)];
                //
                //                [tableView.HeightCatchDict addEntriesFromDictionary:@{
                //                                                                      name:@(height)
                //                                                                      }];
                //
                
                return height;
            }
            
        };
        
        
        return self;
    };
}
- (TTTableSectionMake *(^)(NSString *,SEL,id))FooterAutoLayoutXib
{
    weakify(self)
    return ^TTTableSectionMake *(NSString *name,SEL sel,id data) {
        normalize(self)
        
        self.viewForFooterInSection = ^UIView *(UITableView *tableView, NSInteger section) {
            
            UITableViewHeaderFooterView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:name];
            
            if (!view) {
                view = TTFirstBundleView(name);
            }
            
            if ([view respondsToSelector:sel]) {
                [view performSelector:sel withObject:data];
            }
            
            tableView.eachCellHeaderFooterBlock(nil,view,section);
            
            return view;
            
        };
        self.heightForFooterInSection = ^CGFloat(UITableView *tableView, NSInteger section) {
            normalize(self)
            
            
            //如果缓存中有高
            if(tableView.HeightCatchDict[@(section+9999)])
            {
                return [tableView.HeightCatchDict[@(section+9999)] floatValue];
            }
            else//使用一个临时的View计算高度并缓存
            {
                
                UITableViewHeaderFooterView *view = TTFirstBundleView(name);
                
                //传入数据来计算
                if ([view respondsToSelector:sel]) {
                    [view performSelector:sel withObject:data];
                }
                
                CGFloat height = [self culAutoLayoutHeightWithtempView:view table:tableView];
                
                [tableView.HeightCatchDict addEntriesFromDictionary:@{
                                                                      @(section+9999):@(height)
                                                                      }];
                
                return height;
                
            }
            
        };
        
        
        return self;
    };
}
- (TTTableSectionMake *(^)(NSString *,SEL,id))FooterAutoLayoutCls
{
    weakify(self)
    return ^TTTableSectionMake *(NSString *name,SEL sel,id data) {
        normalize(self)
        
        self.viewForFooterInSection = ^UIView *(UITableView *tableView, NSInteger section) {
            
            UITableViewHeaderFooterView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:name];
            
            if (!view) {
                view = [NSClassFromString(name) new];
            }
            
            if ([view respondsToSelector:sel]) {
                [view performSelector:sel withObject:data];
            }
            
            tableView.eachCellHeaderFooterBlock(nil,view,section);
            
            return view;
            
        };
        self.heightForFooterInSection = ^CGFloat(UITableView *tableView, NSInteger section) {
            normalize(self)
            
            //如果缓存中有高
            if(tableView.HeightCatchDict[@(section+9999)])
            {
                return [tableView.HeightCatchDict[@(section+9999)] floatValue];
            }
            else//使用一个临时的View计算高度并缓存
            {
                
                UITableViewHeaderFooterView *view = [NSClassFromString(name) new];
                
                //传入数据来计算
                if ([view respondsToSelector:sel]) {
                    [view performSelector:sel withObject:data];
                }
                
                CGFloat height = [self culAutoLayoutHeightWithtempView:view table:tableView];
                
                [tableView.HeightCatchDict addEntriesFromDictionary:@{
                                                                      @(section+9999):@(height)
                                                                      }];
                
                return height;
                
            }
        };
        
        
        return self;
    };
}

@end






@implementation TTTableItemMake

- (TTTableItemMake *(^)(CGFloat))CellCustomHeight
{
    
    weakify(self)
    return ^TTTableItemMake *(CGFloat height) {
        normalize(self)
        
        _cellCustomHeight =[NSString stringWithFormat:@"%f",height];
        
        self.CellHeight = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            normalize(self)
            //获取最新的高度
            tableView.eachSectionItemBlock(self,indexPath.section,indexPath.row);
            
            return [_cellCustomHeight floatValue];
        };
        
        
        return self;
    };
}

//当 ....才显示
- (TTTableItemMake *(^)(id))CellshowIf
{
    weakify(self)
    return ^TTTableItemMake *(id showif) {
        normalize(self)
        
        if (showif) {
            if ([showif boolValue] || [showif integerValue] || [showif floatValue]) {
                
            }
            else
            {
                self.Cell = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                    return [UITableViewCell new];
                };
                self.CellHeight = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
                    return 0;
                };
                
            }
        }
        else{
            
            self.Cell = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                return [UITableViewCell new];
            };
            self.CellHeight = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
                return 0;
            };
        }
        
        return self;
    };
}


//根据xib中的比例布局
- (TTTableItemMake *(^)(NSString *,SEL,id))CellRadioXib
{
    weakify(self)
    return ^TTTableItemMake *(NSString *name,SEL sel,id data) {
        normalize(self)
        
        
        self.Cell = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath)
        {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
            
            if (!cell) {
                
                [tableView registerNib:[UINib nibWithNibName:name bundle:nil] forCellReuseIdentifier:name];
                
                cell = TTFirstBundleView(name);
                
                
            }
            
            if ([cell respondsToSelector:sel]) {
                [cell performSelector:sel withObject:data];
            }
            
            
            tableView.eachCellBlock(cell,indexPath.section,indexPath.row);
            
            return cell;
            
        };
        
        self.CellHeight = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            
            normalize(self)
            
            //如果缓存中有高(radio是根据name做缓存)
            if(tableView.HeightCatchDict[name])
            {
                return [tableView.HeightCatchDict[name] floatValue];
            }
            else//使用一个临时的View计算高度并缓存
            {
                UITableViewCell *cell = TTFirstBundleView(name);
                CGFloat height = [self culRadioHeightWithtempView:cell.contentView];
                
                
                
                [tableView.HeightCatchDict addEntriesFromDictionary:@{
                                                                      name:@(height)
                                                                      }];
                return height;
            }
            
        };
        
        return self;
    };
}
//当 ....才显示
//根据xib中的自动布局
- (TTTableItemMake *(^)(NSString *,SEL,id))CellAutoLayoutXib
{
    weakify(self)
    return ^TTTableItemMake *(NSString *name,SEL sel,id data) {
        normalize(self)
        
        
        self.Cell = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath)
        {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
            
            if (!cell) {
                
                [tableView registerNib:[UINib nibWithNibName:name bundle:nil] forCellReuseIdentifier:name];
                
                cell = TTFirstBundleView(name);
            }
            
            if ([cell respondsToSelector:sel]) {
                [cell performSelector:sel withObject:data];
            }
            
            tableView.eachCellBlock(cell,indexPath.section,indexPath.row);
            
            return cell;
            
        };
        
        self.CellHeight = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            
            normalize(self)
            
            //            //如果缓存中有高
            //            if(tableView.HeightCatchDict[@(indexPath.hash+0.111)])
            //            {
            //                return [tableView.HeightCatchDict[@(indexPath.hash+0.111)] floatValue];
            //            }
            //            else//从缓存池拿一个cell来计算高度
            //            {
            
            //                 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
            //                if (!cell) {
            //
            //                    [tableView registerNib:[UINib nibWithNibName:name bundle:nil] forCellReuseIdentifier:name];
            //
            //                    cell = TTFirstBundleView(name);
            //                }
            //注意这里不能从缓存池拿cell,因为会影响显示的cell的结果,比如在cell中改变控制器的状态,如果拿缓存池的就会有问题
            UITableViewCell *cell = TTFirstBundleView(name);
            
            if ([cell respondsToSelector:sel]) {
                [cell performSelector:sel withObject:data];
            }
            
            CGFloat height = [self culAutoLayoutHeightWithtempView:cell table:tableView];
            
            
            //                NSDictionary *dict = @{@(indexPath.hash+0.111):@(height)};
            //
            //                if (@(height) != nil)
            //                {
            //                    [tableView.HeightCatchDict addEntriesFromDictionary:dict];
            //                }
            //
            
            return height;
            //            }
            
        };
        
        return self;
    };
}
//根据 非xib类 中的自动布局
- (TTTableItemMake *(^)(NSString *,SEL,id))CellAutoLayoutCls
{
    weakify(self)
    return ^TTTableItemMake *(NSString *name,SEL sel,id data) {
        normalize(self)
        
        
        
        self.Cell = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath)
        {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
            
            if (!cell) {
                
                
                [tableView registerClass:NSClassFromString(name) forCellReuseIdentifier:name];
                
                //                cell = [[NSClassFromString(name) alloc] initWithIdentifier:name];
                cell = [[NSClassFromString(name) alloc] init];
                
            }
            
            if ([cell respondsToSelector:sel]) {
                [cell performSelector:sel withObject:data];
            }
            
            tableView.eachCellBlock(cell,indexPath.section,indexPath.row);
            
            return cell;
            
        };
        
        self.CellHeight = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            
            normalize(self)
            
            //如果缓存中有高
            if(tableView.HeightCatchDict[indexPath])
            {
                return [tableView.HeightCatchDict[indexPath] floatValue];
            }
            else//使用一个临时的View计算高度并缓存
            {
                UITableViewCell *cell = [[NSClassFromString(name) alloc] init];
                
                
                if ([cell respondsToSelector:sel]) {
                    [cell performSelector:sel withObject:data];
                }
                //
                CGFloat height = [self culAutoLayoutHeightWithtempView:cell table:tableView];
                //
                //
                //                [tableView.HeightCatchDict addEntriesFromDictionary:@{
                //                                                                      indexPath:@(height)
                //                                                                      }];
                return height;
            }
            
        };
        
        return self;
    };
}



@end





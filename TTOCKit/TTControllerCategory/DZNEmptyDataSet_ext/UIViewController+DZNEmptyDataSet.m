//
//  UIViewController+DZNEmptyDataSet.m
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 RecruitTreasure. All rights reserved.
//

#import "UIViewController+DZNEmptyDataSet.h"
#import <objc/runtime.h>

@interface UIViewController (DZNEmptyDataSetEXT)
@property(nonatomic,copy)  DZNEmptyDataSet_viewClickBlock TTimgViewClickBlock;


@end
@implementation UIViewController (DZNEmptyDataSetEXT)

@dynamic TTimgViewClickBlock;
- (DZNEmptyDataSet_viewClickBlock)TTimgViewClickBlock
{
    return objc_getAssociatedObject(self, @selector(TTimgViewClickBlock));
}

- (void)setTTimgViewClickBlock:(DZNEmptyDataSet_viewClickBlock)TTimgViewClickBlock
{
    objc_setAssociatedObject(self, @selector(TTimgViewClickBlock), TTimgViewClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
@implementation UIViewController (DZNEmptyDataSet)

@dynamic TTisShowEmpty;
-(BOOL)TTisShowEmpty
{
    return [objc_getAssociatedObject(self, @selector(TTisShowEmpty)) boolValue] ;
}


@dynamic TTVerticalOffset;
-(CGFloat)TTVerticalOffset
{
    return [objc_getAssociatedObject(self, @selector(TTVerticalOffset)) floatValue] ;
}
-(void)setTTVerticalOffset:(CGFloat)TTVerticalOffset
{
    objc_setAssociatedObject(self, @selector(TTVerticalOffset), @(TTVerticalOffset), OBJC_ASSOCIATION_RETAIN);
}
@dynamic TTSpaceHeight;
-(CGFloat)TTSpaceHeight
{
    return [objc_getAssociatedObject(self, @selector(TTSpaceHeight)) floatValue] ;
}
-(void)setTTSpaceHeight:(CGFloat)TTSpaceHeight
{
    objc_setAssociatedObject(self, @selector(TTSpaceHeight), @(TTSpaceHeight), OBJC_ASSOCIATION_RETAIN);
}









@dynamic TTtitleForEmpty;
-(NSString *)TTtitleForEmpty
{
    
    NSString *TTtitleForEmpty = objc_getAssociatedObject(self, @selector(TTtitleForEmpty));
    if (!TTtitleForEmpty) {
        TTtitleForEmpty = @"咋没数据呢,刷新试试~~";;
        objc_setAssociatedObject(self, @selector(TTtitleForEmpty), TTtitleForEmpty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return TTtitleForEmpty;
}


- (void)setTTtitleForEmpty:(NSString *)TTtitleForEmpty
{
    objc_setAssociatedObject(self, @selector(TTtitleForEmpty), TTtitleForEmpty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@dynamic TTtitleForEmptyAttributes;
-(NSDictionary *)TTtitleForEmptyAttributes
{
    
    NSDictionary *TTtitleForEmptyAttributes = objc_getAssociatedObject(self, @selector(TTtitleForEmptyAttributes));
    if (!TTtitleForEmptyAttributes) {
        TTtitleForEmptyAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                      NSForegroundColorAttributeName: [UIColor darkGrayColor]};
   
        objc_setAssociatedObject(self, @selector(TTtitleForEmptyAttributes), TTtitleForEmptyAttributes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return TTtitleForEmptyAttributes;
}


- (void)setTTtitleForEmptyAttributes:(NSDictionary *)TTtitleForEmptyAttributes
{
    objc_setAssociatedObject(self, @selector(TTtitleForEmptyAttributes), TTtitleForEmptyAttributes, OBJC_ASSOCIATION_COPY_NONATOMIC);
}








@dynamic TTdescriptionForEmpty;

-(NSString *)TTdescriptionForEmpty
{
    
    NSString *TTdescriptionForEmpty = objc_getAssociatedObject(self, @selector(TTdescriptionForEmpty));
    if (!TTdescriptionForEmpty) {
        TTdescriptionForEmpty = @"😂客官对不起,没有找到你想要的数据";
        objc_setAssociatedObject(self, @selector(TTdescriptionForEmpty), TTdescriptionForEmpty, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return TTdescriptionForEmpty;
}

- (void)setTTdescriptionForEmpty:(NSString *)TTdescriptionForEmpty
{
    objc_setAssociatedObject(self, @selector(TTdescriptionForEmpty), TTdescriptionForEmpty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@dynamic TTdescriptionForEmptyAttributes;
-(NSDictionary *)TTdescriptionForEmptyAttributes
{
    
    NSDictionary *TTdescriptionForEmptyAttributes = objc_getAssociatedObject(self, @selector(TTdescriptionForEmptyAttributes));
    if (!TTdescriptionForEmptyAttributes) {
        
        NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
        paragraph.lineBreakMode            = NSLineBreakByWordWrapping;
        paragraph.alignment                = NSTextAlignmentCenter;
        TTdescriptionForEmptyAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],                                            NSForegroundColorAttributeName: [UIColor lightGrayColor],NSParagraphStyleAttributeName: paragraph};
        
        objc_setAssociatedObject(self, @selector(TTdescriptionForEmptyAttributes), TTdescriptionForEmptyAttributes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return TTdescriptionForEmptyAttributes;
}


- (void)setTTdescriptionForEmptyAttributes:(NSDictionary *)TTdescriptionForEmptyAttributes
{
    objc_setAssociatedObject(self, @selector(TTdescriptionForEmptyAttributes), TTdescriptionForEmptyAttributes, OBJC_ASSOCIATION_COPY_NONATOMIC);
}









@dynamic TTimageNameForEmpty;

-(NSString *)TTimageNameForEmpty
{
    
    NSString *TTimageNameForEmpty = objc_getAssociatedObject(self, @selector(TTimageNameForEmpty));
    if (!TTimageNameForEmpty) {
        TTimageNameForEmpty = @"placeholder_dropbox";
        objc_setAssociatedObject(self, @selector(TTimageNameForEmpty), TTimageNameForEmpty, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return TTimageNameForEmpty;
}
- (void)setTTimageNameForEmpty:(NSString *)TTimageNameForEmpty
{
    objc_setAssociatedObject(self, @selector(TTimageNameForEmpty), TTimageNameForEmpty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@dynamic TTBackgroundColorForEmpty;
-(UIColor *)TTBackgroundColorForEmpty
{
    
    UIColor *TTBackgroundColorForEmpty = objc_getAssociatedObject(self, @selector(TTBackgroundColorForEmpty));
    if (!TTBackgroundColorForEmpty) {
        TTBackgroundColorForEmpty = [UIColor clearColor];
        objc_setAssociatedObject(self, @selector(TTBackgroundColorForEmpty), TTBackgroundColorForEmpty, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return TTBackgroundColorForEmpty;
}

- (void)setTTBackgroundColorForEmpty:(UIColor *)TTBackgroundColorForEmpty
{
    objc_setAssociatedObject(self, @selector(TTBackgroundColorForEmpty), TTBackgroundColorForEmpty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


-(void)setTTisShowEmpty:(BOOL)TTisShowEmpty
{
    
    objc_setAssociatedObject(self, @selector(TTisShowEmpty), @(TTisShowEmpty), OBJC_ASSOCIATION_RETAIN);
    
    if (TTisShowEmpty) {
        
        if ([self respondsToSelector:@selector(setTableView:)]) {
            
            UITableView *table = [self performSelector:@selector(tableView)];
            
            table.emptyDataSetDelegate=self;
            table.emptyDataSetSource=self;
            table.tableFooterView = [UIView new];
        }
        
        
        if ([self respondsToSelector:@selector(setCollectionView:)]) {
            
            UICollectionView *collect = [self performSelector:@selector(collectionView)];
            collect.emptyDataSetDelegate=self;
            collect.emptyDataSetSource=self;
        }
        
    }
    
}

#pragma mark - DZNEmptyDataSetSource Methods
/**
 *返回标题文字
 */
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text           = self.TTtitleForEmpty;
    
    return [[NSAttributedString alloc] initWithString:text attributes:self.TTtitleForEmptyAttributes];
}

/**
 *返回详情文字
 */
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text                     = self.TTdescriptionForEmpty;
    
    return [[NSAttributedString alloc] initWithString:text attributes:self.TTdescriptionForEmptyAttributes];
}


- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (!self.TTimageNameForEmpty ||[self isBlank:self.TTimageNameForEmpty]) {
        return nil;
    }
    return [UIImage imageNamed:self.TTimageNameForEmpty];
}

//自定义背景颜色
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.TTBackgroundColorForEmpty;
}

//设置垂直方向的偏移值
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    
    
    UIScrollView *view = (UIScrollView *)self.view;
    
    if (![view isKindOfClass:[UIScrollView class]]) {
        return self.TTVerticalOffset;
    }
    
    if (@available(iOS 11.0, *)) {
        return fabs(view.contentOffset.y) +self.TTVerticalOffset;
    } else {
        return -fabs(view.contentOffset.y)+self.TTVerticalOffset;
    }
    
//    return self.TTVerticalOffset;
}

//设置垂直间距
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.TTSpaceHeight;
}
#pragma mark - DZNEmptyDataSetDelegate Methods

/**
 *数据源为空的时候是否渲染和显示(默认YES)
 */
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    
    return YES;
}

/**
 *是否允许点击 (默认YES)
 */
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

/**
 *是否允许滚动 (默认NO)
 */
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

/**
 *图片区点击事件
 */
-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (!self.TTimgViewClickBlock) {
        if(self.navigationController.viewControllers.count>1)
        {
            [self.view endEditing:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else
    {
        self.TTimgViewClickBlock(view);
    }
    
}


-(void)imgClick:(DZNEmptyDataSet_viewClickBlock)block
{
    self.TTimgViewClickBlock = block;
}


- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue         = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue           = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration          = 0.25;
    animation.cumulative        = YES;
    animation.repeatCount       = MAXFLOAT;
    
    return animation;
}


- (BOOL)isBlank:(NSString *)str{
    if (self == nil || self == NULL || [self isKindOfClass:[NSNull class]] || [str length] == 0 || [str isEqualToString: @"(null)"]) {
        return YES;
    }
    return NO;
}


@end

//
//  UIViewController+DZNEmptyDataSet.m
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 RecruitTreasure. All rights reserved.
//

#import "UIViewController+DZNEmptyDataSet.h"


@implementation UIViewController (DZNEmptyDataSet)

@dynamic dy_isShowEmpty;
@dynamic dy_titleForEmpty;
@dynamic dy_descriptionForEmpty;
@dynamic dy_imageNameForEmpty;


ControllerCategoryOverride(DZNEmptyDataSet)



viewDidLoad(DZNEmptyDataSet)
{
//    self.dy_titleForEmpty                  = @"咋没数据呢,刷新试试~~";
//    self.dy_descriptionForEmpty            = @"😂客官对不起,没有找到你想要的数据";
    self.dy_titleForEmpty                  = @"";
    self.dy_descriptionForEmpty            = @"";
    
    self.dy_imageNameForEmpty              = @"placeholder_dropbox";
//    self.dy_firstShowEmpty                 = YES;
    self.dy_isShowEmpty                    = NO;
}

-(void)setDy_isShowEmpty:(BOOL)dy_isShowEmpty
{
    
    
    
    if (dy_isShowEmpty) {
        
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
    NSString *text           = self.dy_titleForEmpty;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

/**
 *返回详情文字
 */
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text                     = self.dy_descriptionForEmpty;
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode            = NSLineBreakByWordWrapping;
    paragraph.alignment                = NSTextAlignmentCenter;
    
    NSDictionary *attributes           = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                           NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                           NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (!self.dy_imageNameForEmpty ||[self isBlank:self.dy_imageNameForEmpty]) {
        return nil;
    }
    return [UIImage imageNamed:self.dy_imageNameForEmpty];
}

//自定义背景颜色
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

//设置垂直方向的偏移值
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    //    return -20.0f;
    
    return 64.0f;
}

//设置垂直间距
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0.0f;
}
#pragma mark - DZNEmptyDataSetDelegate Methods

/**
 *数据源为空的时候是否渲染和显示(默认YES)
 */
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
//    if (self.dy_firstShowEmpty) {
//        self.dy_firstShowEmpty = NO;
//        
//        return NO;
//    }
//    
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
    
    if(self.navigationController.viewControllers.count>1)
    {
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
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

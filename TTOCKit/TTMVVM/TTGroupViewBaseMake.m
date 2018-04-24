//
//  TTGroupViewVerticalItemMake.m
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/9/2.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "TTGroupViewBaseMake.h"
#define weakify( x )  __weak __typeof__(x) __weak_##x##__ = x;
#define normalize( x ) __typeof__(x) x = __weak_##x##__;
#define hScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation TTGroupViewBaseMake

//固定宽度 求高度
-(void)settingRadioHeightWithView:(UIView *)culView fixWitdh:(CGFloat)fixwidth
{
    NSHashTable *hash = [[NSHashTable alloc] init];
    __block CGFloat maxHeight = 0;
    [culView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectGetMaxY(subview.frame)>maxHeight) {
            maxHeight = CGRectGetMaxY(subview.frame);
        }
        for (int i = subview.frame.origin.y ; i<=subview.frame.size.height + subview.frame.origin.y; i++) {
            [hash addObject:@(i)];
        }
        
    }];
    if (culView.frame.size.height>maxHeight) {
        maxHeight = culView.frame.size.height;
        
    }
    int ignoreHeight = 0;
    for (int i= 0 ; i <= maxHeight; i++) {
        if (![hash containsObject:@(i)]) {
            ignoreHeight++;
        }
    }
    CGRect frame = culView.frame;
    CGFloat WHscale = frame.size.width/(frame.size.height-ignoreHeight);
    frame.size.width = fixwidth;
    frame.size.height =fixwidth / WHscale + ignoreHeight;
    culView.frame = frame;
    culView.autoresizingMask = UIViewAutoresizingNone;
}

//固定高度 求宽度
-(void)settingRadioWidthWithView:(UIView *)culView fixHeight:(CGFloat)fixheight
{
    NSHashTable *hash = [[NSHashTable alloc] init];
    __block CGFloat maxWidth = 0;
    [culView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectGetMaxX(subview.frame)>maxWidth) {
            maxWidth = CGRectGetMaxX(subview.frame);
        }
        for (int i = subview.frame.origin.x ; i<=subview.frame.size.width + subview.frame.origin.x; i++) {
            [hash addObject:@(i)];
        }
        
    }];
    if (culView.frame.size.width>maxWidth) {
        maxWidth = culView.frame.size.width;
        
    }
    int ignoreWidth = 0;
    for (int i= 0 ; i <= maxWidth; i++) {
        if (![hash containsObject:@(i)]) {
            ignoreWidth++;
        }
    }
    CGRect frame = culView.frame;
    
    CGFloat HWscale = frame.size.height/(frame.size.width-ignoreWidth);
    frame.size.height = fixheight;
    frame.size.width =fixheight / HWscale + ignoreWidth;
    culView.frame = frame;
    culView.autoresizingMask = UIViewAutoresizingNone;
}

//固定宽度 求高度
-(void)settingAutoLayoutHeightWithView:(UIView *)culView fixWitdh:(CGFloat)fixwidth
{
    
    BOOL autolayoutFlag = culView.translatesAutoresizingMaskIntoConstraints;
    
    culView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:culView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:fixwidth];
    [culView addConstraint:widthFenceConstraint];
    CGFloat fittingHeight = [culView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    [culView removeConstraint:widthFenceConstraint];
    
    
    culView.translatesAutoresizingMaskIntoConstraints = autolayoutFlag;
    
    CGRect frame = culView.frame;
    frame.size.width = fixwidth;
    frame.size.height =fittingHeight;
    culView.frame = frame;
}

//固定高度 求宽度
-(void)settingAutoLayoutWidthWithView:(UIView *)culView fixHeight:(CGFloat)fixheight
{
    
    BOOL autolayoutFlag = culView.translatesAutoresizingMaskIntoConstraints;
    
    culView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *heightFenceConstraint = [NSLayoutConstraint constraintWithItem:culView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:fixheight];
    [culView addConstraint:heightFenceConstraint];
    CGFloat fittingWidth = [culView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width;
    [culView removeConstraint:heightFenceConstraint];
    
    
    culView.translatesAutoresizingMaskIntoConstraints = autolayoutFlag;
    
    CGRect frame = culView.frame;
    frame.size.width = fittingWidth;
    frame.size.height =fixheight;
    culView.frame = frame;
}



//当 ....才显示
- (TTGroupViewBaseMake *(^)(id))showIf
{
    weakify(self)
    return ^TTGroupViewBaseMake *(id showif) {
        normalize(self)
        
        if (showif) {
            
            if ([showif isKindOfClass:[NSValue class]]) {
                
                if ([showif boolValue] || [showif integerValue] || [showif floatValue]) {
                    
                }
                else
                {
                    self->view = [UIView new];
                    self->view.frame = CGRectZero;
                    
                }
            }
            
        }
        else{
            self->view = [UIView new];
            self->view.frame = CGRectZero;
        }
        
        return self;
    };
    
}

@end



@implementation TTGroupViewVerticalItemMake

#define TTFirstBundleView(nibName) [[[NSBundle bundleForClass:[NSClassFromString(nibName) class]] loadNibNamed:nibName owner:nil options:nil] firstObject]




//自定义高度
- (TTGroupViewVerticalItemMake *(^)(CGFloat))viewCustomHeight
{
    weakify(self)
    return ^TTGroupViewVerticalItemMake *(CGFloat height) {
        normalize(self)
        
        CGRect frame = [self->view frame];
        frame.size.height = height;
        [self->view setFrame:CGRectStandardize(frame)];
        
        return self;
    };
}


- (TTGroupViewVerticalItemMake *(^)(NSString *,SEL,id))viewRadioXib
{
    weakify(self)
    return ^TTGroupViewVerticalItemMake *(NSString *name,SEL sel,id data) {
        normalize(self)
        
        self->view = TTFirstBundleView(name);
        
        
        _Pragma("clang diagnostic push")
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
        if ([self->view respondsToSelector:sel]) {
            [self->view performSelector:sel withObject:data];
        }
         _Pragma("clang diagnostic pop")

        [self settingRadioHeightWithView:self->view fixWitdh:hScreenWidth];
        
        return self;
    };

}



- (TTGroupViewVerticalItemMake *(^)(NSString *,SEL,id))viewAutoLayoutXib
{
    weakify(self)
    return ^TTGroupViewVerticalItemMake *(NSString *name,SEL sel,id data) {
        normalize(self)
        
         self->view = TTFirstBundleView(name);
        _Pragma("clang diagnostic push")
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
        if ([self->view respondsToSelector:sel]) {
            [self->view performSelector:sel withObject:data];
        }
        _Pragma("clang diagnostic pop")
        
        [self settingAutoLayoutHeightWithView:self->view  fixWitdh:hScreenWidth];
        
        return self;
    };
}
- (TTGroupViewVerticalItemMake *(^)(NSString *,SEL,id))viewAutoLayoutCls
{
    weakify(self)
    return ^TTGroupViewVerticalItemMake *(NSString *name,SEL sel,id data) {
        normalize(self)
        
         self->view = [NSClassFromString(name) new];
        _Pragma("clang diagnostic push")
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
        if ([self->view respondsToSelector:sel]) {
            [self->view performSelector:sel withObject:data];
        }
        _Pragma("clang diagnostic pop")
        
        [self settingAutoLayoutHeightWithView:self->view fixWitdh:hScreenWidth];
        
        return self;
    };
}

@end




@implementation TTGroupViewHorizontalItemMake

- (TTGroupViewHorizontalItemMake *(^)(CGFloat))viewFixWidth
{
    weakify(self)
    return ^TTGroupViewHorizontalItemMake *(CGFloat viewFixWidth) {
        normalize(self)
        
        if (self->isAutoLayout) {
            [self settingAutoLayoutHeightWithView:self->view fixWitdh:viewFixWidth];
        }
        else
        {
            [self settingRadioHeightWithView:self->view fixWitdh:viewFixWidth];
        }
        
        return self;
    };
}
- (TTGroupViewHorizontalItemMake *(^)(CGFloat))viewFixHeight
{
    weakify(self)
    return ^TTGroupViewHorizontalItemMake *(CGFloat viewFixHeight) {
        normalize(self)
        
        if (self->isAutoLayout) {
            [self settingAutoLayoutWidthWithView:self->view fixHeight:viewFixHeight];
        }
        else
        {
            [self settingRadioWidthWithView:self->view fixHeight:viewFixHeight];

        }
        
        return self;
    };
}

- (TTGroupViewHorizontalItemMake *(^)(CGFloat,CGFloat))viewCustomWidthHeight
{
    weakify(self)
    return ^TTGroupViewHorizontalItemMake *(CGFloat viewFixWidth,CGFloat viewFixHeight) {
        normalize(self)
        
        CGRect frame = [self->view frame];
        frame.size.width = viewFixWidth;
        frame.size.height = viewFixHeight;
        [self->view setFrame:CGRectStandardize(frame)];
        
        return self;
    };
}


- (TTGroupViewHorizontalItemMake *(^)(NSString *,SEL,id))viewRadioXib
{
    weakify(self)
    return ^TTGroupViewHorizontalItemMake *(NSString *name,SEL sel,id data) {
        normalize(self)
        
        self->view = TTFirstBundleView(name);
        
        self->isAutoLayout = NO;
        _Pragma("clang diagnostic push")
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
        if ([self->view respondsToSelector:sel]) {
            [self->view performSelector:sel withObject:data];
        }
        _Pragma("clang diagnostic pop")
        
        
        return self;
    };
}
- (TTGroupViewHorizontalItemMake *(^)(NSString *,SEL,id))viewAutoLayoutXib
{
    weakify(self)
    return ^TTGroupViewHorizontalItemMake *(NSString *name,SEL sel,id data) {
        normalize(self)
        
        self->view = TTFirstBundleView(name);
        
        self->isAutoLayout = YES;
        
        _Pragma("clang diagnostic push")
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
        if ([self->view respondsToSelector:sel]) {
            [self->view performSelector:sel withObject:data];
        }
        _Pragma("clang diagnostic pop")
       
        return self;
    };
}
- (TTGroupViewHorizontalItemMake *(^)(NSString *,SEL,id))viewAutoLayoutCls
{
    weakify(self)
    return ^TTGroupViewHorizontalItemMake *(NSString *name,SEL sel,id data) {
        normalize(self)
        
        self->view = [NSClassFromString(name) new];
        self->isAutoLayout = YES;
        _Pragma("clang diagnostic push")
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
        if ([self->view respondsToSelector:sel]) {
            [self->view performSelector:sel withObject:data];
        }
        _Pragma("clang diagnostic pop")

        
        return self;
    };
}




@end













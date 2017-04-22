//
//  UIView+Contraints.m
//  elmsc
//
//  Created by Jekity on 17/8/16.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#import "UIView+Contraints.h"
#import <objc/runtime.h>



@implementation UIView (Contraints)

-(void)setConstraintsArray:(NSMutableArray *)constraintsArray{
    
    objc_setAssociatedObject(self, @selector(constraintsArray), constraintsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(NSMutableArray *)constraintsArray{
    
    //懒加载对象
    //存储约束数组
    if (!objc_getAssociatedObject(self, @selector(constraintsArray))) {
        self.constraintsArray = [NSMutableArray array];
    }
    
    return objc_getAssociatedObject(self, @selector(constraintsArray));
    
}


-(void)leftEqualToView:(UIView *)toView margain:(CGFloat)space{
    
    if (self.superview == nil) {
        
        return;
    }
    NSLayoutAttribute attribute;
    
    if (toView != self.superview) {
        
       attribute = NSLayoutAttributeRight;
        
    }else{
      
         attribute = NSLayoutAttributeLeft;
    }

    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:toView attribute:attribute multiplier:1.0 constant:space];
    
    [[self superViewFromView] addConstraint:constraint];
    
    //store constraints
    
    //[self shareInstance];
    [self.constraintsArray addObject:constraint];
    
//    ttLog(@"%@",self.constraintsArray);

    
    
    
}

-(void)rightEqualToView:(UIView *)toView margain:(CGFloat)space{
    
    if (self.superview == nil) {
        
        return;
    }
    
    NSLayoutAttribute attribute;
    
    if (toView != self.superview) {
        
        attribute = NSLayoutAttributeLeft;
        
    }else{
        
        attribute = NSLayoutAttributeRight;
    }

    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:toView attribute:attribute multiplier:1.0 constant:space];
    
    [[self superViewFromView] addConstraint:constraint];
    
//    [self shareInstance];
//    
    [self.constraintsArray addObject:constraint];
//    ttLog(@"%lu",(unsigned long)self.constraintsArray.count);

    //[[self shareInstance] addObject:constraint];
}

-(void)topEqualToView:(UIView *)toView margain:(CGFloat)space{
    
    if (self.superview == nil) {
        
        return;
    }
    
    NSLayoutAttribute attribute;
    
    if (toView != self.superview) {
        
        attribute = NSLayoutAttributeBottom;
        
    }else{
        
        attribute = NSLayoutAttributeTop;
    }

    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:toView attribute:attribute multiplier:1.0 constant:space];
    
    [[self superViewFromView] addConstraint:constraint];
    
    [self.constraintsArray addObject:constraint];
}

-(void)bottomEqualToView:(UIView *)toView margain:(CGFloat)space{
    
    if (self.superview == nil) {
        
        return;
    }
    
    NSLayoutAttribute attribute;
    
    if (toView != self.superview) {
        
        attribute = NSLayoutAttributeTop;
        
    }else{
        
        attribute = NSLayoutAttributeBottom;
    }

    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:toView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:space];
    
    [[self superViewFromView] addConstraint:constraint];
    
    [self.constraintsArray addObject:constraint];
}

//中心点X对齐
-(void)centerXEqualToView:(UIView *)toView{
    
    if (nil == self.superview) {
        
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:toView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    
    [[self superViewFromView] addConstraint:constraint];
    
    [self.constraintsArray addObject:constraint];
}

//中心点Y对齐
-(void)centerYEqualToView:(UIView *)toView{
    
    if (nil == self.superview) {
        
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:toView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    [[self superViewFromView] addConstraint:constraint];
    
    [self.constraintsArray addObject:constraint];
}

/**顶部相等*/
-(void)topEqualToView:(UIView *)toView{
    
    if (nil == self.superview) {
        
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:toView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    
    [[self superViewFromView] addConstraint:constraint];
    
    [self.constraintsArray addObject:constraint];

}

/**底部相等*/
-(void)bottomEqualToView:(UIView *)toView{
    
    if (nil == self.superview) {
        
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:toView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    [[self superViewFromView] addConstraint:constraint];

    [self.constraintsArray addObject:constraint];
    
}

/**左边相等*/
-(void)leftEqualToView:(UIView *)toView{
    
    if (nil == self.superview) {
        
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:toView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    
    [[self superViewFromView] addConstraint:constraint];
    
    [self.constraintsArray addObject:constraint];

}

/**右边相等*/
-(void)rightEqualToView:(UIView *)toView{
    
    if (nil == self.superview) {
        
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:toView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    
    [[self superViewFromView] addConstraint:constraint];
    
    [self.constraintsArray addObject:constraint];
}

/**宽度相等*/
-(void)widthEqualToView:(UIView *)toView{
    
    if (nil == self.superview) {
        
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:toView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    
    
    [[self superViewFromView] addConstraint:constraint];
    
    [self.constraintsArray addObject:constraint];
}

/**高度相等*/
-(void)heightEqualToView:(UIView *)toView{
    
    if (nil == self.superview) {
        
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:toView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    [[self superViewFromView]addConstraint:constraint];
    
    [self.constraintsArray addObject:constraint];
}

/**设置高度*/
-(void)heightForView:(CGFloat)height{
    
    if (nil == self.superview) {
        
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:height];
    
    [[self superViewFromView] addConstraint:constraint];
    
    [self.constraintsArray addObject:constraint];
}

/**设置高度为某个高度的倍数*/
-(void)heightForView:(CGFloat)height multipler:(CGFloat)multipler{
    
    if (nil == self.superview) {
        
        return;
    }
    
    CGFloat tHeight = height * multipler;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:0 constant:tHeight];
    
    [[self superViewFromView]addConstraint:constraint];
    
    [self.constraintsArray addObject:constraint];

}

/**设置高度为参考视图宽度的倍数*/
-(void)heightForView:(UIView *)toView multipler:(CGFloat)multipler constant:(CGFloat)constant{
    
    if (nil == self.superview) {
        
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:toView attribute:NSLayoutAttributeHeight multiplier:multipler constant:constant];
    
    [[self superViewFromView] addConstraint:constraint];
    
    [self.constraintsArray addObject:constraint];
}


/**设置宽度*/
-(void)widthForView:(CGFloat)width{
    
    if (nil == self.superview) {
        
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:width];
    
    [[self superViewFromView]addConstraint:constraint];
    
    [self.constraintsArray addObject:constraint];
}

/**设置宽度为某个宽度的倍数*/
-(void)widthForView:(CGFloat)width multipler:(CGFloat)multipler{
   
    if (nil == self.superview) {
        
        return;
    }
    
    CGFloat tWindth = width * multipler;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:0 constant:tWindth];
    
    [[self superViewFromView]addConstraint:constraint];
    
    [self.constraintsArray addObject:constraint];

}


/**设置宽度为参考对象宽度的倍数*/
-(void)widthForView:(UIView *)toView multipler:(CGFloat)multipler constant:(CGFloat)constant{
    
    if (nil == self.superview) {
        
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:toView attribute:NSLayoutAttributeWidth multiplier:multipler constant:constant];
    
    [[self superViewFromView] addConstraint:constraint];
    
    [self.constraintsArray addObject:constraint];

}


//设置size
-(void)equalToSize:(CGSize) size{
    
    if (nil == self.superview) {
        
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *wConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:size.width];
    
    [self.superview addConstraint:wConstraint];
    
    NSLayoutConstraint *hConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:size.width];
    
    [[self superViewFromView] addConstraint:hConstraint];
    
    [self.constraintsArray addObject:wConstraint];
    
    [self.constraintsArray addObject:hConstraint];
    

}




-(void)removeAllConstraint{
    
    [[self superViewFromView] removeConstraints:self.constraintsArray];
    
    [self.constraintsArray removeAllObjects];
    
   //ttLog(@"%lu",(unsigned long)[self shareInstance].count);
}



//初始化存储约束数组
-(void)initWithFrame_ext{
    
    self.constraintsArray = [[NSMutableArray alloc]init];
    
    /**相当于调用UIView自身的init方法，这样可以保证自定义方法和类自身方法同时调用*/
    [self initWithFrame_ext];
 
}
//获取父视图
-(UIView*)superViewFromView{
    
    UIView *tempView = self.superview;
    
    UIView *superView;
    
    while (tempView != nil) {
        
        superView = tempView;
        
        tempView = tempView.superview;
    }
    
    return superView;
}
@end

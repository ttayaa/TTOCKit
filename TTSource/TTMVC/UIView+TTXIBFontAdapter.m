//
//  UIView+TTXIBFontAdapter.m
//  Pods
//
//  Created by apple on 2017/4/18.
//
//

#import "UIView+TTXIBFontAdapter.h"
#import "TTClassInfo.h"

@implementation UIView (TTXIBFontAdapter)
-(void)FontSizeBindIphone5s:(CGFloat)scale2
{
    TTClassInfo *clsinfo = [TTClassInfo classInfoWithClass:[self class]];
    
    [clsinfo.propertyInfos enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, TTClassPropertyInfo * _Nonnull proinfo, BOOL * _Nonnull stop) {
        
        if ([proinfo.cls isSubclassOfClass:[UIView class]]) {
            
            //适配 上下左右  宽高
            CGFloat scale = [UIScreen mainScreen].bounds.size.width/320 * scale2;
            
            
            for (NSLayoutConstraint *con in self.constraints) {
                
                if (con.firstAttribute < 9) {
                    
                    con.constant = con.constant * scale;
                }
                
                
            }
            
            
            //适配字体
            
            if ([proinfo.cls isSubclassOfClass:[UILabel class]])
            {
                UILabel * lb =  [self performSelector:proinfo.getter];
                CGFloat FontSize =scale *  lb.font.pointSize;
                lb.font = [UIFont systemFontOfSize:FontSize];
            }
            
            if ([proinfo.cls isSubclassOfClass:[UIButton class]])
            {
                UIButton * btn =  [self performSelector:proinfo.getter];
                CGFloat FontSize =scale * btn.titleLabel.font.pointSize;
                btn.titleLabel.font = [UIFont systemFontOfSize:FontSize];
                
            }
            
        }
        

        
        
    }];
    
    
}
-(void)FontSizeBindIphone6s:(CGFloat)scale2
{
    TTClassInfo *clsinfo = [TTClassInfo classInfoWithClass:[self class]];
    
    [clsinfo.propertyInfos enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, TTClassPropertyInfo * _Nonnull proinfo, BOOL * _Nonnull stop) {
        
        
        if ([proinfo.cls isSubclassOfClass:[UIView class]]) {
            
            //适配 上下左右  宽高
            CGFloat scale = [UIScreen mainScreen].bounds.size.width/375 * scale2;
            
            
            for (NSLayoutConstraint *con in self.constraints) {
                
                if (con.firstAttribute < 9) {
                    
                    con.constant = con.constant * scale;
                }
                
            }
            
            
            //适配字体
            
            if ([proinfo.cls isSubclassOfClass:[UILabel class]])
            {
                UILabel * lb =  [self performSelector:proinfo.getter];
                CGFloat FontSize =scale *  lb.font.pointSize;
                lb.font = [UIFont systemFontOfSize:FontSize];
            }
            
           else if ([proinfo.cls isSubclassOfClass:[UIButton class]])
            {
                UIButton * btn =  [self performSelector:proinfo.getter];
                CGFloat FontSize =scale * btn.titleLabel.font.pointSize;
                btn.titleLabel.font = [UIFont systemFontOfSize:FontSize];
                
                
            }

        }
        
        
    }];
}
-(void)FontSizeBindIphone6sp:(CGFloat)scale2
{
    TTClassInfo *clsinfo = [TTClassInfo classInfoWithClass:[self class]];
    
    [clsinfo.propertyInfos enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, TTClassPropertyInfo * _Nonnull proinfo, BOOL * _Nonnull stop) {
        
        if ([proinfo.cls isSubclassOfClass:[UIView class]]) {
            
            //适配 上下左右  宽高
            CGFloat scale = [UIScreen mainScreen].bounds.size.width/414 * scale2;
            
            
            for (NSLayoutConstraint *con in self.constraints) {
                
                if (con.firstAttribute < 9) {
                    
                    con.constant = con.constant * scale;
                }
                
                
            }
            
            
            //适配字体
            
            if ([proinfo.cls isSubclassOfClass:[UILabel class]])
            {
                UILabel * lb =  [self performSelector:proinfo.getter];
                CGFloat FontSize =scale *  lb.font.pointSize;
                lb.font = [UIFont systemFontOfSize:FontSize];
            }
            
            if ([proinfo.cls isSubclassOfClass:[UIButton class]])
            {
                UIButton * btn =  [self performSelector:proinfo.getter];
                CGFloat FontSize =scale * btn.titleLabel.font.pointSize;
                btn.titleLabel.font = [UIFont systemFontOfSize:FontSize];
                
            }
            
        }
        
        
    }];
}


@end

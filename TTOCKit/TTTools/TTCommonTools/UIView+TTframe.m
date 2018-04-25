//
//  UIImage+frame.h
//  common
//
//
//  Copyright © 2016年 ttayaa.
//

#import "UIView+TTframe.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

static char BAViewCookieKey;


@implementation UIView (TTframe)



-(void)setAutoWidth:(CGFloat)AutoWidth
{
    
    
    NSHashTable *hash = [[NSHashTable alloc] init];
    
    __block CGFloat maxHeight = 0;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //获取最大y值的子控件
        if (CGRectGetMaxY(subview.frame)>maxHeight) {
            maxHeight = CGRectGetMaxY(subview.frame);
        }
        
        //判断当前控件该不该忽略
        CGFloat subviewHeight = [subview systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        //说明该子控件没有设置比例
        if (subviewHeight == subview.frame.size.height) {
            
        }
        else//说明已经设置了比例,只有设置了比例的view 才参与比例
        {
            //设置高度区间
            for (int i = subview.frame.origin.y ; i<=subview.frame.size.height + subview.frame.origin.y; i++) {
                [hash addObject:@(i)];
            }
        }
        
    }];
    //最大y值的子控件和当前xib的高度获取最大高度
    if (self.frame.size.height>maxHeight) {
        maxHeight = self.frame.size.height;
        
    }
    
    //如果是当前xib宽度等于屏幕直接返回xib的高度
    if (self.frame.size.width == [UIScreen mainScreen].bounds.size.width) {
        self.autoresizingMask = UIViewAutoresizingNone;
        return;
    }
    
    int ignoreHeight = 0;
    //求出比例忽略的高度
    for (int i= 0 ; i <= maxHeight; i++) {
        if (![hash containsObject:@(i)]) {
            ignoreHeight++;
        }
    }
    
    
    
    
    CGRect frame = self.frame;
    
    //减去忽略高度 求出正确宽高比
    CGFloat WHscale = frame.size.width/(frame.size.height-ignoreHeight);
    frame.size.width = AutoWidth;
    //新求出的高度 +忽略高度 = 该设备正确的高度
    frame.size.height =AutoWidth / WHscale + ignoreHeight;
    
    
//    
//    CGRect frame = self.frame;
//    
//    //减去忽略高度 求出正确宽高比
//    CGFloat WHscale = frame.size.width/frame.size.height;
//    frame.size.width = AutoWidth;
//    //新求出的高度 +忽略高度 = 该设备正确的高度
//    frame.size.height =AutoWidth / WHscale;
    self.frame = frame;
    
    
    //去掉autoresizing 的影响
    self.autoresizingMask = UIViewAutoresizingNone;
//
}



-(void)setAutoHeight:(CGFloat)AutoHeight
{
    CGRect frame = self.frame;
    
    //    保证xib的width原始比例
    CGFloat WHscale = frame.size.width/frame.size.height;
    frame.size.height = AutoHeight;
    frame.size.width =AutoHeight * WHscale;
    
    self.frame = frame;
}


- (void)setTTx:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setTTy:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)TTx
{
    return self.frame.origin.x;
}

- (CGFloat)TTy
{
    return self.frame.origin.y;
}





/**
 *  @brief  找到当前view所在的viewcontroler
 */
- (UIViewController *)TTviewController
{
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

- TTcookie
{
    return objc_getAssociatedObject(self, &BAViewCookieKey);
}

- (void)setTTcookie:cookie
{
    objc_setAssociatedObject(self, &BAViewCookieKey, cookie, OBJC_ASSOCIATION_RETAIN);
}


- (void)setTTsize:(CGSize)size;
{
    CGPoint origin = [self frame].origin;
    
    [self setFrame:CGRectMake(origin.x, origin.y, size.width, size.height)];
}

- (CGSize)TTsize;
{
    return [self frame].size;
}

- (CGFloat)TTleft;
{
    return CGRectGetMinX([self frame]);
}

- (void)setTTleft:(CGFloat)x;
{
    CGRect frame = [self frame];
    frame.origin.x = x;
    [self setFrame:frame];
}

- (CGFloat)TTtop;
{
    return CGRectGetMinY([self frame]);
}

- (void)setTTtop:(CGFloat)y;
{
    CGRect frame = [self frame];
    frame.origin.y = y;
    [self setFrame:frame];
}

- (CGFloat)TTright;
{
    return CGRectGetMaxX([self frame]);
}

- (void)setTTright:(CGFloat)right;
{
    CGRect frame = [self frame];
    frame.origin.x = right - frame.size.width;
    
    [self setFrame:frame];
}

- (CGFloat)TTbottom;
{
    return CGRectGetMaxY([self frame]);
}

- (void)setTTbottom:(CGFloat)bottom;
{
    CGRect frame = [self frame];
    frame.origin.y = bottom - frame.size.height;
    
    [self setFrame:frame];
}

- (CGFloat)TTcenterX;
{
    return [self center].x;
}

- (void)setTTcenterX:(CGFloat)centerX;
{
    [self setCenter:CGPointMake(centerX, self.center.y)];
}

- (CGFloat)TTcenterY;
{
    return [self center].y;
}

- (void)setTTcenterY:(CGFloat)centerY;
{
    [self setCenter:CGPointMake(self.center.x, centerY)];
}

- (CGFloat)TTwidth;
{
    return CGRectGetWidth([self frame]);
}



- (void)setTTwidth:(CGFloat)width;
{
    CGRect frame = [self frame];
    frame.size.width = width;
    
    [self setFrame:CGRectStandardize(frame)];
}

- (CGFloat)TTheight;
{
    return CGRectGetHeight([self frame]);
}

- (void)setTTheight:(CGFloat)height;
{
    CGRect frame = [self frame];
    frame.size.height = height;
    [self setFrame:CGRectStandardize(frame)];
}


- (void)setTTMaxX:(CGFloat)maxX
{
    self.TTx = maxX - self.TTwidth;
}

- (CGFloat)TTmaxX
{
    return CGRectGetMaxX(self.frame);
}

- (void)setTTMaxY:(CGFloat)maxY
{
    self.TTy = maxY - self.TTheight;
}

- (CGFloat)TTmaxY
{
    return CGRectGetMaxY(self.frame);
}





-(void)TTaddShadowonBottom
{
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 0.7;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint p1 = CGPointMake(0.0, 0.0+self.frame.size.height);
    CGPoint p2 = CGPointMake(0.0+self.frame.size.width, p1.y);
    CGPoint c1 = CGPointMake((p1.x+p2.x)/256 , p1.y+1.50);
    CGPoint c2 = CGPointMake(c1.x*255, c1.y);
    
    [path moveToPoint:p1];
    [path addCurveToPoint:p2 controlPoint1:c1 controlPoint2:c2];
    
    self.layer.shadowPath = path.CGPath;
}

-(void)TTaddShadowonTop
{
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 0.7;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint p1 = CGPointMake(0.0, 0.0);
    CGPoint p2 = CGPointMake(0.0+self.frame.size.width, p1.y);
    CGPoint c1 = CGPointMake((p1.x+p2.x)/4 , p1.y-2.5);
    CGPoint c2 = CGPointMake(c1.x*3, c1.y);
    
    [path moveToPoint:p1];
    [path addCurveToPoint:p2 controlPoint1:c1 controlPoint2:c2];
    
    self.layer.shadowPath = path.CGPath;
}

-(void)TTaddGrayGradientShadow
{
    self.layer.shadowOpacity = 0.4;
    
    CGFloat rectWidth = 10.0;
    CGFloat rectHeight = self.frame.size.height;
    
    CGMutablePathRef shadowPath = CGPathCreateMutable();
    CGPathMoveToPoint(shadowPath, NULL, 0.0, 0.0);
    CGPathAddRect(shadowPath, NULL, CGRectMake(0.0-rectWidth, 0.0, rectWidth, rectHeight));
    CGPathAddRect(shadowPath, NULL, CGRectMake(self.frame.size.width, 0.0, rectWidth, rectHeight));
    
    self.layer.shadowPath = shadowPath;
    CGPathRelease(shadowPath);
    
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    self.layer.shadowRadius = 10.0;
}

-(void)TTaddMovingShadow
{
    static float step = 0.0;
    if (step>20.0) {
        step = 0.0;
    }
    
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 1.5;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint p1 = CGPointMake(0.0, 0.0+self.frame.size.height);
    CGPoint p2 = CGPointMake(0.0+self.frame.size.width, p1.y);
    CGPoint c1 = CGPointMake((p1.x+p2.x)/4 , p1.y+step);
    CGPoint c2 = CGPointMake(c1.x*3, c1.y);
    
    [path moveToPoint:p1];
    [path addCurveToPoint:p2 controlPoint1:c1 controlPoint2:c2];
    
    self.layer.shadowPath = path.CGPath;
    step += 0.1;
    [self performSelector:@selector(addMovingShadow) withObject:nil afterDelay:1.0/30.0];
}

-(void)TTremoveShadow
{
    self.layer.shadowOpacity =0;
    self.layer.shadowRadius = 0;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint p1 = CGPointMake(0.0, 0.0);
    CGPoint p2 = CGPointMake(0.0+self.frame.size.width, p1.y);
    CGPoint c1 = CGPointMake(0 , 0);
    CGPoint c2 = CGPointMake(0, 0);
    
    [path moveToPoint:p1];
    [path addCurveToPoint:p2 controlPoint1:c1 controlPoint2:c2];
    
    self.layer.shadowPath = path.CGPath;
}

//针对给定的坐标系居中
- (void)TTcenterInRect:(CGRect)rect;
{
    //如果参数是小数，则求最大的整数但不大于本身.
    //CGRectGetMidX获取中心点的X轴坐标
    [self setCenter:CGPointMake(floorf(CGRectGetMidX(rect)) + ((int)floorf([self TTwidth]) % 2 ? .5 : 0) , floorf(CGRectGetMidY(rect)) + ((int)floorf([self TTheight]) % 2 ? .5 : 0))];
}

//针对给定的坐标系纵向居中
- (void)TTcenterVerticallyInRect:(CGRect)rect;
{
    [self setCenter:CGPointMake([self center].x, floorf(CGRectGetMidY(rect)) + ((int)floorf([self TTheight]) % 2 ? .5 : 0))];
}

//针对给定的坐标系横向居中
- (void)TTcenterHorizontallyInRect:(CGRect)rect;
{
    [self setCenter:CGPointMake(floorf(CGRectGetMidX(rect)) + ((int)floorf([self TTwidth]) % 2 ? .5 : 0), [self center].y)];
}

//相对父视图居中
- (void)TTcenterInSuperView;
{
    [self TTcenterInRect:[[self superview] bounds]];
}

- (void)TTcenterVerticallyInSuperView;
{
    [self TTcenterVerticallyInRect:[[self superview] bounds]];
}

- (void)centerHorizontallyInSuperView;
{
    [self TTcenterHorizontallyInRect:[[self superview] bounds]];
}

//同一父视图的兄弟视图水平居中
- (void)TTcenterHorizontallyBelow:(UIView *)view padding:(CGFloat)padding;
{
    // for now, could use screen relative positions.
    NSAssert([self superview] == [view superview], @"views must have the same parent");
    
    [self setCenter:CGPointMake([view center].x,
                                floorf(padding + CGRectGetMaxY([view frame]) + ([self TTheight] / 2)))];
}

- (void)TTcenterHorizontallyBelow:(UIView *)view;
{
    [self TTcenterHorizontallyBelow:view padding:0];
}

- (void)TTsetFrameSize:(CGSize)newSize
{
    CGRect f = self.frame;
    f.size = newSize;
    self.frame = f;
}

- (void)TTsetFrameWidth:(CGFloat)newWidth {
    CGRect f = self.frame;
    f.size.width = newWidth;
    self.frame = f;
}

- (void)TTsetFrameHeight:(CGFloat)newHeight {
    CGRect f = self.frame;
    f.size.height = newHeight;
    self.frame = f;
}

- (void)TTsetFrameOrigin:(CGPoint)newOrigin
{
    CGRect f = self.frame;
    f.origin = newOrigin;
    self.frame = f;
}

- (void)TTsetFrameOriginX:(CGFloat)newX {
    CGRect f = self.frame;
    f.origin.x = newX;
    self.frame = f;
}

- (void)TTsetFrameOriginY:(CGFloat)newY {
    CGRect f = self.frame;
    f.origin.y = newY;
    self.frame = f;
}

- (void)TTaddSizeWidth:(CGFloat)newWidth {
    CGRect f = self.frame;
    f.size.width += newWidth;
    self.frame = f;
}

- (void)TTaddSizeHeight:(CGFloat)newHeight {
    CGRect f = self.frame;
    f.size.height += newHeight;
    self.frame = f;
}

- (void)TTaddOriginX:(CGFloat)newX {
    CGRect f = self.frame;
    f.origin.x += newX;
    self.frame = f;
}

- (void)TTaddOriginY:(CGFloat)newY {
    CGRect f = self.frame;
    f.origin.y += newY;
    self.frame = f;
}

@end

//
//  UIView+FSExtensions.m
//  FSMenuController
//
//  Created by ttayaa on 14-2-5.
//
//

#import "UIView+FSExtensions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (FSExtensions)

// 获取和设置x坐标
- (CGFloat)viewX
{
	CGRect frame = self.frame;
	return frame.origin.x;
}

- (void)setViewX:(CGFloat)xPoint
{
	CGRect frame = self.frame;
	frame.origin.x = xPoint;
	self.frame = frame;
}

// 获取和设置y坐标
- (CGFloat)viewY
{
	CGRect frame = self.frame;
	return frame.origin.y;
}

- (void)setViewY:(CGFloat)yPoint
{
	CGRect frame = self.frame;
	frame.origin.y = yPoint;
	self.frame = frame;
}

// 获取和设置width
- (CGFloat)viewWidth
{
	CGRect frame = self.frame;
	return frame.size.width;
}

- (void)setViewWidth:(CGFloat)width
{
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}

// 获取和设置height
- (CGFloat)viewHeight
{
	CGRect frame = self.frame;
	return frame.size.height;
}

- (void)setViewHeight:(CGFloat)height
{
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}

// 获取和设置origin
- (CGPoint)viewOrigin
{
	CGRect frame = self.frame;
	return frame.origin;
}

- (void)setViewOrigin:(CGPoint)origin
{
	CGRect frame = self.frame;
	frame.origin = origin;
	self.frame = frame;
}

// 获取和设置size
- (CGSize)viewSize
{
	CGRect frame = self.frame;
	return frame.size;
}

- (void)setViewSize:(CGSize)size
{
	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
}

// 获取view的最右边的x值
-(CGFloat)viewXRight
{
	CGRect frame = self.frame;
	return frame.origin.x + frame.size.width;
}

// 获取view的最下边的y值
-(CGFloat)viewYBelow
{
	CGRect frame = self.frame;
	return frame.origin.y + frame.size.height;
}

//  ---
//  与一个view的y轴对齐
- (void)centerYalignView:(UIView *)view
{
    CGPoint center = self.center;
    center.y = view.center.y;
    self.center = center;
}

// 增加y坐标
- (void)addViewY:(CGFloat)yPoint
{
    CGRect frame = self.frame;
    frame.origin.y = yPoint + self.frame.origin.y;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}


-(void) showBorderWithColor:(UIColor*)color{
#ifdef DEBUG
    self.layer.borderWidth = 1;
    self.layer.borderColor = color.CGColor;
#endif
}

-(void) printPositionInfo{
    CGRect myFrame = self.frame;
    NSLog(@"Origin: (%.0f,%.0f), Width: %.0f, Height: %.0f", myFrame.origin.x, myFrame.origin.y, myFrame.size.width, myFrame.size.height);
}

+ (UIView *)extractFromXib
{
    NSString* viewName = NSStringFromClass([self class]);
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:viewName owner:nil options:nil];
    Class   targetClass = NSClassFromString(viewName);

    for (UIView *view in views) {
        if ([view isMemberOfClass:targetClass]) {
            return view;
        }
    }

    return nil;
}

-(void)removeAllSubView
{
	NSArray *arraySubView = [NSArray arrayWithArray:self.subviews];
	for(UIView *subView in arraySubView)
	{
		if(subView.subviews.count != 0)
		{
			[subView removeAllSubView];
		}
		[subView removeFromSuperview];
	}
}

-(void)moveRightToParentWithPadding:(CGFloat) padding{
    if (self.superview == nil) {
        return;
    }

    CGRect myFrame = self.frame;
    myFrame.origin.x = self.superview.frame.size.width - myFrame.size.width - padding;

    self.frame = myFrame;
}

-(void)centerVertically{
    if (self.superview == nil) {
        return;
    }

    CGRect myFrame = self.frame;
    myFrame.origin.y = (self.superview.frame.size.height - myFrame.size.height)/2;
    self.frame = myFrame;
}

-(void)centerHorizontally{
    if (self.superview == nil) {
        return;
    }

    CGRect myFrame = self.frame;
    myFrame.origin.x = (self.superview.frame.size.width - myFrame.size.width)/2;
    self.frame = myFrame;
}

-(void)setupAccessibility:(NSString *)accessibilityLabel{
    self.accessibilityIdentifier = accessibilityLabel;
}

+ (CGFloat)convert320Scale:(CGFloat)width
{
    return width * [UIScreen mainScreen].bounds.size.width / 320.0f;
}

- (CGRect )positionInWindow
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    CGRect rect = [window convertRect:self.frame fromView:self.superview];
    return rect;
}


@end

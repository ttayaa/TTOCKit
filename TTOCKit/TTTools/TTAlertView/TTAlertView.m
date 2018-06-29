//
//  TTAlertView.m
//  TTModuleDemo
//
//  Created by ttayaa on 16/10/12.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import "TTAlertView.h"
#import <Accelerate/Accelerate.h>

NSString *const TTAlertViewWillShowNotification = @"TTAlertViewWillShowNotification";
NSString *const TTAlertViewDidShowNotification = @"TTAlertViewDidShowNotification";
NSString *const TTAlertViewWillDismissNotification = @"TTAlertViewWillDismissNotification";
NSString *const TTAlertViewDidDismissNotification = @"TTAlertViewDidDismissNotification";

#define LWHColor(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
#define LWHScreenWidth [UIScreen mainScreen].bounds.size.width
#define LWHScreenHeight [UIScreen mainScreen].bounds.size.height
//#define LWHAlertViewWidth 280
//#define LWHAlertViewHeight 150
#define LWHAlertViewWidth 268*[UIScreen mainScreen].bounds.size.width/375
#define LWHAlertViewHeight 180*[UIScreen mainScreen].bounds.size.height/667
#define LWHAlertViewMaxHeight 440
#define LWHMargin 0
#define LWHContentMargin 15
#define LWHButtonHeight 44
#define LWHAlertViewTitleLabelHeight 40
#define LWHAlertViewTitleColor LWHColor(65, 65, 65)
#define LWHAlertViewTitleFont [UIFont boldSystemFontOfSize:20]
#define LWHAlertViewContentColor LWHColor(102, 102, 102)
#define LWHAlertViewContentFont [UIFont systemFontOfSize:14]
#define LWHAlertViewContentHeight (LWHAlertViewHeight - LWHAlertViewTitleLabelHeight - LWHButtonHeight - LWHMargin * 2)
#define LWHiOS7OrLater ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)

@class LWHViewController;

@protocol TTViewControllerDelegate <NSObject>

@optional
- (void)coverViewTouched;

@end
@interface TTAlertView () <TTViewControllerDelegate>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) NSArray *clicks;
@property (nonatomic, copy) clickHandleWithIndex clickWithIndex;
@property (nonatomic, weak) LWHViewController *vc;
@property (nonatomic, strong) UIImageView *screenShotView;
@property (nonatomic, getter=isCustomAlert) BOOL customAlert;
@property (nonatomic, getter=isDismissWhenTouchBackground) BOOL dismissWhenTouchBackground;
@property (nonatomic, getter=isAlertReady) BOOL alertReady;

- (void)setup;

@end

@interface jCSingleTon : NSObject

@property (nonatomic, strong) UIWindow *backgroundWindow;
@property (nonatomic, weak) UIWindow *oldKeyWindow;
@property (nonatomic, strong) NSMutableArray *alertStack;
@property (nonatomic, strong) TTAlertView *previousAlert;

@end

@implementation jCSingleTon

+ (instancetype)shareSingleTon{
    static jCSingleTon *shareSingleTonInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareSingleTonInstance = [jCSingleTon new];
    });
    return shareSingleTonInstance;
}

- (UIWindow *)backgroundWindow{
    if (!_backgroundWindow) {
        _backgroundWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundWindow.windowLevel = UIWindowLevelStatusBar - 1;
    }
    return _backgroundWindow;
}

- (NSMutableArray *)alertStack{
    if (!_alertStack) {
        _alertStack = [NSMutableArray array];
    }
    return _alertStack;
}

@end

@interface LWHViewController : UIViewController

@property (nonatomic, strong) UIImageView *screenShotView;
@property (nonatomic, strong) UIButton *coverView;
@property (nonatomic, weak) TTAlertView *alertView;
@property (nonatomic, weak) id <TTViewControllerDelegate> delegate;

@end

@implementation LWHViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self addScreenShot];
    [self addCoverView];
    [self addAlertView];
}

- (void)addScreenShot{
    UIWindow *screenWindow = [UIApplication sharedApplication].windows.firstObject;
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *originalImage = nil;
    if (LWHiOS7OrLater) {
        originalImage = viewImage;
    } else {
        originalImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(viewImage.CGImage, CGRectMake(0, 20, 320, 460))];
    }
    
    CGFloat blurRadius = 4;
    UIColor *tintColor = [UIColor clearColor];
    CGFloat saturationDeltaFactor = 1;
    UIImage *maskImage = nil;
    
    CGRect imageRect = { CGPointZero, originalImage.size };
    UIImage *effectImage = originalImage;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -originalImage.size.height);
        CGContextDrawImage(effectInContext, imageRect, originalImage.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            uint32_t radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1;
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -originalImage.size.height);
    
    CGContextDrawImage(outputContext, imageRect, originalImage.CGImage);
    
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.screenShotView = [[UIImageView alloc] initWithImage:outputImage];
    
    [self.view addSubview:self.screenShotView];
}

- (void)addCoverView{
    self.coverView = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.coverView.backgroundColor = LWHColor(5, 0, 10);
    [self.coverView addTarget:self action:@selector(coverViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.coverView];
}

- (void)coverViewClick{
    if ([self.delegate respondsToSelector:@selector(coverViewTouched)]) {
        [self.delegate coverViewTouched];
    }
}

- (void)addAlertView{
    [self.alertView setup];
    [self.view addSubview:self.alertView];
}

- (void)showAlert{
    [[NSNotificationCenter defaultCenter] postNotificationName:TTAlertViewWillShowNotification object:self];
    self.alertView.alertReady = NO;
    
    CGFloat duration = 0.3;
    
    for (UIButton *btn in self.alertView.subviews) {
        btn.userInteractionEnabled = NO;
    }
    
    self.screenShotView.alpha = 0;
    self.coverView.alpha = 0;
    self.alertView.alpha = 0;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.screenShotView.alpha = 1;
        self.coverView.alpha = 0.65;
        self.alertView.alpha = 1.0;
    } completion:^(BOOL finished) {
        for (UIButton *btn in self.alertView.subviews) {
            btn.userInteractionEnabled = YES;
        }
        self.alertView.alertReady = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:TTAlertViewDidShowNotification object:self.alertView];
    }];
    
    if (LWHiOS7OrLater) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.values = @[@(0.8), @(1.05), @(1.1), @(1)];
        animation.keyTimes = @[@(0), @(0.3), @(0.5), @(1.0)];
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        animation.duration = duration;
        [self.alertView.layer addAnimation:animation forKey:@"bouce"];
    } else {
        self.alertView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        [UIView animateWithDuration:duration * 0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.alertView.transform = CGAffineTransformMakeScale(1.05, 1.05);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:duration * 0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.alertView.transform = CGAffineTransformMakeScale(1.1, 1.1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration * 0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.alertView.transform = CGAffineTransformMakeScale(1, 1);
                } completion:nil];
            }];
        }];
    }
}

- (void)hideAlertWithCompletion:(void(^)(void))completion{
    [[NSNotificationCenter defaultCenter] postNotificationName:TTAlertViewWillDismissNotification object:self];
    self.alertView.alertReady = NO;
    
    CGFloat duration = 0.2;
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.coverView.alpha = 0;
        self.screenShotView.alpha = 0;
        self.alertView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.screenShotView removeFromSuperview];
        if (completion) {
            completion();
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:TTAlertViewDidDismissNotification object:self];
    }];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(0.4, 0.4);
    } completion:^(BOOL finished) {
        self.alertView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

@end

@implementation TTAlertView

- (NSArray *)buttons{
    if (!_buttons) {
        _buttons = [NSArray array];
    }
    return _buttons;
}

- (NSArray *)clicks{
    if (!_clicks) {
        _clicks = [NSArray array];
    }
    return _clicks;
}

- (instancetype)initWithCustomView:(UIView *)customView dismissWhenTouchedBackground:(BOOL)dismissWhenTouchBackground{
    if (self = [super initWithFrame:customView.bounds]) {
        [self addSubview:customView];
        self.layer.masksToBounds=true;
        self.layer.cornerRadius=8;
        self.center = CGPointMake(LWHScreenWidth / 2, LWHScreenHeight / 2);
        self.customAlert = YES;
        self.dismissWhenTouchBackground = dismissWhenTouchBackground;
    }
    return self;
}

- (void)show{
    [[jCSingleTon shareSingleTon].alertStack addObject:self];
    
    [self showAlert];
}

- (void)dismissWithCompletion:(void(^)(void))completion{
    [self dismissAlertWithCompletion:^{
        if (completion) {
            completion();
        }
    }];
}

+ (void)showOneButtonWithTitle:(NSString *)title Message:(NSString *)message ButtonType:(TTAlertViewButtonType)buttonType ButtonTitle:(NSString *)buttonTitle Click:(clickHandle)click{
    id newClick = click;
    if (!newClick) {
        newClick = [NSNull null];
    }
    TTAlertView *alertView = [TTAlertView new];
    [alertView configAlertViewPropertyWithTitle:title Message:message Buttons:@[@{[NSString stringWithFormat:@"%zi", buttonType] : buttonTitle}] Clicks:@[newClick] ClickWithIndex:nil];
}

+ (void)showTwoButtonsWithTitle:(NSString *)title Message:(NSString *)message ButtonType:(TTAlertViewButtonType)
buttonType ButtonTitle:(NSString *)buttonTitle Click:(clickHandle)click ButtonType:(TTAlertViewButtonType)buttonType1 ButtonTitle:(NSString *)buttonTitle1 Click:(clickHandle)click1{
    id newClick = click;
    if (!newClick) {
        newClick = [NSNull null];
    }
    id newClick1 = click1;
    if (!newClick1) {
        newClick1 = [NSNull null];
    }
    TTAlertView *alertView = [TTAlertView new];
    [alertView configAlertViewPropertyWithTitle:title Message:message Buttons:@[@{[NSString stringWithFormat:@"%zi", buttonType] : buttonTitle}, @{[NSString stringWithFormat:@"%zi", buttonType1] : buttonTitle1}] Clicks:@[newClick, newClick1] ClickWithIndex:nil];
}

+ (void)showMultipleButtonsWithTitle:(NSString *)title Message:(NSString *)message Click:(clickHandleWithIndex)click Buttons:(NSDictionary *)buttons, ...{
    NSMutableArray *btnArray = [NSMutableArray array];
    NSString* curStr;
    va_list list;
    if(buttons)
    {
        [btnArray addObject:buttons];
        
        va_start(list, buttons);
        while ((curStr = va_arg(list, NSString*))) {
            [btnArray addObject:curStr];
        }
        va_end(list);
    }
    NSMutableArray *btns = [NSMutableArray array];
    for (int i = 0; i<btnArray.count; i++) {
        NSDictionary *dic = btnArray[i];
        [btns addObject:@{dic.allKeys.firstObject : dic.allValues.firstObject}];
    }
    
    TTAlertView *alertView = [TTAlertView new];
    [alertView configAlertViewPropertyWithTitle:title Message:message Buttons:btns Clicks:nil ClickWithIndex:click];
}

- (void)configAlertViewPropertyWithTitle:(NSString *)title Message:(NSString *)message Buttons:(NSArray *)buttons Clicks:(NSArray *)clicks ClickWithIndex:(clickHandleWithIndex)clickWithIndex{
    self.title = title;
    self.message = message;
    self.buttons = buttons;
    self.clicks = clicks;
    self.clickWithIndex = clickWithIndex;
    
    [[jCSingleTon shareSingleTon].alertStack addObject:self];
    
    [self showAlert];
}

- (void)showAlert{
    NSInteger count = [jCSingleTon shareSingleTon].alertStack.count;
    TTAlertView *previousAlert = nil;
    if (count > 1) {
        NSInteger index = [[jCSingleTon shareSingleTon].alertStack indexOfObject:self];
        previousAlert = [jCSingleTon shareSingleTon].alertStack[index - 1];
    }
    
    if (previousAlert && previousAlert.vc) {
        if (previousAlert.isAlertReady) {
            [previousAlert.vc hideAlertWithCompletion:^{
                [self showAlertHandle];
            }];
        } else {
            [self showAlertHandle];
        }
    } else {
        [self showAlertHandle];
    }
}

- (void)showAlertHandle{
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    if (keywindow != [jCSingleTon shareSingleTon].backgroundWindow) {
        [jCSingleTon shareSingleTon].oldKeyWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    LWHViewController *vc = [[LWHViewController alloc] init];
    vc.delegate = self;
    vc.alertView = self;
    self.vc = vc;
    
    [jCSingleTon shareSingleTon].backgroundWindow.frame = [UIScreen mainScreen].bounds;
    [[jCSingleTon shareSingleTon].backgroundWindow makeKeyAndVisible];
    [jCSingleTon shareSingleTon].backgroundWindow.rootViewController = self.vc;
    
    [self.vc showAlert];
}

- (void)coverViewTouched{
    if (self.isDismissWhenTouchBackground) {
        [self dismissAlertWithCompletion:nil];
    }
}

- (void)alertBtnClick:(UIButton *)btn{
    [self dismissAlertWithCompletion:^{
        if (self.clicks.count > 0) {
            clickHandle handle = self.clicks[btn.tag];
            if (![handle isEqual:[NSNull null]]) {
                handle();
            }
        } else {
            if (self.clickWithIndex) {
                self.clickWithIndex(btn.tag);
            }
        }
    }];
}

- (void)dismissAlertWithCompletion:(void(^)(void))completion{
    [self.vc hideAlertWithCompletion:^{
        [self stackHandle];
        
        if (completion) {
            completion();
        }
        
        NSInteger count = [jCSingleTon shareSingleTon].alertStack.count;
        if (count > 0) {
            TTAlertView *lastAlert = [jCSingleTon shareSingleTon].alertStack.lastObject;
            [lastAlert showAlert];
        }
    }];
}

- (void)stackHandle{
    [[jCSingleTon shareSingleTon].alertStack removeObject:self];
    
    NSInteger count = [jCSingleTon shareSingleTon].alertStack.count;
    if (count == 0) {
        [self toggleKeyWindow];
    }
}

- (void)toggleKeyWindow{
    [[jCSingleTon shareSingleTon].oldKeyWindow makeKeyAndVisible];
    [jCSingleTon shareSingleTon].backgroundWindow.rootViewController = nil;
    [jCSingleTon shareSingleTon].backgroundWindow.frame = CGRectZero;
}

- (void)setup{
    if (self.subviews.count > 0) {
        return;
    }
    
    if (self.isCustomAlert) {
        return;
    }
    
    self.layer.masksToBounds=true;
    self.layer.cornerRadius=8;
    
    self.frame = CGRectMake(0, 0, LWHAlertViewWidth, LWHAlertViewHeight);
    //    self.backgroundColor = [UIColor whiteColor];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    effectView.layer.cornerRadius = 10.0f;
    effectView.layer.masksToBounds = YES;
    effectView.frame = self.frame;
    [self addSubview:effectView];
    self.backgroundColor = [UIColor clearColor];
    UIVisualEffectView *subEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect effectForBlurEffect:(UIBlurEffect *)effectView.effect]];
    subEffectView.frame = effectView.bounds;
    [effectView.contentView addSubview:subEffectView];
    
    
    //    UIToolbar *toolbar  = [[UIToolbar alloc] initWithFrame:self.frame];
    //    toolbar.barStyle = UIBarStyleBlack;
    //    toolbar.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];
    //    self.backgroundColor = [UIColor clearColor];
    //    self.alpha = 0.1f;
    //    [self addSubview:toolbar];
    
    NSInteger count = self.buttons.count;
    
    if (count > 2) {
        self.frame = CGRectMake(0, 0, LWHAlertViewWidth, LWHAlertViewTitleLabelHeight + LWHAlertViewContentHeight + LWHMargin + (LWHMargin + LWHButtonHeight) * count);
    }
    self.center = CGPointMake(LWHScreenWidth / 2, LWHScreenHeight / 2);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(LWHMargin, 10, LWHAlertViewWidth - LWHMargin * 2, LWHAlertViewTitleLabelHeight-10)];
    //    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = self.title;
    //    titleLabel.textColor = LWHAlertViewTitleColor;
    titleLabel.font = LWHAlertViewTitleFont;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [subEffectView.contentView addSubview:titleLabel];
    
    CGFloat contentLabelYValue=LWHAlertViewTitleLabelHeight;
    if (self.title.length==0||self.title==nil) {
        contentLabelYValue=10;
    }
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(LWHContentMargin, contentLabelYValue, LWHAlertViewWidth - LWHContentMargin * 2, LWHAlertViewContentHeight)];
    //    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.text = self.message;
    //    contentLabel.textColor = LWHAlertViewContentColor;
    contentLabel.font = LWHAlertViewContentFont;
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    [subEffectView.contentView addSubview:contentLabel];
    
    CGFloat contentHeight = [contentLabel sizeThatFits:CGSizeMake(LWHAlertViewWidth-LWHContentMargin*2, CGFLOAT_MAX)].height;
    
    if (contentHeight > LWHAlertViewContentHeight) {
        [contentLabel removeFromSuperview];
        
        UITextView *contentView = [[UITextView alloc] initWithFrame:CGRectMake(LWHContentMargin, contentLabelYValue, LWHAlertViewWidth - LWHContentMargin * 2, LWHAlertViewContentHeight)];
        contentView.backgroundColor = [UIColor clearColor];
        contentView.text = self.message;
        contentView.textColor = LWHAlertViewContentColor;
        contentView.font = LWHAlertViewContentFont;
        contentView.editable = NO;
        if (LWHiOS7OrLater) {
            contentView.selectable = NO;
        }
        [subEffectView.contentView addSubview:contentView];
        
        CGFloat realContentHeight = 0;
        if (LWHiOS7OrLater) {
            [contentView.layoutManager ensureLayoutForTextContainer:contentView.textContainer];
            CGRect textBounds = [contentView.layoutManager usedRectForTextContainer:contentView.textContainer];
            CGFloat height = (CGFloat)ceil(textBounds.size.height + contentView.textContainerInset.top + contentView.textContainerInset.bottom);
            realContentHeight = height;
        }else {
            realContentHeight = contentView.contentSize.height;
        }
        
        if (realContentHeight > LWHAlertViewContentHeight) {
            CGFloat remainderHeight = LWHAlertViewMaxHeight - LWHAlertViewTitleLabelHeight - LWHMargin - (LWHMargin + LWHButtonHeight) * count;
            contentHeight = realContentHeight;
            if (realContentHeight > remainderHeight) {
                contentHeight = remainderHeight;
            }
            
            CGRect frame = contentView.frame;
            frame.size.height = contentHeight;
            contentView.frame = frame;
            
            CGRect selfFrame = self.frame;
            selfFrame.size.height = selfFrame.size.height + contentHeight - LWHAlertViewContentHeight;
            self.frame = selfFrame;
            self.center = CGPointMake(LWHScreenWidth / 2, LWHScreenHeight / 2);
        }
    }
    
    if (!LWHiOS7OrLater) {
        CGRect frame = self.frame;
        frame.origin.y -= 10;
        self.frame = frame;
    }
    
    if (count == 1) {
        
        //增加线条
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(LWHMargin, self.frame.size.height - LWHButtonHeight - LWHMargin, LWHAlertViewWidth - LWHMargin * 2, 0.4)];
        lineView.backgroundColor=LWHColor(238,238,238);
        
        [subEffectView.contentView addSubview:lineView];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(LWHMargin, self.frame.size.height - LWHButtonHeight - LWHMargin, LWHAlertViewWidth - LWHMargin * 2, LWHButtonHeight)];
        NSDictionary *btnDict = [self.buttons firstObject];
        [btn setTitle:[btnDict.allValues firstObject] forState:UIControlStateNormal];
        [self setButton:btn BackgroundWithButonType:[[btnDict.allKeys firstObject] integerValue]];
        [self addSubview:btn];
        btn.tag = 0;
        [btn addTarget:self action:@selector(alertBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    } else if (count == 2) {
        CGFloat btnWidth = LWHAlertViewWidth / 2 - LWHMargin * 1.5;
        
        //增加两条线
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(LWHMargin, self.frame.size.height - LWHButtonHeight - LWHMargin, LWHAlertViewWidth - LWHMargin * 2, 0.4)];
        lineView.backgroundColor=LWHColor(238,238,238);
        [subEffectView.contentView addSubview:lineView];
        
        UIView *seperateLine=[[UIView alloc]initWithFrame:CGRectMake(LWHMargin + (LWHMargin + btnWidth), self.frame.size.height - LWHButtonHeight - LWHMargin,0.4, LWHButtonHeight)];
        seperateLine.backgroundColor=LWHColor(238,238,238);
        [subEffectView.contentView addSubview:seperateLine];
        
        for (int i = 0; i < 2; i++) {
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(LWHMargin + (LWHMargin + btnWidth) * i, self.frame.size.height - LWHButtonHeight - LWHMargin, btnWidth, LWHButtonHeight)];
            NSDictionary *btnDict = self.buttons[i];
            [btn setTitle:[btnDict.allValues firstObject] forState:UIControlStateNormal];
            [self setButton:btn BackgroundWithButonType:[[btnDict.allKeys firstObject] integerValue]];
            [self addSubview:btn];
            btn.tag = i;
            [btn addTarget:self action:@selector(alertBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    } else if (count > 2) {
        if (contentHeight < LWHAlertViewContentHeight) {
            contentHeight = LWHAlertViewContentHeight;
        }
        for (int i = 0; i < count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(LWHMargin, contentLabelYValue + contentHeight + LWHMargin + (LWHMargin + LWHButtonHeight) * i, LWHAlertViewWidth - LWHMargin * 2, LWHButtonHeight)];
            NSDictionary *btnDict = self.buttons[i];
            [btn setTitle:[btnDict.allValues firstObject] forState:UIControlStateNormal];
            [self setButton:btn BackgroundWithButonType:[[btnDict.allKeys firstObject] integerValue]];
            [self addSubview:btn];
            btn.tag = i;
            [btn addTarget:self action:@selector(alertBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)setButton:(UIButton *)btn BackgroundWithButonType:(TTAlertViewButtonType)buttonType{
    UIColor *textColor = nil;
    UIImage *normalImage = nil;
    UIImage *highImage = nil;
    //可以不断的扩展Button样式
    switch (buttonType) {
        case TTAlertViewButtonTypeDefault:
            normalImage = [self imageFromColorWithColor:[UIColor blueColor]];
            highImage = [self imageFromColorWithColor:[UIColor blueColor]];
            
            textColor = LWHColor(255, 255, 255);
            [btn setBackgroundImage:[self resizeImage:normalImage] forState:UIControlStateNormal];
            [btn setBackgroundImage:[self resizeImage:highImage] forState:UIControlStateHighlighted];
            [btn setTitleColor:textColor forState:UIControlStateNormal];
            break;
        case TTAlertViewButtonTypeCancel:
            normalImage = [self imageFromColorWithColor:LWHColor(105, 105, 105)];
            highImage = [self imageFromColorWithColor:LWHColor(105, 105, 105)];
            [btn setBackgroundImage:[self resizeImage:normalImage] forState:UIControlStateNormal];
            [btn setBackgroundImage:[self resizeImage:highImage] forState:UIControlStateHighlighted];
            [btn setTitleColor:textColor forState:UIControlStateNormal];
            textColor = LWHColor(255, 255, 255);
            break;
        case TTAlertViewButtonTypeWarn:
            normalImage = [self imageFromColorWithColor:LWHColor(255, 99, 71)];
            highImage = [self imageFromColorWithColor:LWHColor(255, 99, 71)];
            [btn setBackgroundImage:[self resizeImage:normalImage] forState:UIControlStateNormal];
            [btn setBackgroundImage:[self resizeImage:highImage] forState:UIControlStateHighlighted];
            [btn setTitleColor:textColor forState:UIControlStateNormal];
            textColor = LWHColor(255, 255, 255);
            break;
        case TTAlertViewButtonTypeNone:
            textColor = LWHColor(119, 73, 53);
            
            [btn setTitleColor:textColor forState:UIControlStateNormal];
            break;
        case TTAlertViewButtonTypeHeight:
            
            textColor = [UIColor blueColor];
            [btn setTitleColor:textColor forState:UIControlStateNormal];
            break;
    }
    
    
}

- (UIImage *)resizeImage:(UIImage *)image{
    return [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
}

- (UIImage *)imageFromColorWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

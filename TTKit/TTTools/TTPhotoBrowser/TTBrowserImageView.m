//
//  TTBrowserImageView.m
//  TTPhotoBrowser
//
//  Created by apple on 2017/5/14.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "TTBrowserImageView.h"
#import "UIImageView+WebCache.h"
#import "TTPhotoBrowserConfig.h"
#define hScreenWidth [UIScreen mainScreen].bounds.size.width
#define hScreenHeight [UIScreen mainScreen].bounds.size.height

@interface TTBrowserImageView()
@property (nonatomic ,strong)UIView *infoView;
@end
@implementation TTBrowserImageView
{
    __weak TTWaitingView *_waitingView;
    BOOL _didCheckSize;
    UIScrollView *_scroll;
    UIImageView *_scrollImageView;
    UIScrollView *_zoomingScroolView;
    UIImageView *_zoomingImageView;
    CGFloat _totalScale;
    
    
    UILabel *leftLabel;
    UILabel *righLabel;
}

-(UIView *)infoView{
    if (_infoView == nil) {
        _infoView = [[UIView alloc]initWithFrame:CGRectMake(0, hScreenHeight - 113., hScreenWidth, 113.)];
        _infoView.backgroundColor = [UIColor colorWithWhite:0 alpha:.375];
        
        leftLabel                = [[UILabel alloc] initWithFrame:CGRectMake(30, 10., (hScreenWidth-60.)/2., 103.)];
        _leftInfoLabel           = leftLabel;
        
        _leftInfoLabel.textAlignment = NSTextAlignmentLeft;
        _leftInfoLabel.numberOfLines = 0;
        _leftInfoLabel.text      = @"";
        _leftInfoLabel.textColor = [UIColor whiteColor];
        [_infoView addSubview:leftLabel];
        
        
        righLabel                     = [[UILabel alloc] initWithFrame:CGRectMake(hScreenWidth/2., 10., (hScreenWidth-60.)/2., 103.)];
        _rightInfoLabel               = righLabel;
        _rightInfoLabel.textAlignment = NSTextAlignmentRight;
        _rightInfoLabel.text          = @"";
        _rightInfoLabel.textColor     = [UIColor whiteColor];
        [_infoView addSubview:righLabel];
        
        
    }
    return _infoView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
        _totalScale = 1.0;
        
        // 捏合手势缩放图片
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomImage:)];
        pinch.delegate = self;
        [self addGestureRecognizer:pinch];
        
//        //拖拽手势
//        UIPanGestureRecognizer *pin = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pinImage:)];
//        pin.delegate = self;
//        [self addGestureRecognizer:pin];
//
//
        
        [self addSubview:self.infoView];
        

    
    }
    return self;
}

- (BOOL)isScaled
{
    return  1.0 != _totalScale;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _waitingView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
    CGSize imageSize = self.image.size;
    
    if (self.bounds.size.width * (imageSize.height / imageSize.width) > self.bounds.size.height) {
        if (!_scroll) {
            UIScrollView *scroll = [[UIScrollView alloc] init];
            scroll.backgroundColor = [UIColor whiteColor];
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = self.image;
            _scrollImageView = imageView;
            [scroll addSubview:imageView];
            scroll.backgroundColor = TTPhotoBrowserBackgrounColor;
            _scroll = scroll;
            [self addSubview:scroll];
            if (_waitingView) {
                [self bringSubviewToFront:_waitingView];
            }
        }
        _scroll.frame = self.bounds;

        CGFloat imageViewH = self.bounds.size.width * (imageSize.height / imageSize.width);

        _scrollImageView.bounds = CGRectMake(0, 0, _scroll.frame.size.width, imageViewH);
        _scrollImageView.center = CGPointMake(_scroll.frame.size.width * 0.5, _scrollImageView.frame.size.height * 0.5);
        _scroll.contentSize = CGSizeMake(0, _scrollImageView.bounds.size.height);
        
    } else {
        if (_scroll) [_scroll removeFromSuperview]; // 防止旋转时适配的scrollView的影响
    }
    
}



- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    _waitingView.progress = progress;

}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    TTWaitingView *waiting = [[TTWaitingView alloc] init];
    waiting.bounds = CGRectMake(0, 0, 100, 100);
    waiting.mode = TTWaitingViewProgressMode;
    _waitingView = waiting;
    [self addSubview:waiting];
    
    
    __weak TTBrowserImageView *imageViewWeak = self;

    [self sd_setImageWithURL:url placeholderImage:placeholder options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        imageViewWeak.progress = (CGFloat)receivedSize / expectedSize;

    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [imageViewWeak removeWaitingView];
        if (error) {
            UILabel *label = [[UILabel alloc] init];
            label.bounds = CGRectMake(0, 0, 160, 30);
            label.center = CGPointMake(imageViewWeak.bounds.size.width * 0.5, imageViewWeak.bounds.size.height * 0.5);
            label.text = @"图片加载失败";
            label.font = [UIFont systemFontOfSize:16];
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
            label.layer.cornerRadius = 5;
            label.clipsToBounds = YES;
            label.textAlignment = NSTextAlignmentCenter;
            [imageViewWeak addSubview:label];
        } else {
            _scrollImageView.image = image;
            [_scrollImageView setNeedsDisplay];
        }
        
    }];
    
}

- (void)zoomImage:(UIPinchGestureRecognizer *)recognizer
{
    
    [self bringSubviewToFront:self.infoView];
    [self prepareForImageViewScaling];
    CGFloat scale = recognizer.scale;
    CGFloat temp = _totalScale + (scale - 1);
    [self setTotalScale:temp];
    recognizer.scale = 1.0;
}

- (void)setTotalScale:(CGFloat)totalScale
{
    if ((_totalScale < 0.5 && totalScale < _totalScale) || (_totalScale > 2.0 && totalScale > _totalScale)) return; // 最大缩放 2倍,最小0.5倍
    
    [self zoomWithScale:totalScale];
}

- (void)zoomWithScale:(CGFloat)scale
{
    _totalScale = scale;
    
    _zoomingImageView.transform = CGAffineTransformMakeScale(scale, scale);
    
    if (scale > 1) {
        CGFloat contentW = _zoomingImageView.frame.size.width;
        CGFloat contentH = MAX(_zoomingImageView.frame.size.height, self.frame.size.height);
        
        _zoomingImageView.center = CGPointMake(contentW * 0.5, contentH * 0.5);
        _zoomingScroolView.contentSize = CGSizeMake(contentW, contentH);

        
        CGPoint offset = _zoomingScroolView.contentOffset;
        offset.x = (contentW - _zoomingScroolView.frame.size.width) * 0.5;
//        offset.y = (contentH - _zoomingImageView.frame.size.height) * 0.5;
        _zoomingScroolView.contentOffset = offset;
        
    } else {
        _zoomingScroolView.contentSize = _zoomingScroolView.frame.size;
        _zoomingScroolView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _zoomingImageView.center = _zoomingScroolView.center;
    }
}

- (void)doubleTapToZommWithScale:(CGFloat)scale
{
    [self prepareForImageViewScaling];
    [UIView animateWithDuration:0.5 animations:^{
        [self zoomWithScale:scale];
    } completion:^(BOOL finished) {
        if (scale == 1) {
            [self clear];
        }
    }];
}

- (void)prepareForImageViewScaling
{
    if (!_zoomingScroolView) {
        _zoomingScroolView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _zoomingScroolView.backgroundColor = TTPhotoBrowserBackgrounColor;
        _zoomingScroolView.contentSize = self.bounds.size;
        UIImageView *zoomingImageView = [[UIImageView alloc] initWithImage:self.image];
        CGSize imageSize = zoomingImageView.image.size;
        CGFloat imageViewH = self.bounds.size.height;
        if (imageSize.width > 0) {
            imageViewH = self.bounds.size.width * (imageSize.height / imageSize.width);
        }
        zoomingImageView.bounds = CGRectMake(0, 0, self.bounds.size.width, imageViewH);
        zoomingImageView.center = _zoomingScroolView.center;
        zoomingImageView.contentMode = UIViewContentModeScaleAspectFit;
        _zoomingImageView = zoomingImageView;
        [_zoomingScroolView addSubview:zoomingImageView];
        [self addSubview:_zoomingScroolView];
    }
}

- (void)scaleImage:(CGFloat)scale
{
    [self prepareForImageViewScaling];
    [self setTotalScale:scale];
}

// 清除缩放
- (void)eliminateScale
{
    [self clear];
    _totalScale = 1.0;
}

- (void)clear
{
    [_zoomingScroolView removeFromSuperview];
    _zoomingScroolView = nil;
    _zoomingImageView = nil;

}

- (void)removeWaitingView
{
    [_waitingView removeFromSuperview];
}


@end

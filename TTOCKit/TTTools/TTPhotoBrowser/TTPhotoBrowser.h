//
//  TTPhotoBrowser.h
//  photobrowser
//
//  Created by apple on 2017/5/14.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 1 <TTPhotoBrowserDelegate>
 
 2 在您的图片点击 中如
 self.picview.clickItemOperationBlock = ^(NSInteger currentIndex) {
    normalize(self)
 
    TTPhotoBrowser *browser = [[TTPhotoBrowser alloc] init];
    browser.currentImageIndex = currentIndex;
    browser.sourceImagesContainerView = self.picview.subviews.firstObject;
    browser.isDontUseFrameOpen = YES;
    browser.imageCount = self.picview.imageURLStringsGroup.count;
    browser.delegate = self;
    browser.isHiddenSaveBtn = YES;
    [browser show];
 
 
 };
 
 3
 #pragma mark - TTPhotoBrowserDelegate
 
 - (UIImage *)photoBrowser:(TTPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
 {
 
 return [UIImage imageNamed:@""];
 }
 - (UIImage *)photoBrowser:(TTPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
 {
 return [NSURL URLWithString:self.picview.imageURLStringsGroup[index]];
 }
 */

@class TTButton, TTPhotoBrowser;

@protocol TTPhotoBrowserDelegate <NSObject>

@required

- (UIImage *)photoBrowser:(TTPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;

@optional

- (NSURL *)photoBrowser:(TTPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index;

-(NSString *)photoBrowser:(TTPhotoBrowser *)browser leftinfoLabelText:(NSInteger)index;

-(NSString *)photoBrowser:(TTPhotoBrowser *)browser rightinfoLabelText:(NSInteger)index;

@end


@interface TTPhotoBrowser : UIView <UIScrollViewDelegate>

@property (nonatomic, weak) UIView *sourceImagesContainerView;
@property (nonatomic, assign) NSInteger currentImageIndex;
@property (nonatomic, assign) NSInteger imageCount;

@property (nonatomic, weak) id<TTPhotoBrowserDelegate> delegate;

- (void)show;

@property (nonatomic, assign) BOOL isHiddenSaveBtn;

@property (nonatomic, assign) BOOL isDontUseFrameOpen;

@end

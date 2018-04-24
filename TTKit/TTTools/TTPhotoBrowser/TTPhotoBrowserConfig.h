//
//  TTPhotoBrowserConfig.h
//  TTPhotoBrowser
//
//  Created by apple on 2017/5/14.
//  Copyright © 2017年 ttayaa. All rights reserved.
//


typedef enum {
    TTWaitingViewModeLoopDiagram, // 环形
    TTWaitingViewModePieDiagram // 饼型
} TTWaitingViewMode;

// 图片保存成功提示文字
#define TTPhotoBrowserSaveImageSuccessText @" ^_^ 保存成功 ";

// 图片保存失败提示文字
#define TTPhotoBrowserSaveImageFailText @" >_< 保存失败 ";

// browser背景颜色
#define TTPhotoBrowserBackgrounColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.95]

// browser中图片间的margin
#define TTPhotoBrowserImageViewMargin 10

// browser中显示图片动画时长
#define TTPhotoBrowserShowImageAnimationDuration 0.2f

// browser中显示图片动画时长
#define TTPhotoBrowserHideImageAnimationDuration 0.2f

// 图片下载进度指示进度显示样式（TTWaitingViewModeLoopDiagram 环形，TTWaitingViewModePieDiagram 饼型）
#define TTWaitingViewProgressMode TTWaitingViewModeLoopDiagram

// 图片下载进度指示器背景色
#define TTWaitingViewBackgroundColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]

// 图片下载进度指示器内部控件间的间距
#define TTWaitingViewItemMargin 10



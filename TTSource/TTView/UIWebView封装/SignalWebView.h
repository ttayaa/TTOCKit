//
//  SignalWebView.h
//  fscar
//
//  Created by apple on 2016/10/31.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import <UIKit/UIKit.h>


#define TTDID_LOAD_FINISH -(void)DID_LOAD_FINISH
#define TTDID_START -(void)DID_START
#define TTDID_LOAD_FAILED -(void)DID_LOAD_FAILED
#define TTDID_LOAD_CANCELLED -(void)DID_LOAD_CANCELLED
#define TTWILL_START -(void)WILL_START


@interface SignalWebView : UIWebView<UIWebViewDelegate>

@property (nonatomic, strong) NSString * loadingURL;

@property (nonatomic, strong) NSError *	lastError;
@property (nonatomic, assign) UIWebViewNavigationType navigationType;

//动态属性
@property (nonatomic, readonly) BOOL dy_isLinkClicked;
@property (nonatomic, readonly) BOOL dy_isFormSubmitted;
@property (nonatomic, readonly) BOOL dy_isFormResubmitted;
@property (nonatomic, readonly) BOOL dy_isBackForward;
@property (nonatomic, readonly) BOOL dy_isReload;
@property (nonatomic, assign) BOOL dy_isHideactivityIndicator;

//外部设置的属性
@property (nonatomic, strong) NSString * html;

@property (nonatomic, strong) NSString * file;

@property (nonatomic, strong) NSString * resource;
@property (nonatomic, strong) NSString * url;

@end

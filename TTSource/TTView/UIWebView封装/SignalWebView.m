//
//  SignalWebView.m
//  fscar
//
//  Created by apple on 2016/10/31.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import "SignalWebView.h"

//输出调试
#ifdef DEBUG
#define ttLog(...) NSLog(__VA_ARGS__)
#else
#define ttLog(...)
#endif



@interface SignalWebView ()

{
    NSString *	_loadingURL;
    NSError *	_lastError;
    BOOL		_inited;
    
    UIView * _activityIndicatorBGview;
}

@end

@implementation SignalWebView
@dynamic dy_isLinkClicked;
@dynamic dy_isFormSubmitted;
@dynamic dy_isFormResubmitted;
@dynamic dy_isBackForward;
@dynamic dy_isReload;
@dynamic dy_isHideactivityIndicator;

- (void)initSelf
{
    if ( NO == _inited )
    {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.scalesPageToFit = YES;
        self.allowsInlineMediaPlayback = YES;
        self.mediaPlaybackAllowsAirPlay = YES;
        self.mediaPlaybackRequiresUserAction = YES;
        
        //所有webview中的UIImageView隐藏
        for ( UIView * subView in self.subviews )
        {
            for ( UIView * subView2 in subView.subviews )
            {
                if ( [subView2 isKindOfClass:[UIImageView class]] )
                {
                    subView2.hidden = YES;
                }
            }
        }
        
        _inited = YES;
        
        //		[self load];
//        [self performLoad];
    }
    
    
    
    
    
    if (!self.dy_isHideactivityIndicator) {
        
        //    增加中间菊花
        _activityIndicatorBGview = [[UIView alloc] initWithFrame:self.bounds];
        [_activityIndicatorBGview setTag:108];
        [_activityIndicatorBGview setBackgroundColor:[UIColor whiteColor]];
//        [_activityIndicatorBGview setAlpha:0.2];
        
        [self addSubview:_activityIndicatorBGview];
        
        UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
        [activityIndicator setCenter:_activityIndicatorBGview.center];
        [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.color = [UIColor redColor];
        [_activityIndicatorBGview addSubview:activityIndicator];
        [activityIndicator startAnimating];
        
    }

    
    
}
- (id)init
{
    if( (self = [super initWithFrame:CGRectZero]) )
    {
        [self initSelf];
        
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        [self initSelf];
    }
    return self;
}

#pragma mark - //外部设置的属性

- (void)setHtml:(NSString *)string
{
    [self loadHTMLString:string baseURL:nil];
}

- (void)setFile:(NSString *)path
{
    NSData * data = [NSData dataWithContentsOfFile:path];
    if ( data )
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wnonnull"
        [self loadData:data MIMEType:@"text/html" textEncodingName:@"UTF8" baseURL:nil];
#pragma clang diagnostic pop
    }
}

- (void)setResource:(NSString *)path
{
    NSString * extension = [path pathExtension];
    NSString * fullName = [path substringToIndex:(path.length - extension.length - 1)];
    
    NSString * path2 = [[NSBundle mainBundle] pathForResource:fullName ofType:extension];
    NSData * data = [NSData dataWithContentsOfFile:path2];
    if ( data )
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wnonnull"
        [self loadData:data MIMEType:@"text/html" textEncodingName:@"UTF8" baseURL:nil];
#pragma clang diagnostic pop
    }
}

- (void)setUrl:(NSString *)path
{
    if ( nil == path )
        return;
    
    if ( NO == [path hasPrefix:@"http://"] && NO == [path hasPrefix:@"https://"] )
    {
        path = [NSString stringWithFormat:@"http://%@", path];
    }
    
    NSArray * cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    for ( NSHTTPCookie * cookie in cookies )
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
}


#pragma mark - 动态属性

- (BOOL)isLinkClicked
{
    return UIWebViewNavigationTypeLinkClicked == _navigationType ? YES : NO;
}

- (BOOL)isFormSubmitted
{
    return UIWebViewNavigationTypeFormSubmitted == _navigationType ? YES : NO;
}

- (BOOL)isFormResubmitted
{
    return UIWebViewNavigationTypeFormResubmitted == _navigationType ? YES : NO;
}

- (BOOL)isBackForward
{
    return UIWebViewNavigationTypeBackForward == _navigationType ? YES : NO;
}

- (BOOL)isReload
{
    return UIWebViewNavigationTypeReload == _navigationType ? YES : NO;
}



#pragma mark -

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

    
    self.loadingURL		= request.URL.absoluteString;
    self.navigationType	= navigationType;
    
    if ( nil == self.loadingURL || 0 == self.loadingURL.length )
    {
        ttLog( @"Invalid url" );
        return NO;
    }
    
    	ttLog( @"Loading url '%@'", self.loadingURL );
    
    UIViewController *respondVc = [self getWebViewCurrentViewController];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    
    if ([respondVc respondsToSelector:@selector(WILL_START)]) {
        [respondVc performSelector:@selector(WILL_START)];
    }
#pragma clang diagnostic pop
    
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    UIViewController *respondVc = [self getWebViewCurrentViewController];
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    
    if ([respondVc respondsToSelector:@selector(DID_START)]) {
        [respondVc performSelector:@selector(DID_START)];
    }
#pragma clang diagnostic pop
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
     if (!self.dy_isHideactivityIndicator)
     {
         
             UIView *view = (UIView*)[self viewWithTag:108];
             
             [view removeFromSuperview];

     }
    
   
    
    
    UIViewController *respondVc = [self getWebViewCurrentViewController];
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    
    if ([respondVc respondsToSelector:@selector(DID_LOAD_FINISH)]) {
        [respondVc performSelector:@selector(DID_LOAD_FINISH)];
    }
#pragma clang diagnostic pop
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    if (!self.dy_isHideactivityIndicator)
    {
        
            UIView *view = (UIView*)[self viewWithTag:108];
            
            [view removeFromSuperview];
            
    }
    
    
    
    
    self.lastError = error;
    
    if ( [[error domain] isEqualToString:NSURLErrorDomain] )
    {
        if ( NSURLErrorCancelled == [error code] )
        {

            
            UIViewController *respondVc = [self getWebViewCurrentViewController];
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"

            if ([respondVc respondsToSelector:@selector(DID_LOAD_CANCELLED)]) {
                [respondVc performSelector:@selector(DID_LOAD_CANCELLED)];
            }
#pragma clang diagnostic pop
            return;
        }
    }
    
    if ( [error.domain isEqual:@"WebKitErrorDomain"] && error.code == 102 )
    {
        // 据说这个错误可以忽略掉
    }
    else
    {
        ttLog( @"%@", error );
        
        if ( error.code != 204 )
        {

            UIViewController *respondVc = [self getWebViewCurrentViewController];
            
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
            
            if ([respondVc respondsToSelector:@selector(DID_LOAD_FAILED)]) {
                [respondVc performSelector:@selector(DID_LOAD_FAILED)];
            }
#pragma clang diagnostic pop
            
        }
    }
}


/** 获取当前View的控制器对象 */
-(UIViewController *)getWebViewCurrentViewController{
    UIResponder *next = [self nextResponder];
    
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end






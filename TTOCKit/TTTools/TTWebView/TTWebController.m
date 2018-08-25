//
//  TTBaseWebController.m
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "TTWebController.h"
//#import "SignalWebView.h"

#define isiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)


@interface TTWebController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,weak)UIButton *clossBtn;
@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation TTWebController

-(void)setupProgressView
{
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
    
    if (self.prograssColor) {
        progressView.tintColor = self.prograssColor;
    }
    else
    {
        progressView.tintColor = [UIColor colorWithRed:215/255. green:207/255. blue:118/255. alpha:(1)*1.0];
    }
    
    progressView.trackTintColor = [UIColor blackColor];
    if (self.prograssbgColor) {
        progressView.trackTintColor = self.prograssbgColor;
    }
    [self.view addSubview:progressView];
    self.progressView = progressView;
}


- (void)setupWebView{
    
    WKWebView *web = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    CGFloat NbarHeight=  [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height;
    
    if (self.navigationController) {
        if(self.tabBarController&&self.tabBarController.tabBar.userInteractionEnabled==NO) {
            self.edgesForExtendedLayout=UIRectEdgeNone;
            web.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NbarHeight - 49);
            
            if (isiPhoneX) {
                web.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NbarHeight - 83);
            }
            
        }
        else
        {
            self.edgesForExtendedLayout=UIRectEdgeBottom;
            
            web.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NbarHeight);
            
        }
    }else{
        if(self.tabBarController&&self.tabBarController.tabBar.userInteractionEnabled==NO) {
            self.edgesForExtendedLayout=UIRectEdgeTop;
            
            web.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NbarHeight - 49);
            
            if (isiPhoneX) {
                self.edgesForExtendedLayout=UIRectEdgeAll;
                
                web.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NbarHeight - 83);
            }
        }
        else
        {
            
            web.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
        }
    }
    
    web.UIDelegate = self;
    web.navigationDelegate = self;
    [web addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [web addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    if (self.wkwebBackgroundColor) {
        web.scrollView.backgroundColor = self.wkwebBackgroundColor;
    }
    else
    {
        web.scrollView.backgroundColor = [UIColor whiteColor ];
        
    }
    
    _web = web;
}

#pragma mark---- wkwebview代理 ----
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == self.web&&[keyPath isEqualToString:@"title"])
    {
        
        if (self.isAlwaysTitle && self.navTitle) {
            self.title = self.navTitle;
            return;
        }
        
        if (self.navTitle && !self.web.canGoBack ) {
            
            if (!self.web.canGoBack) {
                self.title = self.navTitle;
            }
        }
        else
        {
            self.title = self.web.title;
        }
        
        
        
    }
    
    else if (object == self.web && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
            NSLog(@"%f",newprogress);
        }
    }
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNav4Left];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupProgressView];
    
    [self setupWebView];
    
    [self.view insertSubview:self.web belowSubview:self.progressView];
    
    
    //    self.edgesForExtendedLayout=UIRectEdgeBottom;
    
    
    
    [self setTitle:self.navTitle];
    
    
    if (self.HTMLString) {
        [self.web loadHTMLString:self.HTMLString baseURL:nil];
    }
    else
    {
        [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    }
    
}

-(void)setTitle:(NSString *)title
{
    //    self.title = self.navTitle;
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.font = [UIFont boldSystemFontOfSize:18];
    lb.backgroundColor = [UIColor clearColor];
    lb.adjustsFontSizeToFitWidth = YES;
    
    lb.text = title;
    
    if (self.navTitleColor) {
        lb.textColor = self.navTitleColor;
    }
    else
    {
        lb.textColor = [UIColor colorWithRed:255/255.0 green:194/255.0 blue:1/255.0 alpha:1];
    }
    
    self.navigationItem.titleView = lb;
    
    
}

- (void)setNav4Left{
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame= CGRectMake(0, 0, 22, 44);
    
    
    if (@available(iOS 11.0, *))
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    
    if (self.backIconName) {
        [btn setImage:[UIImage imageNamed:self.backIconName] forState:UIControlStateNormal];
    }
    else
    {
        //        [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [btn setTitle:@"<" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:arc4random()%255/255. green:arc4random()%255/255. blue:arc4random()%255/255. alpha:1.0] forState:UIControlStateNormal];
        
    }
    
    [btn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *clossBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clossBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    clossBtn.frame = CGRectMake(38, 0, 22, 44);
    self.clossBtn = clossBtn;
    clossBtn.hidden = YES;
    if (self.closeIconName) {
        [clossBtn setImage:[UIImage imageNamed:self.closeIconName] forState:UIControlStateNormal];
    }
    else
    {
        //        [clossBtn setImage:[UIImage imageNamed:@"叉-(1)"] forState:UIControlStateNormal];
        [clossBtn setTitle:@"X" forState:UIControlStateNormal];
        
    }
    [clossBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    leftV.backgroundColor = [UIColor clearColor];
    [leftV addSubview:btn];
    [leftV addSubview:clossBtn];
    
    
    self.navigationItem.leftBarButtonItem = nil;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:leftV];
    
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)close{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backClick:(UIButton *)btn{
    if (self.web.canGoBack) {
        
        [self.web goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}


//- (void)setUrl:(NSString *)url{
//    _url = url;
//
//    [self backIconName];
//    [self closeIconName];
//    [self prograssColor];
//    [self navTitle];
//
//    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
//
//}
//
//-(void)setHTMLString:(NSString *)HTMLString
//{
//    [self backIconName];
//    [self closeIconName];
//    [self prograssColor];
//    [self navTitle];
//    [self.web loadHTMLString:HTMLString baseURL:nil];
//}

- (void)dealloc{
    
    [self.web removeObserver:self forKeyPath:@"title"];
    [self.web removeObserver:self forKeyPath:@"estimatedProgress"];
    
}





#pragma mark - ---- WKNavigationDelegate ----

//是否允许这个导航
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURL *URL = navigationAction.request.URL;
    NSString *urlStr = [URL absoluteString];
    if (![urlStr containsString:@"http"] && self.url) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.dragonB.com/%@",urlStr]]];
        [webView loadRequest:request];
        
        //        navigationAction.request.URL = ;
    }
    
    self.url = URL.absoluteString;
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
    
}

//知道返回内容之后，是否允许加载，允许加载
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
    //    self.progress.alpha  = 1;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}
//跳转到其他的服务器
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
}
//网页由于某些原因加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    //    self.progress.alpha  = 0;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
//网页开始接收网页内容
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    
}


//网页导航加载完毕
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    //    self.clossBtn.hidden = !webView.canGoBack;
    
    if (webView.canGoBack) {
        self.clossBtn.hidden = NO;
    }else
    {
        self.clossBtn.hidden = YES;
    }
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    //        if (webView.title.length>1) {
    //
    //            [self setTitle:webView.title];
    //
    //            [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable ss, NSError * _Nullable error) {
    //                NSLog(@"----document.title:%@---webView title:%@",ss,webView.title);
    //            }];
    //        }
    
    
    //    self.progress.alpha  = 0;
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败,失败原因:%@",[error description]);
    //    self.progress.alpha = 0;
}
//网页加载内容进程终止
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    
}


//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
//    NSLog(@"receive");
//}

@end



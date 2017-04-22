//
//  TTBaseWebController.m
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "TTWebController.h"
#import "SignalWebView.h"

#define hScreenWidth [UIScreen mainScreen].bounds.size.width
#define hScreenHeight [UIScreen mainScreen].bounds.size.height
#define TTRGBA32Color(r, g, b, a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:(a)*1.0]


@interface TTWebController ()
@property (strong, nonatomic) SignalWebView * webview;

@end

@implementation TTWebController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    _webview = [[SignalWebView alloc] initWithFrame:CGRectMake(0, 0, hScreenWidth, hScreenHeight)];
    
    
    _webview.dy_isHideactivityIndicator = self.isHideActivityIndicator;
    
    
    [self.view addSubview:_webview];
    
    _webview.backgroundColor = TTRGBA32Color(250, 250, 250, 1);
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    
    [_webview loadRequest:request];
    
    
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    titlelb.text = self.navTitle;
    self.navigationItem.titleView = titlelb;
    
    
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 22, 38);
    
    if (self.backIconName) {
        [backBtn setImage:[UIImage imageNamed:self.backIconName] forState:UIControlStateNormal];
    }
    else
    {
        [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }
    
    
    
    [backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    
    if (self.showBackButton) {
       self.navigationItem.leftBarButtonItem = backItem;
    }
    
}


-(void)backClick:(UIButton *)btn
{
    if (self.webview.canGoBack) {
        
        [self.webview goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}





@end

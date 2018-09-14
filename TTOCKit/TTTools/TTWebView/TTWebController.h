//
//  TTBaseWebController.h
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

/**API
 TTWebController *web = [TTWebController new];
 web.url =@"http://www.gxzcwl.com/guanyu.aspx";
 web.wkwebBackgroundColor = TTWhiteColor;
 
 web.backIconName = @"后退";
 web.prograssColor = [UIColor greenColor];
 web.prograssbgColor = [UIColor whiteColor];
 //        web.navTitle = self.ttReflashModel.messages[indexPath.row].title;
 web.navTitle = @"关于我们";
 web.isAlwaysTitle = YES;
 web.navTitleColor = [UIColor whiteColor];
 [self.navigationController pushViewController:web animated:YES];
 */

@interface TTWebController : UIViewController

@property (nonatomic, strong)UIColor *wkwebBackgroundColor;

//通过url访问
@property (nonatomic, strong)NSString *url;
//如果有HTMLString 那么久不会访问url
@property (nonatomic, strong)NSString *HTMLString;
//返回的图标
@property (nonatomic, strong)NSString *backIconName;
//关闭的图标
@property (nonatomic, strong)NSString *closeIconName;

//进度条颜色
@property (nonatomic, strong)UIColor *prograssColor;
//进度条背景色
@property (nonatomic, strong)UIColor *prograssbgColor;


//标题/如果不设置 那么会根据网页来
@property (nonatomic, strong)NSString *navTitle;
@property (nonatomic, assign)BOOL isAlwaysTitle;//是否不管内部跳几次都是navtitle(必须有navTitle,才起作用)
@property (nonatomic, strong)UIColor * navTitleColor;




@property (nonatomic,strong)WKWebView *web;

@end

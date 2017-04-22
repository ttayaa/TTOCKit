//
//  TTBaseWebController.h
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTWebController : UIViewController

@property (nonatomic,strong) NSString *backIconName;

/**是否显示返回*/
@property (nonatomic,assign) BOOL showBackButton;

/**设置显示的url*/
@property (nonatomic,strong) NSString *url;//通过url加载

/**设置标题*/
@property (nonatomic,copy) NSString *navTitle;

/**设置标题*/
@property (nonatomic,assign) BOOL isHideActivityIndicator;

@end

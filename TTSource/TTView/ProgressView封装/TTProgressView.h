//
//  TTProgressView.h
//  fscar
//
//  Created by apple on 2016/11/9.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TTProgressShowWait(message) [TTProgressView show:message];
#define TTProgressSucess(message) [TTProgressView showSuccess:message];
#define TTProgressError(message) [TTProgressView showError:message];
#define TTProgressShowTip(message) [TTProgressView showError:message];
#define TTProgressSucessDismiss [TTProgressView dismiss];
#define TTProgressNetWorkFail [TTProgressView showError:@"访问超时,请检查您的网络状况!亲"];




@interface TTProgressView : NSObject

//初始化弹框
+ (void)setupBaseKVNProgressUI;

+ (void)show:(NSString *)text;

+ (void)dismiss;

+ (void)showSuccess:(NSString *)text;

+ (void)showError:(NSString *)text;



@end

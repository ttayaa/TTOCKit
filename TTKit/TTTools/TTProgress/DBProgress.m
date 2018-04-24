//
//  DBProgress.m
//  bssc
//
//  Created by apple on 2017/3/3.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "DBProgress.h"
#import "TTProgressView.h"
#define hScreenWidth [UIScreen mainScreen].bounds.size.width
#define hScreenHeight [UIScreen mainScreen].bounds.size.height
#define DBColor_borderGray [UIColor colorWithRed:101/255. green:101/255. blue:101/255. alpha:(1)*1.0]
#define DBColor_goldColor [UIColor colorWithRed:215/255. green:207/255. blue:118/255. alpha:(1)*1.0]
@implementation DBProgress
+(void)load
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ProgressShowWait:) name:KNOTIFICATION_ShowWait object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ProgressSucess:) name:KNOTIFICATION_Sucess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ProgressError:) name:KNOTIFICATION_Error object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ProgressShowTip:) name:KNOTIFICATION_ShowTip object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ProgressDismiss:) name:KNOTIFICATION_Dismiss object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ProgressNetWorkFail:) name:KNOTIFICATION_NetWorkFail object:nil];
    
    [TTProgressView setupBaseKVNProgressUI];
    
}

+(void)ProgressShowWait:(NSNotification *)noty
{
    TTProgressShowWait(noty.object)
//    [SVProgressHUD showWithStatus:noty.object];
//    [self performSelector:@selector(ProgressDismiss:) withObject:nil afterDelay:3];
    
}
+(void)ProgressSucess:(NSNotification *)noty
{
    TTProgressSucess(noty.object)
//    [SVProgressHUD showSuccessWithStatus:noty.object];
//    [self performSelector:@selector(ProgressDismiss:) withObject:nil afterDelay:2];
}
+(void)ProgressError:(NSNotification *)noty
{
    TTProgressError(noty.object)
//    [SVProgressHUD showErrorWithStatus:noty.object];
//
//    [self performSelector:@selector(ProgressDismiss:) withObject:nil afterDelay:2];
}

+(void)ProgressShowTip:(NSNotification *)noty
{
    [[UIApplication sharedApplication].windows enumerateObjectsUsingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj endEditing:YES];
    }];
    
    NSString *msg =[NSString stringWithFormat:@"%@!",[noty.object firstObject]] ;
    CGFloat secoud = [[noty.object lastObject] floatValue];

    
    CGSize fixsize = CGSizeMake(hScreenWidth-120, MAXFLOAT);
   CGFloat height = [msg boundingRectWithSize:fixsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;

    UILabel *showlb = [[UILabel alloc] initWithFrame:CGRectMake(60, hScreenHeight*3/4-(height+30), hScreenWidth-120, height+30)];
    showlb.text = msg;
    
    showlb.numberOfLines = 0;
    showlb.layer.cornerRadius = 5;
    showlb.layer.masksToBounds = YES;
    showlb.layer.borderWidth = 1;
    showlb.layer.borderColor = DBColor_borderGray.CGColor;

    showlb.textColor = DBColor_goldColor;
    
    showlb.backgroundColor = [UIColor blackColor];

    showlb.textAlignment = NSTextAlignmentCenter;
    [[UIApplication sharedApplication].keyWindow addSubview:showlb];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(secoud * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [showlb removeFromSuperview];
    });
    
    
}
+(void)ProgressDismiss:(NSNotification *)noty
{
    TTProgressSucessDismiss
}
+(void)ProgressNetWorkFail:(NSNotification *)noty
{
    TTProgressError(@"访问超时,请检查您的网络状态!")
}






@end

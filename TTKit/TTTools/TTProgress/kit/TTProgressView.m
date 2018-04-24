//
//  TTProgressView.m
//  fscar
//
//  Created by apple on 2016/11/9.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import "TTProgressView.h"
#import "KVNProgress.h"

@implementation TTProgressView

+ (void)show:(NSString *)text
{
    //    [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus: text,
    //                                      KVNProgressViewParameterBackgroundType: @(KVNProgressBackgroundTypeSolid),
    //                                      KVNProgressViewParameterFullScreen: @NO}];
    
    [KVNProgress showWithStatus:text];
}

+ (void)dismiss
{
    [KVNProgress dismiss];
}

+ (void)showSuccess:(NSString *)text
{
    [KVNProgress showSuccessWithStatus:text];
}

+ (void)showError:(NSString *)text
{
    [KVNProgress showErrorWithStatus:text];
}

+ (void)setupBaseKVNProgressUI
{
    // See the documentation of all appearance propoerties
    //    [KVNProgress appearance].statusColor = [UIColor darkGrayColor];
    //    [KVNProgress appearance].statusFont = [UIFont systemFontOfSize:17.0f];
    //    [KVNProgress appearance].circleStrokeForegroundColor = [UIColor darkGrayColor];
    //    [KVNProgress appearance].circleStrokeBackgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.3f];
    //    [KVNProgress appearance].circleFillBackgroundColor = [UIColor clearColor];
    //    [KVNProgress appearance].backgroundFillColor = [UIColor colorWithWhite:0.9f alpha:0.9f];
    //    [KVNProgress appearance].backgroundTintColor = [UIColor whiteColor];
    //    [KVNProgress appearance].successColor = [UIColor darkGrayColor];
    //    [KVNProgress appearance].errorColor = [UIColor darkGrayColor];
    //    [KVNProgress appearance].circleSize = 75.0f;
    //    [KVNProgress appearance].lineWidth = 2.0f;
    
    KVNProgressConfiguration *configuration = [[KVNProgressConfiguration alloc] init];
    
    configuration.statusColor = [UIColor whiteColor];
    configuration.statusFont = [UIFont fontWithName:@"MicrosoftYaHei" size:15.0f];
    
    configuration.circleStrokeForegroundColor = [UIColor whiteColor];
//    configuration.circleStrokeBackgroundColor = [UIColor colorWithWhite:1.0f alpha:0.3f];
    configuration.circleFillBackgroundColor = [UIColor colorWithWhite:1.0f alpha:0.1f];
//    configuration.backgroundFillColor = [UIColor colorWithRed:0.173f green:0.263f blue:0.856f alpha:0.9f];
//    configuration.backgroundTintColor = [UIColor colorWithRed:0.173f green:0.263f blue:0.856f alpha:1.0f];
    configuration.backgroundFillColor = [UIColor colorWithWhite:1.0f alpha:0.3f];
    configuration.backgroundTintColor = [UIColor blackColor];
    
//    configuration.backgroundTintColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.f];
    
    configuration.successColor = [UIColor greenColor];
    configuration.errorColor = [UIColor redColor];
    configuration.circleSize = 50.0f;
    configuration.lineWidth = 2.0f;
    configuration.fullScreen = NO;
    
//    configuration.minimumDisplayTime =0.2f;
    configuration.minimumSuccessDisplayTime =1.5f;
    configuration.minimumErrorDisplayTime =2.0f;
   
    configuration.tapBlock = ^(KVNProgress *progressView) {
        // Do something you want to do when the user tap on the HUD
        // Does nothing by default
        [KVNProgress dismiss];
        
    };
    
    // You can allow user interaction for behind views but you will losse the tapBlock functionnality just above
    // Does not work with fullscreen mode
    // Default is NO
    configuration.allowUserInteraction = NO;
    
    [KVNProgress setConfiguration:configuration];
}

@end

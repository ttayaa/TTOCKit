//
//  UIViewController+MMPopView.m
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 RecruitTreasure. All rights reserved.
//

#import "UIViewController+MMPopView.h"


@implementation UIViewController (MMPopView)

-(void)TTShowAlertMessage:(NSString*)message
{
    [self TTShowAlertMessage:message titile:@"提示"];
    
}
-(void)TTShowAlertMessage:(NSString*)message titile:(NSString *)title{
    MMPopupItemHandler block = ^(NSInteger index){
        NSLog(@"clickd %@ button",@(index));
    };
    NSArray *items =
    @[MMItemMake(@"确定", MMItemTypeHighlight, block)];
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:title
                                                         detail:message
                                                          items:items];
    
    [alertView show];
}
-(void)TTShowAlertMessage:(NSString *)message title:(NSString *)title clickArr:(NSArray *)arr click:(MMPopupItemHandler) clickIndex{
    if (!arr||arr.count<=0) {
        return;
    }
    __block NSMutableArray *items = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [items addObject:MMItemMake(obj, MMItemTypeHighlight, clickIndex)];
    }];
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:title
                                                         detail:message
                                                          items:items];
    [alertView show];
}
-(void)TTShowSheetTitle:(NSString *)title clickArr:(NSArray *)arr click:(MMPopupItemHandler)clickIndex{
    if (!arr||arr.count<=0) {
        return;
    }
    
    __block NSMutableArray *items = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [items addObject:MMItemMake(obj, MMItemTypeHighlight, clickIndex)];
    }];
    [[[MMSheetView alloc] initWithTitle:title
                                  items:items] show];
};


@end

//
//  BaiduMapSDKAppdelegate.h
//  ZPCommon
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 ZengPing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI/BMKMapView.h>

@interface BaiduMapSDKAppdelegate : NSObject<BMKGeneralDelegate>

@property (strong, nonatomic) BMKMapManager *mapManager;

@end

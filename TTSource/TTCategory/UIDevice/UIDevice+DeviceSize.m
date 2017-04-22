//
//  UIDevice+DeviceSize.m
//  ttCommerce2
//
//  Created by apple on 16/6/18.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import "UIDevice+DeviceSize.h"

#define hKeyWindow [UIApplication sharedApplication].keyWindow
#define hScreenBounds [UIScreen mainScreen].bounds
#define hScreenWidth [UIScreen mainScreen].bounds.size.width
#define hScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation UIDevice (DeviceSize)

+(CGFloat)currentDeviceScreenSize
{
    CGFloat deviceScreenSize = 3.5;
    
    if ((568 == hScreenHeight && 320 == hScreenWidth) || (1136 == hScreenHeight && 640 == hScreenWidth))
    {
        deviceScreenSize = 4.0;
    }
    else if ((667 == hScreenHeight && 375 == hScreenWidth) || (1334 == hScreenHeight && 750 == hScreenWidth))
    {
        deviceScreenSize = 4.7;
    }
    else if ((736 == hScreenHeight && 414 == hScreenWidth) || (2208 == hScreenHeight && 1242 == hScreenWidth))
    {
        deviceScreenSize = 5.5;
    }
    
    return deviceScreenSize;
}
@end

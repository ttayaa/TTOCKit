//
//  TTIFlyFaceImage.m
//  IFlyFaceDemo
//
//  Created by tt on 16/3/1.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import "TTIFlyFaceImage.h"
#import "UIImage+Extensions.h"
#import "iflyMSC/IFlyFaceSDK.h"
#import "TTCalculatorTools.h"


@implementation TTIFlyFaceImage

@synthesize data=_data;

-(instancetype)init{
    if (self=[super init]) {
        _data=nil;
        self.width=0;
        self.height=0;
        self.direction=IFlyFaceDirectionTypeLeft;
    }
    
    return self;
}

-(void)dealloc{
    self.data=nil;
}

@end

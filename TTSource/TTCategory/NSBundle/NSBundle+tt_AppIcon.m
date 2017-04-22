//
//  NSBundle+ttAppIcon.m
//  ZhaoCaiHuiBaoRt
//
//  Created by apple on 2017/2/16.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "NSBundle+tt_AppIcon.h"

@implementation NSBundle (tt_AppIcon)
- (NSString*)tt_appIconPath {
    NSString* iconFilename = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"] ;
    NSString* iconBasename = [iconFilename stringByDeletingPathExtension] ;
    NSString* iconExtension = [iconFilename pathExtension] ;
    return [[NSBundle mainBundle] pathForResource:iconBasename
                                           ofType:iconExtension] ;
}

- (UIImage*)tt_appIcon {
    UIImage*appIcon = [[UIImage alloc] initWithContentsOfFile:[self tt_appIconPath]] ;
    return appIcon;
}
@end

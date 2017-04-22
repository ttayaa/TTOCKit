//
//  VersionTools.h
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionTools : NSObject

/**返回当前是不是新的版本或者说
 用户是否第一次使用这个版本 */
+(BOOL) isNewVersion;

@end

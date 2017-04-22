//
//  NSObject+getVarName.h
//  bssc
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import <Foundation/Foundation.h>


#define TTSignalNameFromVar(VarName) [VarName setClickSignalName:[[self nameWithInstance:VarName] substringFromIndex:1]];\
if ([VarName isKindOfClass:[UIImageView class]]||[VarName isKindOfClass:[UILabel class]]) \
{\
VarName.userInteractionEnabled = YES;\
}\


@interface NSObject (getVarName)

//传入当前类的属性返回名字
- (NSString *)nameWithInstance:(id)instance;

@end

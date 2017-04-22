//
//  UIColor+MACProject
//  MACProject
//
//  Created by ttayaa on 15/12/14.
//  Copyright © 2015年 ttayaa. All rights reserved.
//

#import "UIColor+tt_Project.h"
#import "UIColor+tt.h"

@implementation UIColor(MACProject)

+(UIColor *)tt_appMainColor{

    return [UIColor tt_colorWithMacHexString:@"#323542"];
}
//导航条颜色
+ (UIColor *)tt_appNavigationBarColor{
    return [UIColor tt_colorWithMacHexString:@"#323542"];//#1aa7f2 2da4f6
}

//app蓝色
+ (UIColor *)tt_appBlueColor{
    return [UIColor tt_colorWithMacHexString:@"#7687f1"];//099fde
}

//app红色
+ (UIColor *)tt_appRedColor{
    return [UIColor tt_colorWithMacHexString:@"#ff415b"];
}

//app黄色
+ (UIColor *)tt_appYellowColor{
    return [UIColor tt_colorWithMacHexString:@"#f7ba5b"];
}


//app橙色
+ (UIColor *)tt_appOrangeColor{
    return [UIColor tt_colorWithMacHexString:@"#ea6644"];
}

//app绿色
+ (UIColor *)tt_appGreenColor{
    return [UIColor tt_colorWithMacHexString:@"#52cbb9"];
}

//app背景色
+ (UIColor *)tt_appBackGroundColor{
    return [UIColor tt_colorWithMacHexString:@"#e6e6e6"];
}

//app直线色
+ (UIColor *)tt_appLineColor{
//    return [UIColor colorWithMacHexString:@"#c8c8c8"];
    return [UIColor tt_colorWithMacHexString:@"#D6D6D6"];
}
//app导航栏文字颜色
+ (UIColor *)tt_appNavTitleColor{
    return [UIColor tt_colorWithMacHexString:@"#013e5d"];
}
//app标题颜色
+ (UIColor *)tt_appTitleColor{
    return [UIColor tt_colorWithMacHexString:@"#474747"];
}

//app文字颜色
+ (UIColor *)tt_appTextColor{
    return [UIColor tt_colorWithMacHexString:@"#A0A0A0"];
}

//app浅红颜色
+ (UIColor *)tt_appLightRedColor{
    return [UIColor tt_colorWithMacHexString:@"#FFB7C1"];
}

//app输入框颜色
+ (UIColor *)tt_appTextFieldColor{
    return [UIColor tt_colorWithMacHexString:@"#FFFFFF"];
}

//app黑色色
+ (UIColor *)tt_appBlackColor{
    return [UIColor tt_colorWithMacHexString:@"#333d47" ];
}
/**
 *  app次分割线
 */
+ (UIColor *)tt_appSecondLineColor{
     return [UIColor tt_colorWithMacHexString:@"#e5e5e5"];
}

@end

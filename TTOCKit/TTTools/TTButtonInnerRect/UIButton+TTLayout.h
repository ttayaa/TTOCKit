//
//  UIButton+Layout.h
//  YLButton
//
//  Created by HelloYeah on 2016/12/5.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TTLayout)
/**API
 _XXXbtn.imageRect = CGRectMake(80/2 -_tixian_btn.imageView.size.width/2, 0, _tixian_btn.imageView.size.width, _tixian_btn.imageView.size.height);
 _XXXbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
 _XXXbtn.titleRect = CGRectMake(0, _tixian_btn.imageView.size.height+5, 80, 20);
 */

@property (nonatomic,assign) CGRect TTtitleRect;
@property (nonatomic,assign) CGRect TTimageRect;

@end

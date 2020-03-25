//
//  TableViewCell1.m
//  testproject
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import "TableViewCell1.h"
#import "TTSignal.h"
@interface TableViewCell1 ()
@property (weak, nonatomic) IBOutlet UIButton *push;

@property (weak, nonatomic) IBOutlet UIButton *present;
@property (weak, nonatomic) IBOutlet UIButton *web;
@property (weak, nonatomic) IBOutlet UIButton *alphaBar;
@property (weak, nonatomic) IBOutlet UIButton *network;
@property (weak, nonatomic) IBOutlet UIButton *scan;
@property (weak, nonatomic) IBOutlet UIButton *alert;

@end
@implementation TableViewCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//TTSignal(btn)
//{
//    
//}
@end

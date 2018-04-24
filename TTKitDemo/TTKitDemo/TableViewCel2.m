//
//  TableViewCel2.m
//  testproject
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import "TableViewCel2.h"
@interface TableViewCel2 ()

@property (weak, nonatomic) IBOutlet UILabel *ColorBar;
@property (weak, nonatomic) IBOutlet UISwitch *swich;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end
@implementation TableViewCel2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.ColorBar.userInteractionEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end

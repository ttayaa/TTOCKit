//
//  TTBankNumberTF.m
//  ZhaoCaiHuiBaoRt
//
//  Created by Wzs 王 on 2017/7/27.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "TTBankNumberTF.h"
#import "UITextField+TTNumberTF.h"

@interface TTBankNumberTF ()<UITextFieldDelegate>

@property(nonatomic,assign)BOOL Flag;

@end

@implementation TTBankNumberTF

- (void)awakeFromNib{
    [super awakeFromNib];
    self.delegate = self;
    self.keyboardType = UIKeyboardTypeNumberPad;

}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    self.Flag = YES;
    NSArray *insertPosition = @[@(4), @(8), @(12), @(16)];
    [textField insertWhitSpaceInsertPosition:insertPosition replacementString:string textlength:22];
    self.Flag = NO;
    
    return NO;
    
}
- (void)setText:(NSString *)text{
    if (self.isEditing) {
        [super setText:text];
        return;
    }
    NSArray *insertPosition = @[@(4), @(8), @(12), @(16), @(20)];
    NSUInteger targetCursorPosition = 0;
    NSString *t = [self insertWhitespaceCharacter:text andPreserveCursorPosition:&targetCursorPosition insertPosition:insertPosition];
    [super setText:t];
}

- (NSString *)text{
    NSString *t = [super text];
    
    if (self.Flag) {
        
        return t;
    }
    

    //移除空格
    return [t stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end

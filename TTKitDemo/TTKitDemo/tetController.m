//
//  tetController.m
//  testproject
//
//  Created by apple on 2018/4/10.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import "tetController.h"
#import "TTSignal.h"
#import "TTRouter.h"
@interface tetController ()
@property (weak, nonatomic) IBOutlet UIButton *dissmis;

@end

@implementation tetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)back:(id)sender {
    
//    self.callbackblock(@"我是按钮点击回调");
//    
//    [self dismissViewControllerAnimated:YES completion:nil];

}

TTSignal(dissmis)
{
        self.callbackblock(@"我是按钮信号回调");
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

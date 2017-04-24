//
//  ViewController.m
//  TTSourceDemo
//
//  Created by apple on 2017/4/23.
//  Copyright © 2017年 ttayaa. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+LogDealloc.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self openDeallocLog:YES];
    
    UIView *view =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    view.backgroundColor = [UIColor redColor];
    view.clickSignalName = @"asdasd";
    [self.view addSubview:view];
}

Click_signal(asdasd)
{
    [self presentViewController:[ViewController new]  animated:YES completion:nil];
//    [self.navigationController pushViewController:[ViewController new] animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

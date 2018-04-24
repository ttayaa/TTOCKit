//
//  ViewController.m
//  TTNetworkDemo
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import "ViewController.h"
#import "TTWebController.h"
#import "TTVM.h"
#import "TTSignal.h"
#import "TTRouter.h"
#import "tetController.h"
#import "TTMacros.h"
#import "TTControllerCategoryHeader.h"
#import "DBProgress.h"

#import "testmodel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TTNVDefaultBarWithColor:[UIColor whiteColor] bindScrollView:self.tableView];
    //    [self TTNVShowLine:NO];
}

-(void)viewDidLoad
{
    
    
    [super viewDidLoad];
    weakify(self)
    [self.tableView TTGroup:^(TTTableSectionCountBlock SectionCount) {
        SectionCount(1);
    } eachSection:^(TTTableSectionMake *makeSection, NSInteger section) {
        makeSection.rows(2);
    } eachSectionItemCell:^(TTTableItemMake *makeItem, NSInteger section, NSInteger row) {
        if (row==0) {
            
            makeItem.CellRadioXib(@"TableViewCell1",@selector(setModel:),nil).CellCustomHeight(50);
        }
        if (row==1) {
            
            makeItem.CellRadioXib(@"TableViewCel2",@selector(setModel:),nil).CellCustomHeight(50);
        }
    } eachCellBlock:^(UITableViewCell *cell, NSInteger section, NSInteger row) {
        
        
    } eachCellHeaderFooterBlock:^(UITableViewHeaderFooterView *cellHeader, UITableViewHeaderFooterView *cellFooter, NSInteger section) {
        
    }];
    
    self.tableView.tableFooterView = [UIView new];
    
    
    
}

TTTableViewDatasoureDelegate



TTSignal(push)
{

    
    
    [self.navigationController TTPushViewController:[tetController new] animated:YES SetupParms:^(UIViewController *vc, NSMutableDictionary *dict) {
        
    } callback:^(id parameter) {
        
    } jumpError:^{
        
    }];
    
}
TTSignal(present)
{
    [self TTPresentStyleViewController:@"tetController" animated:YES frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2) style:TTPresentStyleDownMenu_blackhud SetupParms:^(UIViewController *vc, NSMutableDictionary *dict) {
        
    } completion:^{
        
    } callback:^(id parameter) {
        
        CommonProgressShowTip(parameter, 2)
    } jumpError:^{
        
    }];
}
TTSignal(web)
{
    TTWebController *web = [[TTWebController alloc] init];
    //        web.HTMLString = self.ttReflashModel.messages[indexPath.row].content;
    web.url =@"https://www.baidu.com/";
    web.wkwebBackgroundColor = TTGrayColor(200);
    
//    web.backIconName = @"backicon";
    web.prograssColor = [UIColor redColor];
    web.prograssbgColor = [UIColor whiteColor];
    //        web.navTitle = self.ttReflashModel.messages[indexPath.row].title;
    web.navTitle = @"关于我们";
    web.isAlwaysTitle = YES;
    web.navTitleColor = [UIColor blueColor];
    [self.navigationController pushViewController:web animated:YES];
}
TTSignal(alphaBar)
{
    [self TTNVAlphaBar:TTAlphaNaviBarStyle2 BarColor:[UIColor redColor] bindScrollView:self.tableView];
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    [UIView animateWithDuration:2 animations:^{
        self.tableView.contentOffset = CGPointMake(0, 100);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            self.tableView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            
        }];
    }];
}


TTSignal(network)
{

    [testmodel POST_default:@"/auth/login" CacheIf:0 IsShowHud:1 parameters:^(testmodel *ParmsModel) {
        ParmsModel.login = @"13471045617";
        ParmsModel.password = @"asdasd";
    } success:^(BOOL isCatch, testmodel *model, NSMutableArray<testmodel *> *modelArr, id responseObject) {
        
    } failure:^(NSError *error, NSString *errorStr, NSString *status) {
//        CommonProgressShowTip(errorStr, 5)
        CommonProgressError(errorStr)
    }];
    
}


TTSignal(ColorBar)
{
    [self.navigationController TTPushViewController:@"TTQRScanController" animated:YES SetupParms:^(UIViewController *vc, NSMutableDictionary *dict) {
        
    } callback:^(id parameter) {
        
    } jumpError:^{
        
    }];
    
//    [self TTNVAlphaBar:TTAlphaNaviBarStyle1 BarColor:[UIColor redColor] bindScrollView:self.tableView];
//
//     self.edgesForExtendedLayout = UIRectEdgeTop;
//
//    [UIView animateWithDuration:2 animations:^{
//        self.tableView.contentOffset = CGPointMake(0, 100);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:2 animations:^{
//            self.tableView.contentOffset = CGPointMake(0, 0);
//        } completion:^(BOOL finished) {
//
//        }];
//    }];
    
}
TTSignal(swich)
{
    
}
TTSignal(textfield)
{
    
}


@end


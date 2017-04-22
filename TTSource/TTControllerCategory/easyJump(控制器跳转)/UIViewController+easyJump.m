//
//  UIViewController+easyJump.m
//  elmsc
//
//  Created by apple on 2016/10/17.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#import "UIViewController+easyJump.h"


@interface UIViewController (easyJump_help)

@property (copy, nonatomic) OnceBlock dy_OutsideviewDidLoadWilldoblock_once;
@property (copy, nonatomic) OnceBlock dy_OutsideviewWillLayoutSubviewsWilldoblock_once;
@property (copy, nonatomic) OnceBlock dy_OutsideviewDidLayoutSubviewsWilldoblock_once;
@property (copy, nonatomic) OnceBlock dy_OutsideviewWillAppearWilldoblock_once;
@property (copy, nonatomic) OnceBlock dy_OutsideviewDidAppearWilldoblock_once;
@property (copy, nonatomic) OnceBlock dy_OutsideviewWillDisappearWilldoblock_once;
@property (copy, nonatomic) OnceBlock dy_OutsideviewDidDisappearWilldoblock_once;

/** 设置已经被调用过了,下次viewDidAppear不会被调用*/
@property (assign,nonatomic) BOOL dy_isAlreadyLoadviewDidLoadBlock;
@property (assign,nonatomic) BOOL dy_isAlreadyLoadviewWillLayoutSubviewsBlock;
@property (assign,nonatomic) BOOL dy_isAlreadyLoadviewDidLayoutSubviewsBlock;
@property (assign,nonatomic) BOOL dy_isAlreadyLoadviewWillAppearBlock;
@property (assign,nonatomic) BOOL dy_isAlreadyLoadviewDidAppearBlock;
@property (assign,nonatomic) BOOL dy_isAlreadyLoadviewWillDisappearBlock;
@property (assign,nonatomic) BOOL dy_isAlreadyLoadviewDidDisappearBlock;



@property (copy, nonatomic) OffenBlock dy_OutsideviewDidLoadWilldoblock_offen;
@property (copy, nonatomic) OffenBlock dy_OutsideviewWillLayoutSubviewsWilldoblock_offen;
@property (copy, nonatomic) OffenBlock dy_OutsideviewDidLayoutSubviewsWilldoblock_offen;
@property (copy, nonatomic) OffenBlock dy_OutsideviewWillAppearWilldoblock_offen;
@property (copy, nonatomic) OffenBlock dy_OutsideviewDidAppearWilldoblock_offen;
@property (copy, nonatomic) OffenBlock dy_OutsideviewWillDisappearWilldoblock_offen;
@property (copy, nonatomic) OffenBlock dy_OutsideviewDidDisappearWilldoblock_offen;

@end

@implementation UIViewController (easyJump_help)

@dynamic dy_OutsideviewDidLoadWilldoblock_once;
@dynamic dy_OutsideviewWillLayoutSubviewsWilldoblock_once;
@dynamic dy_OutsideviewDidLayoutSubviewsWilldoblock_once;
@dynamic dy_OutsideviewWillAppearWilldoblock_once;
@dynamic dy_OutsideviewDidAppearWilldoblock_once;
@dynamic dy_OutsideviewWillDisappearWilldoblock_once;
@dynamic dy_OutsideviewDidDisappearWilldoblock_once;


@dynamic dy_isAlreadyLoadviewDidLoadBlock;
@dynamic dy_isAlreadyLoadviewWillLayoutSubviewsBlock;
@dynamic dy_isAlreadyLoadviewDidLayoutSubviewsBlock;
@dynamic dy_isAlreadyLoadviewWillAppearBlock;
@dynamic dy_isAlreadyLoadviewDidAppearBlock;
@dynamic dy_isAlreadyLoadviewWillDisappearBlock;
@dynamic dy_isAlreadyLoadviewDidDisappearBlock;


@dynamic dy_OutsideviewDidLoadWilldoblock_offen;
@dynamic dy_OutsideviewWillLayoutSubviewsWilldoblock_offen;
@dynamic dy_OutsideviewDidLayoutSubviewsWilldoblock_offen;
@dynamic dy_OutsideviewWillAppearWilldoblock_offen;
@dynamic dy_OutsideviewDidAppearWilldoblock_offen;
@dynamic dy_OutsideviewWillDisappearWilldoblock_offen;
@dynamic dy_OutsideviewDidDisappearWilldoblock_offen;



@end



@implementation UIViewController (easyJump)

@dynamic dy_easyjumpArgs;


ControllerCategoryOverride(easyJump);

viewDidLoad(easyJump)
{
    //如果block有值说明外部 已经调用了WhenViewDidAppear方法
    //然后就调用外部的传入的这个block
    if (self.dy_OutsideviewDidLoadWilldoblock_once&&self.dy_isAlreadyLoadviewDidLoadBlock==NO) {
        self.dy_OutsideviewDidLoadWilldoblock_once();
        self.dy_isAlreadyLoadviewDidLoadBlock = YES;
    }
    //如有常用的block 就调用
    if (self.dy_OutsideviewDidLoadWilldoblock_offen) {
        self.dy_OutsideviewDidLoadWilldoblock_offen(self.dy_easyjumpArgs);
    }
    
}
-(void)WhenViewDidLoad:(OnceBlock)OutsideWilldoblock
{
    self.dy_OutsideviewDidLoadWilldoblock_once = OutsideWilldoblock;

}
-(void)WhenViewDidLoad_offen:(OffenBlock)OutsideWilldoblock
{
    self.dy_OutsideviewDidLoadWilldoblock_offen = OutsideWilldoblock;
}



viewWillLayoutSubviews(easyJump)
{
    //如果block有值说明外部 已经调用了WhenViewDidAppear方法
    //然后就调用外部的传入的这个block
    if (self.dy_OutsideviewWillLayoutSubviewsWilldoblock_once&&self.dy_isAlreadyLoadviewWillLayoutSubviewsBlock==NO) {
        self.dy_OutsideviewWillLayoutSubviewsWilldoblock_once();
        self.dy_isAlreadyLoadviewWillLayoutSubviewsBlock = YES;
    }
    //如有常用的block 就调用
    if (self.dy_OutsideviewWillLayoutSubviewsWilldoblock_offen) {
        self.dy_OutsideviewWillLayoutSubviewsWilldoblock_offen(self.dy_easyjumpArgs);
    }
}
-(void)WhenViewWillLayoutSubviews:(OnceBlock)OutsideWilldoblock
{
    self.dy_OutsideviewWillLayoutSubviewsWilldoblock_once = OutsideWilldoblock;

}
-(void)WhenViewWillLayoutSubviews_offen:(OffenBlock)OutsideWilldoblock
{
    self.dy_OutsideviewWillLayoutSubviewsWilldoblock_offen = OutsideWilldoblock;
    
}


viewDidLayoutSubviews(easyJump)
{
    //如果block有值说明外部 已经调用了WhenViewDidAppear方法
    //然后就调用外部的传入的这个block
    if (self.dy_OutsideviewDidLayoutSubviewsWilldoblock_once&&self.dy_isAlreadyLoadviewDidLayoutSubviewsBlock==NO) {
        self.dy_OutsideviewDidLayoutSubviewsWilldoblock_once();
        self.dy_isAlreadyLoadviewDidLayoutSubviewsBlock = YES;
    }
    //如有常用的block 就调用
    if (self.dy_OutsideviewDidLayoutSubviewsWilldoblock_offen) {
        self.dy_OutsideviewDidLayoutSubviewsWilldoblock_offen(self.dy_easyjumpArgs);
    }
}
-(void)WhenViewDidLayoutSubviews:(OnceBlock)OutsideWilldoblock
{
    self.dy_OutsideviewDidLayoutSubviewsWilldoblock_once = OutsideWilldoblock;
}
-(void)WhenViewDidLayoutSubviews_offen:(OffenBlock)OutsideWilldoblock
{
    self.dy_OutsideviewDidLayoutSubviewsWilldoblock_offen = OutsideWilldoblock;
}


viewWillAppear(easyJump)
{
    //如果block有值说明外部 已经调用了WhenViewDidAppear方法
    //然后就调用外部的传入的这个block
    if (self.dy_OutsideviewWillAppearWilldoblock_once&&self.dy_isAlreadyLoadviewWillAppearBlock==NO) {
        self.dy_OutsideviewWillAppearWilldoblock_once();
        self.dy_isAlreadyLoadviewWillAppearBlock = YES;
    }
    //如有常用的block 就调用
    if (self.dy_OutsideviewWillAppearWilldoblock_offen) {
        self.dy_OutsideviewWillAppearWilldoblock_offen(self.dy_easyjumpArgs);
    }
}
-(void)WhenViewWillAppear:(OnceBlock)OutsideWilldoblock
{
    self.dy_OutsideviewWillAppearWilldoblock_once = OutsideWilldoblock;
}
-(void)WhenViewWillAppear_offen:(OffenBlock)OutsideWilldoblock
{
    self.dy_OutsideviewWillAppearWilldoblock_offen = OutsideWilldoblock;
}



viewDidAppear(easyJump)
{
    //如果block有值说明外部 已经调用了WhenViewDidAppear方法
    //然后就调用外部的传入的这个block
    if (self.dy_OutsideviewDidAppearWilldoblock_once&&self.dy_isAlreadyLoadviewDidAppearBlock==NO) {
        self.dy_OutsideviewDidAppearWilldoblock_once();
        self.dy_isAlreadyLoadviewDidAppearBlock = YES;
    }
    
    //如有常用的block 就调用
    if (self.dy_OutsideviewDidAppearWilldoblock_offen) {
        self.dy_OutsideviewDidAppearWilldoblock_offen(self.dy_easyjumpArgs);
    }
}
//通过这个方法获得外部传入的block
-(void)WhenViewDidAppear:(OnceBlock)OutsideWilldoblock
{
    self.dy_OutsideviewDidAppearWilldoblock_once = OutsideWilldoblock;
    
}
-(void)WhenViewDidAppear_offen:(OffenBlock)OutsideWilldoblock
{
    self.dy_OutsideviewDidAppearWilldoblock_once = OutsideWilldoblock;
    
}


viewWillDisappear(easyJump)
{
    //如果block有值说明外部 已经调用了WhenViewDidAppear方法
    //然后就调用外部的传入的这个block
    if (self.dy_OutsideviewWillDisappearWilldoblock_once&&self.dy_isAlreadyLoadviewWillDisappearBlock==NO) {
        self.dy_OutsideviewWillDisappearWilldoblock_once();
        self.dy_isAlreadyLoadviewWillDisappearBlock = YES;
    }
    //如有常用的block 就调用
    if (self.dy_OutsideviewWillDisappearWilldoblock_offen) {
        self.dy_OutsideviewWillDisappearWilldoblock_offen(self.dy_easyjumpArgs);
    }
}
-(void)WhenViewWillDisappear:(OnceBlock)OutsideWilldoblock
{
    self.dy_OutsideviewWillDisappearWilldoblock_once = OutsideWilldoblock;

}

-(void)WhenViewWillDisappear_offen:(OffenBlock)OutsideWilldoblock
{
    self.dy_OutsideviewWillDisappearWilldoblock_offen = OutsideWilldoblock;
}



viewDidDisappear(easyJump)
{
    //如果block有值说明外部 已经调用了WhenViewDidAppear方法
    //然后就调用外部的传入的这个block
    if (self.dy_OutsideviewDidDisappearWilldoblock_once&&self.dy_isAlreadyLoadviewDidDisappearBlock==NO) {
        self.dy_OutsideviewDidDisappearWilldoblock_once();
        self.dy_isAlreadyLoadviewDidDisappearBlock = YES;
    }
    //如有常用的block 就调用
    if (self.dy_OutsideviewDidDisappearWilldoblock_offen) {
         self.dy_OutsideviewDidDisappearWilldoblock_offen(self.dy_easyjumpArgs);
    }
    
}
-(void)WhenViewDidDisappear:(OnceBlock)OutsideWilldoblock
{
    self.dy_OutsideviewDidDisappearWilldoblock_once = OutsideWilldoblock;

}

-(void)WhenViewDidDisappear_offen:(OffenBlock)OutsideWilldoblock
{
    self.dy_OutsideviewDidDisappearWilldoblock_offen = OutsideWilldoblock;

}





@end

//
//  UIViewController+easyJump.m
//  elmsc
//
//  Created by apple on 2016/10/17.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#import "UIViewController+easyJump.h"
#import "ControllerCategoryOverride.h"

@interface UIViewController (easyJump_help)

@property (copy, nonatomic) OnceBlock TTOutsideviewDidLoadWilldoblock_once;
@property (copy, nonatomic) OnceBlock TTOutsideviewWillLayoutSubviewsWilldoblock_once;
@property (copy, nonatomic) OnceBlock TTOutsideviewDidLayoutSubviewsWilldoblock_once;
@property (copy, nonatomic) OnceBlock TTOutsideviewWillAppearWilldoblock_once;
@property (copy, nonatomic) OnceBlock TTOutsideviewDidAppearWilldoblock_once;
@property (copy, nonatomic) OnceBlock TTOutsideviewWillDisappearWilldoblock_once;
@property (copy, nonatomic) OnceBlock TTOutsideviewDidDisappearWilldoblock_once;

/** 设置已经被调用过了,下次viewDidAppear不会被调用*/
@property (assign,nonatomic) BOOL TTisAlreadyLoadviewDidLoadBlock;
@property (assign,nonatomic) BOOL TTisAlreadyLoadviewWillLayoutSubviewsBlock;
@property (assign,nonatomic) BOOL TTisAlreadyLoadviewDidLayoutSubviewsBlock;
@property (assign,nonatomic) BOOL TTisAlreadyLoadviewWillAppearBlock;
@property (assign,nonatomic) BOOL TTisAlreadyLoadviewDidAppearBlock;
@property (assign,nonatomic) BOOL TTisAlreadyLoadviewWillDisappearBlock;
@property (assign,nonatomic) BOOL TTisAlreadyLoadviewDidDisappearBlock;



@property (copy, nonatomic) OffenBlock TTOutsideviewDidLoadWilldoblock_offen;
@property (copy, nonatomic) OffenBlock TTOutsideviewWillLayoutSubviewsWilldoblock_offen;
@property (copy, nonatomic) OffenBlock TTOutsideviewDidLayoutSubviewsWilldoblock_offen;
@property (copy, nonatomic) OffenBlock TTOutsideviewWillAppearWilldoblock_offen;
@property (copy, nonatomic) OffenBlock TTOutsideviewDidAppearWilldoblock_offen;
@property (copy, nonatomic) OffenBlock TTOutsideviewWillDisappearWilldoblock_offen;
@property (copy, nonatomic) OffenBlock TTOutsideviewDidDisappearWilldoblock_offen;

@end



#define TTDynamicBlockProperty(type, attribute)            \
@dynamic attribute; \
- (type)attribute \
{ \
return objc_getAssociatedObject(self, @selector(attribute)); \
} \
- (void)set##attribute:(type)attribute \
{ \
objc_setAssociatedObject(self, @selector(attribute), attribute, OBJC_ASSOCIATION_COPY_NONATOMIC); \
} \

#define TTDynamicObjProperty(type, attribute)            \
@dynamic attribute; \
- (type *)attribute \
{ \
return objc_getAssociatedObject(self, @selector(attribute)); \
} \
- (void)set##attribute:(type *)attribute \
{ \
objc_setAssociatedObject(self, @selector(attribute), attribute, OBJC_ASSOCIATION_COPY_NONATOMIC); \
} \

#define TTDynamicBOOLProperty(attribute)            \
@dynamic attribute; \
- (BOOL)attribute \
{ \
return [objc_getAssociatedObject(self, @selector(attribute)) boolValue]; \
} \
- (void)set##attribute:(BOOL)attribute \
{ \
objc_setAssociatedObject(self, @selector(attribute), @(attribute), OBJC_ASSOCIATION_RETAIN); \
} \




@implementation UIViewController (easyJump_help)



TTDynamicBlockProperty(OnceBlock, TTOutsideviewDidLoadWilldoblock_once)
TTDynamicBlockProperty(OnceBlock, TTOutsideviewWillLayoutSubviewsWilldoblock_once)
TTDynamicBlockProperty(OnceBlock, TTOutsideviewDidLayoutSubviewsWilldoblock_once)
TTDynamicBlockProperty(OnceBlock, TTOutsideviewWillAppearWilldoblock_once)
TTDynamicBlockProperty(OnceBlock, TTOutsideviewDidAppearWilldoblock_once)
TTDynamicBlockProperty(OnceBlock, TTOutsideviewWillDisappearWilldoblock_once)
TTDynamicBlockProperty(OnceBlock, TTOutsideviewDidDisappearWilldoblock_once)



TTDynamicBOOLProperty(TTisAlreadyLoadviewDidLoadBlock)
TTDynamicBOOLProperty(TTisAlreadyLoadviewWillLayoutSubviewsBlock)
TTDynamicBOOLProperty(TTisAlreadyLoadviewDidLayoutSubviewsBlock)
TTDynamicBOOLProperty(TTisAlreadyLoadviewWillAppearBlock)
TTDynamicBOOLProperty(TTisAlreadyLoadviewDidAppearBlock)
TTDynamicBOOLProperty(TTisAlreadyLoadviewWillDisappearBlock)
TTDynamicBOOLProperty(TTisAlreadyLoadviewDidDisappearBlock)

TTDynamicBlockProperty(OffenBlock, TTOutsideviewDidLoadWilldoblock_offen)
TTDynamicBlockProperty(OffenBlock, TTOutsideviewWillLayoutSubviewsWilldoblock_offen)
TTDynamicBlockProperty(OffenBlock, TTOutsideviewDidLayoutSubviewsWilldoblock_offen)
TTDynamicBlockProperty(OffenBlock, TTOutsideviewWillAppearWilldoblock_offen)
TTDynamicBlockProperty(OffenBlock, TTOutsideviewDidAppearWilldoblock_offen)
TTDynamicBlockProperty(OffenBlock, TTOutsideviewWillDisappearWilldoblock_offen)
TTDynamicBlockProperty(OffenBlock, TTOutsideviewDidDisappearWilldoblock_offen)

@end



@implementation UIViewController (easyJump)
@dynamic TTeasyjumpArgs;
-(id)TTeasyjumpArgs
{
    return objc_getAssociatedObject(self, @selector(TTeasyjumpArgs)) ;
}

-(void)setTTeasyjumpArgs:(id)TTeasyjumpArgs
{
    objc_setAssociatedObject(self, @selector(TTeasyjumpArgs), TTeasyjumpArgs, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


ControllerCategoryOverride(easyJump);

viewDidLoad(easyJump)
{
    //如果block有值说明外部 已经调用了WhenViewDidAppear方法
    //然后就调用外部的传入的这个block
    if (self.TTOutsideviewDidLoadWilldoblock_once&&self.TTisAlreadyLoadviewDidLoadBlock==NO) {
        self.TTOutsideviewDidLoadWilldoblock_once();
        self.TTisAlreadyLoadviewDidLoadBlock = YES;
    }
    //如有常用的block 就调用
    if (self.TTOutsideviewDidLoadWilldoblock_offen) {
        self.TTOutsideviewDidLoadWilldoblock_offen(self.TTeasyjumpArgs);
    }
    
}
-(void)WhenViewDidLoad:(OnceBlock)OutsideWilldoblock
{
    self.TTOutsideviewDidLoadWilldoblock_once = OutsideWilldoblock;

}
-(void)WhenViewDidLoad_offen:(OffenBlock)OutsideWilldoblock
{
    self.TTOutsideviewDidLoadWilldoblock_offen = OutsideWilldoblock;
}



viewWillLayoutSubviews(easyJump)
{
    //如果block有值说明外部 已经调用了WhenViewDidAppear方法
    //然后就调用外部的传入的这个block
    if (self.TTOutsideviewWillLayoutSubviewsWilldoblock_once&&self.TTisAlreadyLoadviewWillLayoutSubviewsBlock==NO) {
        self.TTOutsideviewWillLayoutSubviewsWilldoblock_once();
        self.TTisAlreadyLoadviewWillLayoutSubviewsBlock = YES;
    }
    //如有常用的block 就调用
    if (self.TTOutsideviewWillLayoutSubviewsWilldoblock_offen) {
        self.TTOutsideviewWillLayoutSubviewsWilldoblock_offen(self.TTeasyjumpArgs);
    }
}
-(void)WhenViewWillLayoutSubviews:(OnceBlock)OutsideWilldoblock
{
    self.TTOutsideviewWillLayoutSubviewsWilldoblock_once = OutsideWilldoblock;

}
-(void)WhenViewWillLayoutSubviews_offen:(OffenBlock)OutsideWilldoblock
{
    self.TTOutsideviewWillLayoutSubviewsWilldoblock_offen = OutsideWilldoblock;
    
}


viewDidLayoutSubviews(easyJump)
{
    //如果block有值说明外部 已经调用了WhenViewDidAppear方法
    //然后就调用外部的传入的这个block
    if (self.TTOutsideviewDidLayoutSubviewsWilldoblock_once&&self.TTisAlreadyLoadviewDidLayoutSubviewsBlock==NO) {
        self.TTOutsideviewDidLayoutSubviewsWilldoblock_once();
        self.TTisAlreadyLoadviewDidLayoutSubviewsBlock = YES;
    }
    //如有常用的block 就调用
    if (self.TTOutsideviewDidLayoutSubviewsWilldoblock_offen) {
        self.TTOutsideviewDidLayoutSubviewsWilldoblock_offen(self.TTeasyjumpArgs);
    }
}
-(void)WhenViewDidLayoutSubviews:(OnceBlock)OutsideWilldoblock
{
    self.TTOutsideviewDidLayoutSubviewsWilldoblock_once = OutsideWilldoblock;
}
-(void)WhenViewDidLayoutSubviews_offen:(OffenBlock)OutsideWilldoblock
{
    self.TTOutsideviewDidLayoutSubviewsWilldoblock_offen = OutsideWilldoblock;
}


viewWillAppear(easyJump)
{
    //如果block有值说明外部 已经调用了WhenViewDidAppear方法
    //然后就调用外部的传入的这个block
    if (self.TTOutsideviewWillAppearWilldoblock_once&&self.TTisAlreadyLoadviewWillAppearBlock==NO) {
        self.TTOutsideviewWillAppearWilldoblock_once();
        self.TTisAlreadyLoadviewWillAppearBlock = YES;
    }
    //如有常用的block 就调用
    if (self.TTOutsideviewWillAppearWilldoblock_offen) {
        self.TTOutsideviewWillAppearWilldoblock_offen(self.TTeasyjumpArgs);
    }
}
-(void)WhenViewWillAppear:(OnceBlock)OutsideWilldoblock
{
    self.TTOutsideviewWillAppearWilldoblock_once = OutsideWilldoblock;
}
-(void)WhenViewWillAppear_offen:(OffenBlock)OutsideWilldoblock
{
    self.TTOutsideviewWillAppearWilldoblock_offen = OutsideWilldoblock;
}



viewDidAppear(easyJump)
{
    //如果block有值说明外部 已经调用了WhenViewDidAppear方法
    //然后就调用外部的传入的这个block
    if (self.TTOutsideviewDidAppearWilldoblock_once&&self.TTisAlreadyLoadviewDidAppearBlock==NO) {
        self.TTOutsideviewDidAppearWilldoblock_once();
        self.TTisAlreadyLoadviewDidAppearBlock = YES;
    }
    
    //如有常用的block 就调用
    if (self.TTOutsideviewDidAppearWilldoblock_offen) {
        self.TTOutsideviewDidAppearWilldoblock_offen(self.TTeasyjumpArgs);
    }
}
//通过这个方法获得外部传入的block
-(void)WhenViewDidAppear:(OnceBlock)OutsideWilldoblock
{
    self.TTOutsideviewDidAppearWilldoblock_once = OutsideWilldoblock;
    
}
-(void)WhenViewDidAppear_offen:(OffenBlock)OutsideWilldoblock
{
    self.TTOutsideviewDidAppearWilldoblock_once = OutsideWilldoblock;
    
}


viewWillDisappear(easyJump)
{
    //如果block有值说明外部 已经调用了WhenViewDidAppear方法
    //然后就调用外部的传入的这个block
    if (self.TTOutsideviewWillDisappearWilldoblock_once&&self.TTisAlreadyLoadviewWillDisappearBlock==NO) {
        self.TTOutsideviewWillDisappearWilldoblock_once();
        self.TTisAlreadyLoadviewWillDisappearBlock = YES;
    }
    //如有常用的block 就调用
    if (self.TTOutsideviewWillDisappearWilldoblock_offen) {
        self.TTOutsideviewWillDisappearWilldoblock_offen(self.TTeasyjumpArgs);
    }
}
-(void)WhenViewWillDisappear:(OnceBlock)OutsideWilldoblock
{
    self.TTOutsideviewWillDisappearWilldoblock_once = OutsideWilldoblock;

}

-(void)WhenViewWillDisappear_offen:(OffenBlock)OutsideWilldoblock
{
    self.TTOutsideviewWillDisappearWilldoblock_offen = OutsideWilldoblock;
}



viewDidDisappear(easyJump)
{
    //如果block有值说明外部 已经调用了WhenViewDidAppear方法
    //然后就调用外部的传入的这个block
    if (self.TTOutsideviewDidDisappearWilldoblock_once&&self.TTisAlreadyLoadviewDidDisappearBlock==NO) {
        self.TTOutsideviewDidDisappearWilldoblock_once();
        self.TTisAlreadyLoadviewDidDisappearBlock = YES;
    }
    //如有常用的block 就调用
    if (self.TTOutsideviewDidDisappearWilldoblock_offen) {
         self.TTOutsideviewDidDisappearWilldoblock_offen(self.TTeasyjumpArgs);
    }
    
}
-(void)WhenViewDidDisappear:(OnceBlock)OutsideWilldoblock
{
    self.TTOutsideviewDidDisappearWilldoblock_once = OutsideWilldoblock;

}

-(void)WhenViewDidDisappear_offen:(OffenBlock)OutsideWilldoblock
{
    self.TTOutsideviewDidDisappearWilldoblock_offen = OutsideWilldoblock;

}





@end

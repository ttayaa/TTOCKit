//
//  ControllerCategoryOverride.h
//  elmsc
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#ifndef ControllerCategoryOverride_h
#define ControllerCategoryOverride_h

/**   1
 ControllerCategoryOverride(name)
 
 在分类的@implementation 加入这个分类就可以交换调用 并回调原来方法
 */
#pragma mark - 分类扩展原有方法

#import <objc/runtime.h>


#define ControllerCategoryOverride(name) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wundeclared-selector\"") \
+(void)load \
{  \
Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad)); \
Method ExtviewDidLoad = class_getInstanceMethod(self,@selector(viewDidLoad_##name)); \
method_exchangeImplementations(viewDidLoad, ExtviewDidLoad); \
\
Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:)); \
Method ExtviewWillAppear = class_getInstanceMethod(self,@selector(viewWillAppear_##name:)); \
method_exchangeImplementations(viewWillAppear, ExtviewWillAppear); \
\
Method viewDidDisappear = class_getInstanceMethod(self, @selector(viewDidDisappear:)); \
Method ExtviewDidDisappear = class_getInstanceMethod(self,@selector(viewDidDisappear_##name:)); \
method_exchangeImplementations(viewDidDisappear, ExtviewDidDisappear); \
\
Method viewWillDisappear = class_getInstanceMethod(self, @selector(viewWillDisappear:)); \
Method ExtviewWillDisappear = class_getInstanceMethod(self,@selector(viewWillDisappear_##name:)); \
method_exchangeImplementations(viewWillDisappear, ExtviewWillDisappear); \
\
Method viewDidLayoutSubviews = class_getInstanceMethod(self, @selector(viewDidLayoutSubviews)); \
Method ExtviewDidLayoutSubviews = class_getInstanceMethod(self,@selector(viewDidLayoutSubviews_##name)); \
method_exchangeImplementations(viewDidLayoutSubviews, ExtviewDidLayoutSubviews); \
\
Method viewWillLayoutSubviews = class_getInstanceMethod(self, @selector(viewWillLayoutSubviews)); \
Method ExtviewWillLayoutSubviews = class_getInstanceMethod(self,@selector(viewWillLayoutSubviews_##name)); \
method_exchangeImplementations(viewWillLayoutSubviews, ExtviewWillLayoutSubviews); \
\
Method viewDidAppear = class_getInstanceMethod(self, @selector(viewDidAppear:)); \
Method ExtviewDidAppear = class_getInstanceMethod(self,@selector(viewDidAppear_##name:)); \
method_exchangeImplementations(viewDidAppear, ExtviewDidAppear); \
\
\
if ([self respondsToSelector:@selector(LOADEXT)]) { \
    [self performSelector:@selector(LOADEXT)]; \
}\
\
} \
_Pragma("clang diagnostic pop") \


/**    2

 在分类中实现 viewDidLoad(categoryName){...} viewWillAppear(categoryName){...} .....
 */

#define viewDidLoad(categoryName) \
-(void)viewDidLoad_##categoryName \
{ if ([self respondsToSelector:@selector(viewDidLoad_##categoryName )]) \
[self viewDidLoad_##categoryName ]; \
else \
{[NSException raise:@"主类没有重写父类的方法,但是主类的分类扩展了该方法" format:@"请在你的主类中加上%@",@"viewDidLoad"];} \
[self _viewDidLoad_##categoryName ]; \
} \
-(void)_viewDidLoad_##categoryName  \


#define viewWillAppear(categoryName) \
-(void)viewWillAppear_##categoryName:(BOOL)animated \
{ if ([self respondsToSelector:@selector(viewWillAppear_##categoryName:)]) \
[self viewWillAppear_##categoryName:animated]; \
else \
{[NSException raise:@"主类没有重写父类的方法,但是主类的分类扩展了该方法" format:@"请在你的主类中加上%@",@"viewWillAppear"];} \
[self _viewWillAppear_##categoryName:animated]; \
} \
-(void)_viewWillAppear_##categoryName:(BOOL)animated \


#define viewDidAppear(categoryName) \
-(void)viewDidAppear_##categoryName:(BOOL)animated \
{ if ([self respondsToSelector:@selector(viewDidAppear_##categoryName:)]) \
[self viewDidAppear_##categoryName:animated]; \
else \
{[NSException raise:@"主类没有重写父类的方法,但是主类的分类扩展了该方法" format:@"请在你的主类中加上%@",@"viewDidAppear"];} \
[self _viewDidAppear_##categoryName:animated]; \
} \
-(void)_viewDidAppear_##categoryName:(BOOL)animated \


#define viewDidDisappear(categoryName) \
-(void)viewDidDisappear_##categoryName:(BOOL)animated \
{ if ([self respondsToSelector:@selector(viewDidDisappear_##categoryName:)]) \
[self viewDidDisappear_##categoryName:animated]; \
else \
{[NSException raise:@"主类没有重写父类的方法,但是主类的分类扩展了该方法" format:@"请在你的主类中加上%@",@"viewDidDisappear"];} \
[self _viewDidDisappear_##categoryName:animated]; \
} \
-(void)_viewDidDisappear_##categoryName:(BOOL)animated \


#define viewWillDisappear(categoryName) \
-(void)viewWillDisappear_##categoryName:(BOOL)animated \
{ if ([self respondsToSelector:@selector(viewWillDisappear_##categoryName:)]) \
[self viewWillDisappear_##categoryName:animated]; \
else \
{[NSException raise:@"主类没有重写父类的方法,但是主类的分类扩展了该方法" format:@"请在你的主类中加上%@",@"viewWillDisappear"];} \
[self _viewWillDisappear_##categoryName:animated]; \
} \
-(void)_viewWillDisappear_##categoryName:(BOOL)animated \


#define viewDidLayoutSubviews(categoryName) \
-(void)viewDidLayoutSubviews_##categoryName \
{ if ([self respondsToSelector:@selector(viewDidLayoutSubviews_##categoryName )]) \
[self viewDidLayoutSubviews_##categoryName ]; \
else \
{[NSException raise:@"主类没有重写父类的方法,但是主类的分类扩展了该方法" format:@"请在你的主类中加上%@",@"viewDidLayoutSubviews"];} \
[self _viewDidLayoutSubviews_##categoryName ]; \
} \
-(void)_viewDidLayoutSubviews_##categoryName  \



#define viewWillLayoutSubviews(categoryName) \
-(void)viewWillLayoutSubviews_##categoryName \
{ if ([self respondsToSelector:@selector(viewWillLayoutSubviews_##categoryName )]) \
[self viewWillLayoutSubviews_##categoryName ]; \
else \
{[NSException raise:@"主类没有重写父类的方法,但是主类的分类扩展了该方法" format:@"请在你的主类中加上%@",@"viewWillLayoutSubviews"];} \
[self _viewWillLayoutSubviews_##categoryName ]; \
} \
-(void)_viewWillLayoutSubviews_##categoryName  \






#endif /* ControllerCategoryOverride_h */

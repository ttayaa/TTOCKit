//
//  UIView+Signal.m
//  elmsc
//
//  Created by apple on 16/8/5.
//  Copyright © 2016年 ttayaa All rights reserved.
//

#import "UIView+Signal.h"
#import "SignalModel.h"
//
//#import "TakeWeakObj.h"
//#import <objc/message.h>
#import <objc/runtime.h>
#import "SignalConfig.h"

#import "UIView+fitview.h"
#import "NSObject+getVarName.h"

//======================用来处理UIcontrol控件的点击 设置初始的事件状态============================
static UIControlEvents UIControlEvent = UIControlEventValueChanged;


@interface UIControl (SignalExt)
@property (strong, nonatomic) NSString * editedEventFlag;
@end


@implementation UIControl (Signal)
-(void)setUIControlEvent:(UIControlEvents)event{
    self.editedEventFlag = @"haveValue";
    
    UIControlEvent = event;
}
@end



@implementation UIControl (SignalExt)
@dynamic editedEventFlag;
-(NSString *)editedEventFlag{
    return objc_getAssociatedObject(self, @selector(editedEventFlag));
}
-(void)setEditedEventFlag:(NSString *)editedEventFlag{
    objc_setAssociatedObject(self, @selector(editedEventFlag), editedEventFlag, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end


//======================用来处理UIcontrol控件的点击 设置初始的事件状态============================

@implementation UIView (Signal)

@dynamic clickSignalName;


-(NSString *)clickSignalName
{
    return objc_getAssociatedObject(self, @selector(clickSignalName));
}


-(void)setClickSignalName:(NSString *)clickSignalName
{
    objc_setAssociatedObject(self, @selector(clickSignalName), clickSignalName, OBJC_ASSOCIATION_COPY_NONATOMIC);
    //处理  UIButton  UISwich开关  UISegmentedControl[1|2]  UIStepper[-|+] UISlider滑块
    if ([self isKindOfClass:[UIControl class]]) {
        UIControl *controlView =(UIControl *)self;
        //如果用户设置事件
        if (controlView.editedEventFlag)
        {   //如果是按钮
            [controlView addTarget:self action:@selector(didEvent:) forControlEvents:UIControlEvent];
            
        }
        //如果用户没有设置那么给默认事件
        else
        {
            if ([self isKindOfClass:[UIButton class]]) {
                [controlView addTarget:self action:@selector(didEvent:) forControlEvents:UIControlEventTouchUpInside];
            }
            else{
                [controlView addTarget:self action:@selector(didEvent:) forControlEvents:UIControlEventValueChanged];
            }
        }
    }
}

#pragma mark - UIControl点击会触发
-(void)didEvent:(UIControl *)uiControl
{
    
    //如果没有自定义信号名字,那么就设置信号名字
    if (!self.clickSignalName) {
        
        //如果它到控制器之前的响应链 没有设置信号
        if (![self SearchNextResponder_ishaveSignal:self]) {
            //设置一个动态的信号名字
            [self DynamicSetSignal:self UIResponder:self];
        }
    }
    
    
    
    //如果当前响应链条没有控制器
    if (![self getSignalCurrentContrller])
        return;
    
    //初始化信号模型
    signalModel.view = self;
    signalModel.argsObj = self.argsObj;
    
    //发送的是cell的通知,那么给信号模型赋值indexPath等关于cell的属性
    if ([self GrandfatherIsTableViewOrCellectionView])
    {
        
        id tbOrCv = [self GetTableViewOrColletionViewFromChildView];
        NSIndexPath * indexPath;
        
        if ([tbOrCv isKindOfClass:[UICollectionView class]]) {
            
            //如果是取到tbview 说明collectionview是添加在tbview里面的
            if ([[self GetCellFromChildView] isKindOfClass:[UITableViewCell class]]) {
                
                signalModel.collectionviewIndexPathArr = [tbOrCv indexPathsForVisibleSupplementaryElementsOfKind:UICollectionElementKindSectionHeader];
                
                signalModel.tableviewIndexPath = [[tbOrCv GetTableViewOrColletionViewFromSupview] indexPathForCell:(UITableViewCell *)[self GetCellFromChildView]];
            }
            
            else if ([[self GetCellFromChildView] isKindOfClass:[UICollectionViewCell class]]) {
                indexPath = [tbOrCv indexPathForCell:(UICollectionViewCell *)[self GetCellFromChildView]];
                
                
                id tb = [tbOrCv GetTableViewOrColletionViewFromSupview];
                if ([tb isKindOfClass:[UITableView class]]) {
                    UITableView *tb1 = tb;
                    
                    id tbcell = [tbOrCv GetTableViewCellOrColletionViewCellFromSupview];
                    //                signalModel.tableviewIndexPath
                    if ([tbcell isKindOfClass:[UITableViewCell class]]) {
                        
                        UITableViewCell *cell = tbcell;
                        signalModel.tableviewIndexPath =  [tb1 indexPathForCell:cell];
                    }
                }
            }
        }
        
        else if ([tbOrCv isKindOfClass:[UITableView class]])
        {
            //如果是取到colletionview 说明tableview是添加在colletionview里面的
            //tableview比较特殊无法通过头获取 indexpath  ， 还是绑定tag吧
            if ([[self GetCellFromChildView] isKindOfClass:[UICollectionViewCell class]]) {
                
                signalModel.tableviewIndexPath = nil;
                
                signalModel.collectionviewIndexPath = [[tbOrCv GetTableViewOrColletionViewFromSupview] indexPathForCell:(UICollectionViewCell *)[self GetCellFromChildView]];
            }
            
            if ([[self GetCellFromChildView] isKindOfClass:[UITableViewCell class]]) {
                
                signalModel.tableViewCell =(UITableViewCell *)[self GetCellFromChildView];
                
                indexPath = [tbOrCv indexPathForCell:signalModel.tableViewCell];
                
            }
            
            // 取消tableview选状态
            [tbOrCv deselectRowAtIndexPath:indexPath animated:NO];
            
        }
        
        
        signalModel.targetView = tbOrCv;
        
        signalModel.indexPath = indexPath;

        
    }
    
    
    
    SEL sel = NSSelectorFromString(SEL_signal);
    
    _Pragma("clang diagnostic push")
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
    
    if ([[self getSignalCurrentContrller] respondsToSelector:sel]) {
        [[self getSignalCurrentContrller] performSelector:sel withObject:signalModel];
       
    }
    _Pragma("clang diagnostic pop")
    
    //     objc_msgSend([self getSignalCurrentContrller],sel,signalModel);
    
}

#pragma mark - 初始化
//用于找到合适的uiview(如果控制器没有实现这个方法合适也没有用)
static NSHashTable *ObserverHashTable;


+(void)load
{
    //哈希表使用弱指针(唯一性)
    //用于存放弱引用的控制器
    //否则无法释放控制器
    ObserverHashTable = [NSHashTable weakObjectsHashTable];
    
    
    //存放事件和view
    signalModel =[SignalModel new];
}





static SignalModel *signalModel;

#pragma mark - Cell的子控件处理相关
//如果是Tableview和CollectionView 就不使用Signal机制, 直接向下传递事件
-(BOOL)GrandfatherIsTableViewOrCellectionView{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UITableView class]]||[next isKindOfClass:[UICollectionView class]]) {
            return YES;
        }
        next = [next nextResponder];
    } while (next != nil);
    return NO;
}

//获取cell中当前控件的TableView或者ColletionView
-(UIResponder *)GetTableViewOrColletionViewFromChildView{
    
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UITableView class]]||[next isKindOfClass:[UICollectionView class]]) {
            return next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

//获取cell中当前控件的TableViewCell或者ColletionViewCell
-(UIResponder *)GetCellFromChildView{
    
    if ([self isKindOfClass:[UITableViewCell class]]||[self isKindOfClass:[UICollectionViewCell class]]) {
        return self;
    }
    
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UITableViewCell class]]||[next isKindOfClass:[UICollectionViewCell class]]) {
            return next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}


-(id)GetTableViewOrColletionViewFromSupview
{
    UIView *superview = self.superview;
    do {
        if ([superview isKindOfClass:[UITableView class]]||[superview isKindOfClass:[UICollectionView class]]) {
            return superview;
        }
        superview = superview.superview;
    } while (superview != nil);
    return nil;
    
}

-(id)GetTableViewCellOrColletionViewCellFromSupview
{
    UIView *superview = self.superview;
    do {
        if ([superview isKindOfClass:[UITableViewCell class]]||[superview isKindOfClass:[UICollectionViewCell class]]) {
            return superview;
        }
        superview = superview.superview;
    } while (superview != nil);
    return nil;
    
}



-(BOOL)SearchNextResponder_ishaveSignal:(UIResponder *)responder
{
    UIResponder *next = [responder nextResponder];
    
    
    if ([next isKindOfClass:[UIApplication class]]) {
        return NO;
    }
    
    
    if (![next isKindOfClass:[UIViewController class]]) {
        
        UIView *view = (UIView *)next;
        
        //        if (view.clickSignalName&&![[view nextResponder] isKindOfClass:[UITableViewCell class]]&&![[view nextResponder] isKindOfClass:[UICollectionViewCell class]]) {
        //
        //            return YES;
        //        }
        if (view.clickSignalName) {
            
            return YES;
        }
        
        else
        {
            [self SearchNextResponder_ishaveSignal:next];
        }
        
    }
    else
    {
        return NO;
    }
    
    return NO;
}




-(void)DynamicSetSignal:(UIView *)view UIResponder:(UIResponder *)responder
{
    
    if ([view isKindOfClass:[UITableViewCell class]]||[view isKindOfClass:[UICollectionViewCell class]]) {
        view.clickSignalName = NSStringFromClass([view class]);
        view.IsDynamicSignal = YES;
        return;
    }
    
    //如果不是控制器
    if (![responder isKindOfClass:[UIViewController class]]) {
        //尝试设置获取信号名字
        NSString *tempStr1 = [[responder nameWithInstance:view] substringFromIndex:1];
        if (tempStr1) {
            
            [view setClickSignalName:tempStr1];
            view.IsDynamicSignal = YES;
        }
        else
        {
            [view DynamicSetSignal:view UIResponder:[responder nextResponder]];
            
        }
    }
    
    else//是控制器
    {
        //尝试设置获取信号名字
        NSString *tempStr1 = [[responder nameWithInstance:view] substringFromIndex:1];
        if (tempStr1) {
            [view setClickSignalName:tempStr1];
            view.IsDynamicSignal = YES;
        }
        
        return;
    }
    
    
}


-(void)searchVcHaveSignalmethod:(UIResponder *)responder
{
    UIResponder *next = [responder nextResponder];
    
    if ([next isKindOfClass:[UIViewController class]]) {
        
        return;
    }
    
    if ([next isKindOfClass:[UIApplication class]]) {
        
        return;
    }
    
    
    UIView * view =(UIView *)next;
    
    //如果没有自定义信号名字,那么就设置信号名字
    if (!view.clickSignalName) {
        //如果它到控制器之前的响应链 没有设置信号
        if (![view SearchNextResponder_ishaveSignal:view]) {
            //设置一个动态的信号名字
            [view DynamicSetSignal:view UIResponder:view];
        }
    }
    
    else
    {
        return;
    }
    
    
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"haveSignal_%@:",view.clickSignalName]);
    
    if (![[view getSignalCurrentContrller] respondsToSelector:sel]) {
        [view searchVcHaveSignalmethod:next];
    }
    else
    {
        
        //只有设置了信号的才往下传递
        if(!view.clickSignalName)
        {
            return;
        }
        
        
        //创建信号模型
        signalModel.view = view;
        
        signalModel.argsObj = view.argsObj;
        
        
        //发送的是cell的通知,那么给信号模型赋值indexPath等关于cell的属性
        if ([view GrandfatherIsTableViewOrCellectionView])
        {
            
            id tbOrCv = [view GetTableViewOrColletionViewFromChildView];
            NSIndexPath * indexPath;
            
            if ([tbOrCv isKindOfClass:[UICollectionView class]]) {
                
                //如果是取到tbview 说明collectionview是添加在tbview里面的
                if ([[view GetCellFromChildView] isKindOfClass:[UITableViewCell class]]) {
                    
                    signalModel.collectionviewIndexPathArr = [tbOrCv indexPathsForVisibleSupplementaryElementsOfKind:UICollectionElementKindSectionHeader];
                    
                    signalModel.tableviewIndexPath = [[tbOrCv GetTableViewOrColletionViewFromSupview] indexPathForCell:(UITableViewCell *)[view GetCellFromChildView]];
                }
                
                else if ([[view GetCellFromChildView] isKindOfClass:[UICollectionViewCell class]]) {
                    indexPath = [tbOrCv indexPathForCell:(UICollectionViewCell *)[view GetCellFromChildView]];
                    
                    
                    id tb = [tbOrCv GetTableViewOrColletionViewFromSupview];
                    if ([tb isKindOfClass:[UITableView class]]) {
                        UITableView *tb1 = tb;
                        
                        id tbcell = [tbOrCv GetTableViewCellOrColletionViewCellFromSupview];
                        //                signalModel.tableviewIndexPath
                        if ([tbcell isKindOfClass:[UITableViewCell class]]) {
                            
                            UITableViewCell *cell = tbcell;
                            signalModel.tableviewIndexPath =  [tb1 indexPathForCell:cell];
                        }
                    }
                    
                    
                    
                }
            }
            
            else if ([tbOrCv isKindOfClass:[UITableView class]])
            {
                
                //如果是取到colletionview 说明tableview是添加在colletionview里面的
                //tableview比较特殊无法通过头获取 indexpath  ， 还是绑定tag吧
                if ([[view GetCellFromChildView] isKindOfClass:[UICollectionViewCell class]]) {
                    
                    signalModel.tableviewIndexPath = nil;
                    
                    signalModel.collectionviewIndexPath = [[tbOrCv GetTableViewOrColletionViewFromSupview] indexPathForCell:(UICollectionViewCell *)[view GetCellFromChildView]];
                }
                
                if ([[view GetCellFromChildView] isKindOfClass:[UITableViewCell class]]) {
                    signalModel.tableViewCell =(UITableViewCell *)[self GetCellFromChildView];
                    
                    indexPath = [tbOrCv indexPathForCell:signalModel.tableViewCell];
                    
                }
                
                // 取消tableview选状态
                [tbOrCv deselectRowAtIndexPath:indexPath animated:NO];
                
            }
            
            signalModel.targetView = tbOrCv;
            signalModel.indexPath = indexPath;
            
        }
        
        
        
        //让所有view的touch系列方法都有排斥性
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            [[UIView appearance] setExclusiveTouch:YES];
            
        });
        
        
        SEL sel = NSSelectorFromString([NSString stringWithFormat:@"haveSignal_%@:",view.clickSignalName]);
        _Pragma("clang diagnostic push")
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
        if ([[view getSignalCurrentContrller] respondsToSelector:sel]) {
            [[view getSignalCurrentContrller] performSelector:sel withObject:signalModel];
            [ObserverHashTable removeAllObjects];
        }
        _Pragma("clang diagnostic pop")
        
        
    }
    
    
}


//@dynamic IsDynamicSignal;
-(BOOL)IsDynamicSignal
{
    return [objc_getAssociatedObject(self, @selector(IsDynamicSignal)) boolValue] ;
}


-(void)setIsDynamicSignal:(BOOL)IsDynamicSignal
{
    objc_setAssociatedObject(self, @selector(IsDynamicSignal), @(IsDynamicSignal), OBJC_ASSOCIATION_RETAIN);
}





#pragma mark - UIControl以外的控件点击会触发(模拟实现了touchupinside功能)
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.IsDynamicSignal) {
        self.clickSignalName = nil;
    }
    
    [ObserverHashTable addObject:self];
    //    //必须要加上 不然如果是普通的view 事件无法传递
    //    //比如小键盘的中文UIKeyboardCandidateBarCell 选择的时候会选择不到文字
    [super touchesEnded:touches withEvent:event];
    
    [ObserverHashTable removeObject:self];
    
    
    
    if (!self.clickSignalName) {
        
        if (ObserverHashTable.count!=0) {
            return;
        }
    }
    
    
    //如果没有自定义信号名字,那么就设置信号名字
    if (!self.clickSignalName) {
        
        
        if ([self isKindOfClass:[UIWindow class]]||[[self nextResponder] isKindOfClass:[UIWindow class]]) {
            return ;
        }
        
        //如果它到控制器之前的响应链 没有设置信号
        if (![self SearchNextResponder_ishaveSignal:self]) {
            //设置一个动态的信号名字
            [self DynamicSetSignal:self UIResponder:self];
        }
    }
    
    
    SEL sel1 = NSSelectorFromString(SEL_signal);
    
    _Pragma("clang diagnostic push")
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
    //如果控制器没有实现该信号方法,那么返回
    if (![[self getSignalCurrentContrller] respondsToSelector:sel1]) {
        
        [self searchVcHaveSignalmethod:self];
        return;
        
    }
    _Pragma("clang diagnostic pop")
    
    
    
    
    
    
    //除了UIcontrol控件的其他控件,当手指离开控件就不做处理
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    if ([self pointInside:point withEvent:event] == NO)
    {
        return;
    }
    //    //设置点击的view是谁
    //    if (self.FitFlag) {
    //        signalModel.clickView = self;
    //    }
    //
    
    //只有设置了信号的才往下传递
    if(!self.clickSignalName)
    {
        return;
    }
    
    
    //创建信号模型
    signalModel.view = self;
    signalModel.touches = touches;
    signalModel.argsObj = self.argsObj;
    
    
    //发送的是cell的通知,那么给信号模型赋值indexPath等关于cell的属性
    if ([self GrandfatherIsTableViewOrCellectionView])
    {
        
        id tbOrCv = [self GetTableViewOrColletionViewFromChildView];
        NSIndexPath * indexPath;
        
        if ([tbOrCv isKindOfClass:[UICollectionView class]]) {
            
            //如果是取到tbview 说明collectionview是添加在tbview里面的
            if ([[self GetCellFromChildView] isKindOfClass:[UITableViewCell class]]) {
                
                signalModel.collectionviewIndexPathArr = [tbOrCv indexPathsForVisibleSupplementaryElementsOfKind:UICollectionElementKindSectionHeader];
                
                signalModel.tableviewIndexPath = [[tbOrCv GetTableViewOrColletionViewFromSupview] indexPathForCell:(UITableViewCell *)[self GetCellFromChildView]];
            }
            
            else if ([[self GetCellFromChildView] isKindOfClass:[UICollectionViewCell class]]) {
                indexPath = [tbOrCv indexPathForCell:(UICollectionViewCell *)[self GetCellFromChildView]];
                
                
                id tb = [tbOrCv GetTableViewOrColletionViewFromSupview];
                if ([tb isKindOfClass:[UITableView class]]) {
                    UITableView *tb1 = tb;
                    
                    id tbcell = [tbOrCv GetTableViewCellOrColletionViewCellFromSupview];
                    //                signalModel.tableviewIndexPath
                    if ([tbcell isKindOfClass:[UITableViewCell class]]) {
                        
                        UITableViewCell *cell = tbcell;
                        signalModel.tableviewIndexPath =  [tb1 indexPathForCell:cell];
                    }
                }
                
                
                
            }
        }
        
        else if ([tbOrCv isKindOfClass:[UITableView class]])
        {
            
            //如果是取到colletionview 说明tableview是添加在colletionview里面的
            //tableview比较特殊无法通过头获取 indexpath  ， 还是绑定tag吧
            if ([[self GetCellFromChildView] isKindOfClass:[UICollectionViewCell class]]) {
                
                signalModel.tableviewIndexPath = nil;
                
                signalModel.collectionviewIndexPath = [[tbOrCv GetTableViewOrColletionViewFromSupview] indexPathForCell:(UICollectionViewCell *)[self GetCellFromChildView]];
            }
            
            if ([[self GetCellFromChildView] isKindOfClass:[UITableViewCell class]]) {
                signalModel.tableViewCell =(UITableViewCell *)[self GetCellFromChildView];
                
                indexPath = [tbOrCv indexPathForCell:signalModel.tableViewCell];
            }
            
            // 取消tableview选状态
            [tbOrCv deselectRowAtIndexPath:indexPath animated:NO];
            
        }
        
        signalModel.targetView = tbOrCv;
        signalModel.indexPath = indexPath;
        
    }
    
    
    
    //让所有view的touch系列方法都有排斥性
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [[UIView appearance] setExclusiveTouch:YES];
        
    });
    
    
    
    SEL sel = NSSelectorFromString(SEL_signal);
    
    _Pragma("clang diagnostic push")
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
    
    if ([[self getSignalCurrentContrller] respondsToSelector:sel]) {
        [[self getSignalCurrentContrller] performSelector:sel withObject:signalModel];
        [ObserverHashTable removeAllObjects];
    }
    _Pragma("clang diagnostic pop")
    
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    [ObserverHashTable addObject:self];
    
    [super touchesBegan:touches withEvent:event];
    
    //清空小键盘(选择文字)的信号
    //和清空一些使用系统cell
    if ([self.clickSignalName isEqualToString: @"UIKeyboardCandidateBarCell"]||
        [self.clickSignalName isEqualToString: @"PUPhotosGridCell"])
    {
        self.clickSignalName = nil;
    }
    
    if (self.clickSignalName) {
        return;
    }
    
}


//======================扩展了一个参数============================

-(NSObject *)argsObj
{
    return objc_getAssociatedObject(self, @selector(argsObj));
}

-(void)setArgsObj:(NSObject *)argsObj
{
    objc_setAssociatedObject(self, @selector(argsObj), argsObj, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)setClickSignalName:(NSString *)clickSignalName withObject:(id)argsObj
{
    [self setClickSignalName:clickSignalName];
    
    self.argsObj = argsObj;
}


//=====扩展了属性指定 weak包装响应信号的对象(缓存响应的对象)====================
@dynamic clickSignalRespondToController;

-(UIViewController *)clickSignalRespondToController
{
    return self.take_a_WeakValue_Obj.weakSignalVc;
}

-(void)setClickSignalRespondToController:(UIViewController *)clickSignalRespondToController
{
    //懒加载对象
    if (!self.take_a_WeakValue_Obj) {
        self.take_a_WeakValue_Obj = [TakeWeakObj new];
    }
    self.take_a_WeakValue_Obj.weakSignalVc = clickSignalRespondToController;
}

//包装一个弱指针控制器
-(TakeWeakObj *)take_a_WeakValue_Obj
{
    return objc_getAssociatedObject(self, @selector(take_a_WeakValue_Obj));
}

-(void)setTake_a_WeakValue_Obj:(TakeWeakObj *)take_a_WeakValue_Obj
{
    objc_setAssociatedObject(self, @selector(take_a_WeakValue_Obj), take_a_WeakValue_Obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/** 获取当前View的控制器对象 并判断 有没有设置clickSignalRespondToClass属性 */
-(UIViewController *)getSignalCurrentContrller{
    
    //先判断自己是不是设置了
    
    if (self.take_a_WeakValue_Obj.weakSignalVc) {
        return  self.take_a_WeakValue_Obj.weakSignalVc;
    }
    
    //在判断自己的下个响应者开始
    UIResponder *next = [self nextResponder];
    do {
        //如果有这个方法,说明是view不是控制器, 控制器也是响应者
        if ([next respondsToSelector:@selector(clickSignalRespondToController)]) {
            UIView *view = (UIView *)next;
            //并且clickSignalRespondToController设置了值
            if (view.clickSignalRespondToController) {
                self.clickSignalRespondToController = view.clickSignalRespondToController;
                return  view.clickSignalRespondToController;
            }
        }
        
        if ([next isKindOfClass:[UIViewController class]]) {
            
            self.clickSignalRespondToController = (UIViewController *)next;
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}



@end




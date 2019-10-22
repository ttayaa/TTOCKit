//
//  UIView+TTSignal.m
//  testproject
//
//  Created by apple on 2018/4/10.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import "UIView+TTSignal.h"
#import <objc/message.h>



@interface TTSignalWeakProperty : NSObject

@property (strong, nonatomic) NSString *clickSignalName;

@property (weak, nonatomic) UIResponder *targetResponder;
@property (weak, nonatomic) UIViewController *TTSignal_viewController;
@property (weak, nonatomic) UITableViewCell *TableViewCell;
@property (weak, nonatomic) UICollectionViewCell *CollectionViewCell;
@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) NSIndexPath *indexPath;


@property (nonatomic,copy)UIView *(^setSignalName)(NSString * signalName);

@property (nonatomic,copy)UIView *(^enforceTarget)(NSObject *target);


@property (nonatomic,weak)NSObject *targetObject;
@end
@implementation TTSignalWeakProperty

@end





static NSString const * havedSignal = @"TTSignal_";

@interface UIView ()

//@property (nonatomic,weak)NSObject *targetObject;

@end
@implementation UIView (TTSignal)


-(void)setClickSignalName:(NSString *)clickSignalName{
    
    self.WeakProperty.clickSignalName = clickSignalName;
    self.userInteractionEnabled = YES;
}

-(NSString *)clickSignalName{
    return self.WeakProperty.clickSignalName;
}


-(NSIndexPath *)indexPath{
    return self.WeakProperty.indexPath;
}

-(UITableViewCell *)TableViewCell{
    return self.WeakProperty.TableViewCell;
}

-(UICollectionViewCell *)CollectionViewCell{
    return self.WeakProperty.CollectionViewCell;
}

-(UITableView *)tableView{
    return self.WeakProperty.tableView;
}

-(UICollectionView *)collectionView{
    return self.WeakProperty.collectionView;
}

-(UIViewController *)TTSignal_viewController{
    return self.WeakProperty.TTSignal_viewController;
    
}



#pragma mark -signal name
-(UIView *(^)(NSString *))setSignalName{
    
    __weak typeof(self)weakSelf = self;
    return ^(NSString *signalName){
        weakSelf.clickSignalName = signalName;
        return weakSelf;
    };
}

-(void)setSetSignalName:(UIView *(^)(NSString *))setSignalName{
    self.WeakProperty.setSignalName = setSignalName;
}

#pragma mark enforce -target
-(UIView *(^)(NSObject *))enforceTarget{
    
    __weak typeof(self)weakSelf = self;
    return ^(NSObject * target){
        __weak typeof(target)weakTarget = target;
        weakSelf.WeakProperty.targetObject = weakTarget;
        return weakSelf;
    };
}

-(void)setEnforceTarget:(UIView *(^)(NSObject *))enforceTarget{
    self.WeakProperty.enforceTarget = enforceTarget;
}


-(TTSignalWeakProperty *)WeakProperty{
    
    TTSignalWeakProperty *WeakProperty = objc_getAssociatedObject(self, @selector(WeakProperty));
    if (!WeakProperty) {
        WeakProperty = [TTSignalWeakProperty new];
        objc_setAssociatedObject(self, @selector(WeakProperty), WeakProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return WeakProperty;
    
}


#pragma mark- touch events handler
-(void)TTtouchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.clickSignalName.length>0) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        if ([self pointInside:point withEvent:event]) {
            [self sendSignal];
        }
        
    }else{
        
    }
    
}

//-(BOOL)isImplementation:(SEL)selector
//{
//    BOOL result = NO;
//
//    uint count;
//    Method *list = class_copyMethodList([self class], &count);
//
//    // Find and call original method .
//    for ( int i = count - 1 ; i >= 0; i--) {
//        Method method = list[i];
//        SEL name = method_getName(method);
//                NSLog(@"%@",NSStringFromSelector(name));
//        IMP imp = method_getImplementation(method);
//        if (name == selector) {
//
//            result = YES;
////            ((id(*)(id, SEL, NSSet<UITouch *> *, UIEvent *))imp)(target, name, parms1, parms2);
//
//            break;
//        }
//    }
//    free(list);
//
//    return result;
//}


//检测对象是否有该属性,有就返回该属性的名字
-(NSString *)nameWithInstance:(id)instance target:(UIResponder *)target{
    unsigned int numIvars = 0;
    NSString *key=nil;
    Ivar * ivars = class_copyIvarList([target class], &numIvars);
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        const char *type = ivar_getTypeEncoding(thisIvar);
        NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        if (![stringType hasPrefix:@"@"] || ![object_getIvar(target, thisIvar) isKindOfClass:[UIView class]]) {
            continue;
        }
        
        if ((object_getIvar(target, thisIvar) == instance)) {
            key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
            break;
        }else{
            key = @"";
        }
    }
    free(ivars);
    return key;
    
}


-(NSString *)dymaicSignalName{
    
    NSString *oldName = self.clickSignalName;
    
    //分析他的层级关系
    UIResponder *nextResponder = self.nextResponder;
    
    //view到离他最近的控制器之间
    //    //如果存在cellname 说明之间有cell
    //    NSString * cellname = @"";
    //如果存在signalName 如果到控制器之前有一个父控件有这个属性
    NSString * signalName = @"";
    
    while (nextResponder != nil) {
        
        if ([nextResponder isKindOfClass:[UIWindow class]]) {
            return @"";
        }
        
        //如果检测到是cell 并且cellname没有设置(因为这里可能出现tableview嵌套的情况)  ,记录cellname
        if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
            
            //
            //记录当前控件的cell和indexpath
            UITableViewCell *cell = (UITableViewCell *)nextResponder;
            self.WeakProperty.TableViewCell = cell;
            //帮cell记录名字
            cell.clickSignalName = NSStringFromClass(nextResponder.class);
            cell.WeakProperty.TableViewCell = cell;
            
            if (@available(iOS 11.0, *)) {
                UITableView *tableView = (UITableView *)cell.superview;
                self.WeakProperty.indexPath = [tableView indexPathForCell:cell];
                self.WeakProperty.tableView = tableView;

            }else{
                UITableView *tableView = (UITableView *)cell.superview.superview;
                self.WeakProperty.indexPath = [tableView indexPathForCell:cell];
                self.WeakProperty.tableView = tableView;

            }
            self.WeakProperty.TableViewCell.WeakProperty.indexPath = self.WeakProperty.indexPath;
            self.WeakProperty.TableViewCell.WeakProperty.tableView = self.WeakProperty.tableView;

            
        }
        
        //如果检测到是cell 并且cellname没有设置(因为这里可能出现CollectionView嵌套的情况)  ,记录cellname
        if ([nextResponder isKindOfClass:[UICollectionViewCell class]]) {
            
            
            //记录当前控件的cell和indexpath
            UICollectionViewCell *cell = (UICollectionViewCell *)nextResponder;
            self.WeakProperty.CollectionViewCell = cell;
            //帮cell记录名字
            cell.clickSignalName = NSStringFromClass(nextResponder.class);
            cell.WeakProperty.CollectionViewCell = cell;
            if (@available(iOS 11.0, *)) {
                UICollectionView *collectionView = (UICollectionView *)cell.superview;
                self.WeakProperty.indexPath = [collectionView indexPathForCell:cell];
                self.WeakProperty.collectionView = collectionView;
            }else{
                UICollectionView *collectionView = (UICollectionView *)cell.superview.superview;
                self.WeakProperty.indexPath = [collectionView indexPathForCell:cell];
                self.WeakProperty.collectionView = collectionView;
            }
            self.WeakProperty.CollectionViewCell.WeakProperty.indexPath = self.WeakProperty.indexPath;
            self.WeakProperty.CollectionViewCell.WeakProperty.collectionView = self.WeakProperty.collectionView;

        }
        
        
        //尝试获取名字
        NSString *tempname = [self nameWithInstance:self target:nextResponder];
        
        if (tempname.length > 0) {
            //设置名字成功
            signalName = [tempname substringFromIndex:1];
            
            //记录当前有属性的View
            self.WeakProperty.targetResponder = nextResponder;
        }
        
        
        
        
        //如果检测到控制器或者UIWindow,那么判断
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            
            self.WeakProperty.TTSignal_viewController = (UIViewController *)nextResponder;
            
            self.WeakProperty.TableViewCell.WeakProperty.TTSignal_viewController = (UIViewController *)nextResponder;
            
            self.WeakProperty.CollectionViewCell.WeakProperty.TTSignal_viewController = (UIViewController *)nextResponder;
            
            
            //结束循环
            break;
        }
        if ([nextResponder isKindOfClass:[UIWindow class]]) {
            //结束循环
            break;
        }
        
        
        nextResponder = nextResponder.nextResponder;
        
    }
    
    //分析结果
    
    //如果用户设置了名字那么就不需要动态名字
    if (oldName.length>0) {
        return oldName;
    }
    else{
        
        if (self.WeakProperty.TableViewCell||self.WeakProperty.CollectionViewCell) {
              NSString * setStr = [NSString stringWithFormat:@"%@:",[havedSignal stringByAppendingString:self.WeakProperty.TableViewCell?self.WeakProperty.TableViewCell.clickSignalName:self.WeakProperty.CollectionViewCell.clickSignalName]];
            SEL selctor = NSSelectorFromString(setStr);
            
            if ([self.WeakProperty.targetObject respondsToSelector:selctor]||[self.WeakProperty.TTSignal_viewController respondsToSelector:selctor]) {
                return nil;
            }
            else
            {
                return signalName;
            }
        }
        else
        {
            return signalName;
        }
    }
    //什么名字都没有
    return @"";
    
}

//send action to target(viewController)
-(void)sendSignal{
    
    void(*action)(id,SEL,id) = (void(*)(id,SEL,id))objc_msgSend;
    
    NSString * setStr = [NSString stringWithFormat:@"%@:",[havedSignal stringByAppendingString:self.clickSignalName]];
    
    
    SEL selctor = NSSelectorFromString(setStr);
    
    //1,优先判断有没有targetObject
    if ([self.WeakProperty.targetObject respondsToSelector:selctor]) {
        action(self.WeakProperty.targetObject,selctor,self);
        return;
    }
    
    //优先在属性持有者中调用(属性持有者有可能是控制器)
    if ([self.WeakProperty.targetResponder respondsToSelector:selctor]) {
        action(self.WeakProperty.targetResponder,selctor,self);
        return;
    }
    
    if ([self.WeakProperty.TTSignal_viewController respondsToSelector:selctor]) {
        action(self.WeakProperty.TTSignal_viewController,selctor,self);
        return;
    }
    
}

@end


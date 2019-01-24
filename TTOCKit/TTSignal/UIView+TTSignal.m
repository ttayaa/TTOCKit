//
//  UIView+TTSignal.m
//  testproject
//
//  Created by apple on 2018/4/10.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import "UIView+TTSignal.h"
#import <objc/message.h>

static NSString const * havedSignal = @"TTSignal_";

@interface UIView ()

@property (nonatomic,weak)NSObject *targetObject;
@end
@implementation UIView (TTSignal)


-(void)setClickSignalName:(NSString *)clickSignalName{
    
    
    objc_setAssociatedObject(self, @selector(clickSignalName), clickSignalName, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.userInteractionEnabled = YES;
}

-(NSString *)clickSignalName{
    
    return objc_getAssociatedObject(self, @selector(clickSignalName));
}




-(void)setIndexPath:(NSIndexPath *)indexPath{
    
    objc_setAssociatedObject(self, @selector(indexPath), indexPath, OBJC_ASSOCIATION_ASSIGN);
}


-(NSIndexPath *)indexPath{
    
    return objc_getAssociatedObject(self, @selector(indexPath));
}


-(void)setTableViewCell:(UITableViewCell *)TableViewCell{
    objc_setAssociatedObject(self, @selector(TableViewCell), TableViewCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UITableViewCell *)TableViewCell{
    return objc_getAssociatedObject(self, @selector(TableViewCell));
}
-(void)setCollectionViewCell:(UICollectionViewCell *)CollectionViewCell{
    objc_setAssociatedObject(self, @selector(CollectionViewCell), CollectionViewCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UICollectionViewCell *)CollectionViewCell{
    return objc_getAssociatedObject(self, @selector(CollectionViewCell));
}

-(void)setTableView:(UITableView *)tableView{
    objc_setAssociatedObject(self, @selector(tableView), tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UITableViewCell *)tableView{
    return objc_getAssociatedObject(self, @selector(tableView));
}
-(void)setCollectionView:(UICollectionView *)collectionView{
    objc_setAssociatedObject(self, @selector(collectionView), collectionView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UICollectionViewCell *)collectionView{
    return objc_getAssociatedObject(self, @selector(collectionView));
}
-(void)setViewController:(UIViewController *)viewController{
    objc_setAssociatedObject(self, @selector(viewController), viewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIViewController *)viewController{
    return objc_getAssociatedObject(self, @selector(viewController));
}


#pragma -mark the task in execution with targetObject
-(void)setTargetObject:(NSObject *)targetObject{
    
    objc_setAssociatedObject(self, @selector(targetObject), targetObject, OBJC_ASSOCIATION_ASSIGN);
}

-(NSObject *)targetObject{
    
    return objc_getAssociatedObject(self, @selector(targetObject));
}


-(void)setTargetResponder:(UIResponder *)targetResponder{
    
    objc_setAssociatedObject(self, @selector(targetResponder), targetResponder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIResponder *)targetResponder{
    
    return objc_getAssociatedObject(self, @selector(targetResponder));
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
    
    objc_setAssociatedObject(self, @selector(setSetSignalName:), setSignalName, OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark enforce -target
-(UIView *(^)(NSObject *))enforceTarget{
    
    __weak typeof(self)weakSelf = self;
    return ^(NSObject * target){
        __weak typeof(target)weakTarget = target;
        weakSelf.targetObject = weakTarget;
        return weakSelf;
    };
}

-(void)setEnforceTarget:(UIView *(^)(NSObject *))enforceTarget{
    
    objc_setAssociatedObject(self, @selector(enforceTarget), enforceTarget, OBJC_ASSOCIATION_ASSIGN);
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
            self.TableViewCell = cell;
            //帮cell记录名字
            cell.clickSignalName = NSStringFromClass(nextResponder.class);
            cell.TableViewCell = cell;
            
            if (@available(iOS 11.0, *)) {
                UITableView *tableView = (UITableView *)cell.superview;
                self.indexPath = [tableView indexPathForCell:cell];
                self.tableView = tableView;
            }else{
                UITableView *tableView = (UITableView *)cell.superview.superview;
                self.indexPath = [tableView indexPathForCell:cell];
                self.tableView = tableView;
                
            }
            
        }
        
        //如果检测到是cell 并且cellname没有设置(因为这里可能出现CollectionView嵌套的情况)  ,记录cellname
        if ([nextResponder isKindOfClass:[UICollectionViewCell class]]) {
            
            
            //记录当前控件的cell和indexpath
            UICollectionViewCell *cell = (UICollectionViewCell *)nextResponder;
            self.CollectionViewCell = cell;
            //帮cell记录名字
            cell.clickSignalName = NSStringFromClass(nextResponder.class);
            cell.CollectionViewCell = cell;
            if (@available(iOS 11.0, *)) {
                UICollectionView *collectionView = (UICollectionView *)cell.superview;
                self.indexPath = [collectionView indexPathForCell:cell];
                self.collectionView = collectionView;
            }else{
                UICollectionView *collectionView = (UICollectionView *)cell.superview.superview;
                self.indexPath = [collectionView indexPathForCell:cell];
                self.collectionView = collectionView;
            }
            
        }
        
        
        //尝试获取名字
       NSString *tempname = [self nameWithInstance:self target:nextResponder];
        
        if (tempname.length > 0) {
            //设置名字成功
            signalName = [tempname substringFromIndex:1];
            
            //记录当前有属性的View
            self.targetResponder = nextResponder;
        }
        
        
        
        
        //如果检测到控制器或者UIWindow,那么判断
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            self.viewController = (UIViewController *)nextResponder;
            self.TableViewCell.viewController = (UIViewController *)nextResponder;
            self.CollectionViewCell.viewController = (UIViewController *)nextResponder;

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
 
        if (self.TableViewCell||self.CollectionViewCell) {
            NSString * setStr = [NSString stringWithFormat:@"%@:",[havedSignal stringByAppendingString:self.TableViewCell?self.TableViewCell.clickSignalName:self.CollectionViewCell.clickSignalName]];
            SEL selctor = NSSelectorFromString(setStr);
            if ([self.targetObject respondsToSelector:selctor]||[self.viewController respondsToSelector:selctor]) {
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
    if ([self.targetObject respondsToSelector:selctor]) {
        action(self.targetObject,selctor,self);
        return;
    }
    
    //优先在属性持有者中调用(属性持有者有可能是控制器)
    if ([self.targetResponder respondsToSelector:selctor]) {
        action(self.targetResponder,selctor,self);
        return;
    }

    if ([self.viewController respondsToSelector:selctor]) {
        action(self.viewController,selctor,self);
        return;
    }
    
}

@end

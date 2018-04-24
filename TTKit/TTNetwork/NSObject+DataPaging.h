//
//  NSObject+DataPaging.h
//  DragonB
//
//  Created by apple on 2018/1/16.
//  Copyright © 2018年 ttayaa. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "NetDataModel.h"


/** simple:
 
 
 
 
 
 */



@interface NSObject (DataPaging)

typedef void (^arrKeyBlock)(NetDataModel *model);


@property (strong, nonatomic) NetDataModel * ttReflashModel;
@property (strong, nonatomic) NSNumber *ttRefleshPage;

@property (strong, nonatomic) NSString *ttReflashPageKey;


//默认值是@"page"
-(void)configurePageKey:(NSString *)pagekey;

-(void)HeadLoad:(NSString *)URLString ParmsBlock:(NetWorkParmsBlock)parmsBlock reflashScrollView:(UIScrollView *)scrollView arrKeyBlock:(arrKeyBlock)arrKeyBlock;

-(void)FootLoad:(NSString *)URLString ParmsBlock:(NetWorkParmsBlock)parmsBlock reflashScrollView:(UIScrollView *)scrollView arrKeyBlock:(arrKeyBlock)arrKeyBlock;

@end

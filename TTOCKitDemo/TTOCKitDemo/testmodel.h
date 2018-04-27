//
//  testmodel.h
//  testproject
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 ttayaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetDataModel.h"

@interface testmodel : NetDataModel

NetDataModelOverride(testmodel)

@property (strong, nonatomic) NSString *messageType;
@property (strong, nonatomic) NSString *read;

@property (strong, nonatomic) NSString *login;
@property (strong, nonatomic) NSString *password;

#pragma mark - ---- 公用属性 ----
/** <#what is this#>*/
@property (assign,nonatomic) BOOL isSelected;




@property (copy, nonatomic) NSString * status;
@property (strong, nonatomic) NSString *message;

@property (strong, nonatomic) NSString *currency_id;
@property (strong, nonatomic) NSString *currency_mark;
@property (strong, nonatomic) NSString *currency_sort_name;
@property (strong, nonatomic) NSString *currency_trade_id;
@property (strong, nonatomic) NSString *currency_trade_mark;
@property (assign, nonatomic) CGFloat New_price;
@property (strong, nonatomic) NSString *trade_num_24h;
@property (strong, nonatomic) NSString *change_24h;
@property (strong, nonatomic) NSString *max_24h;
@property (strong, nonatomic) NSString *min_24h;
@property (strong, nonatomic) NSString *price_24h;



@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSMutableArray <testmodel *>*quotes;

@property (strong, nonatomic) testmodel *entrustment;
@property (strong, nonatomic) NSMutableArray <testmodel *>*bids;
@property (strong, nonatomic) NSMutableArray <testmodel *>*asks;
@property (assign, nonatomic) CGFloat num;
@property (assign, nonatomic) CGFloat price;
@property (strong, nonatomic) NSString *invite_code;

@property (strong, nonatomic) NSMutableArray <testmodel *>*assets;
@property (strong, nonatomic) NSString *currency;
@property (assign, nonatomic) CGFloat forzen_num;
@property (strong, nonatomic) NSString *totalAssets;

#pragma mark - ---- 自定义属性 ----
@property (strong, nonatomic) NSString *cname;//自定义的属性
@property (assign, nonatomic) CGFloat CNYValue;

@property (strong, nonatomic) NSString *amount;//还款金额
@property (strong, nonatomic) NSString *remitter;//汇款人
@property (strong, nonatomic) NSString *bankAccount;//银行账号

@property (strong, nonatomic) testmodel *account;
@property (strong, nonatomic) NSString *bank_branch;
@property (strong, nonatomic) NSString *bankname;
@property (strong, nonatomic) NSString *bname;
@property (strong, nonatomic) NSString *cardname;
@property (strong, nonatomic) NSString *cardnum;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *is_update;

@property (strong, nonatomic) NSString *bank_address;
@property (strong, nonatomic) NSString *bank_name;
@property (strong, nonatomic) NSString *bank_no;

@property (strong, nonatomic) NSMutableArray <testmodel *>*records;

@property (strong, nonatomic) NSMutableArray <testmodel *>*accounts;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *remark;

@property (strong, nonatomic) NSString *actual;
@property (strong, nonatomic) NSString *add_time;
@property (strong, nonatomic) NSString *fee;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *confirmation;
@property (strong, nonatomic) NSString *commited;


@property (strong, nonatomic) NSString *created;
@property (strong, nonatomic) NSString *_create;

@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSString *type;

@property (strong, nonatomic) NSMutableArray <testmodel *>*deals;

@property (strong, nonatomic)  NSMutableArray <testmodel *>*entrustments;
@property (strong, nonatomic) NSString *orders_id;

@property (strong, nonatomic)  NSMutableArray <testmodel *>*messages;
@property (strong, nonatomic) NSString *message_id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *totalPages;
@property (strong, nonatomic) NSString *total;

@property (strong, nonatomic) NSString *encodeUrl;

@property (assign, nonatomic) CGFloat trade_num;

@property (assign, nonatomic) CGFloat basic_price;

@end


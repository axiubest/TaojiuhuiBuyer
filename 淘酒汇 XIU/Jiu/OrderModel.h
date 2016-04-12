//
//  OrderModel.h
//  Jiu
//
//  Created by Molly on 15/11/16.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "BaseModel.h"

@interface OrderModel : BaseModel
@property(nonatomic,strong)NSString* orderid;
@property(nonatomic,strong)NSString* alipayid;
@property(nonatomic,strong)NSString* userid;
@property(nonatomic,strong)NSString* agentid;
@property(nonatomic,strong)NSString* price;
@property(nonatomic,strong)NSString* pay_price;
@property(nonatomic,strong)NSString* pay_way;
@property(nonatomic,strong)NSString* title;
@property(nonatomic,strong)NSString* routeid;
@property(nonatomic,strong)NSString* time;
@property(nonatomic,strong)NSString* message;
@property(nonatomic,strong)NSString* status;
@property(nonatomic,strong)NSString* freeze;
@end

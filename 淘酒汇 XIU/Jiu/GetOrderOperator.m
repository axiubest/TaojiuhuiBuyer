//
//  GetOrderOperator.m
//  Jiu
//
//  Created by Molly on 15/11/16.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "GetOrderOperator.h"
#import "OrderModel.h"
@implementation GetOrderOperator
-(id)initWithParamsDic:(NSDictionary *)params{
    if(self = [super initWithParamsDic:params]){
        self.action = @"home/Api/manageopenapi";
        self.orderArrs = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}
-(void)parseJson:(BaseModel *)baseModel{
    //NSDictionary* dataDic = baseModel.data;
    NSArray* retArr = baseModel.retArr;
    
    for (NSDictionary* retDic in retArr) {
        OrderModel* orderModel = [[OrderModel alloc]init];
        
        orderModel.orderid = [retDic objectForKey:@"orderid"];
        orderModel.alipayid = [retDic objectForKey:@"alipayid"];
        orderModel.userid = [retDic objectForKey:@"userid"];
        orderModel.agentid = [retDic objectForKey:@"agentid"];
        orderModel.price =  [NSString stringWithFormat:@"%.2f",[[retDic objectForKey:@"price"] doubleValue]/100];
        orderModel.pay_price = [NSString stringWithFormat:@"%.2f",[[retDic objectForKey:@"pay_price"] doubleValue]/100];;
        orderModel.pay_way = [retDic objectForKey:@"pay_way"];
        orderModel.title = [retDic objectForKey:@"title"];
        orderModel.routeid = [retDic objectForKey:@"routeid"];
        orderModel.time = [retDic objectForKey:@"time"];
        orderModel.message = [retDic objectForKey:@"message"];
        orderModel.status = [retDic objectForKey:@"status"];
        orderModel.freeze = [retDic objectForKey:@"freeze"];
        
        [_orderArrs addObject:orderModel];
    }
}

@end

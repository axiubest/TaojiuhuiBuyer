//
//  GetPayInfoOperator.m
//  Jiu
//
//  Created by Molly on 16/1/27.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "GetPayInfoOperator.h"

@implementation GetPayInfoOperator
- (id)initWithParamsDic:(NSDictionary *)params{
    if(self = [super initWithParamsDic:params]){
        self.action = @"home/Api/manageopenapi";
    }
    return self;
}
-(void)parseJson:(BaseModel *)baseModel{
    
    NSDictionary* orderDict = [baseModel.data objectForKey:@"order"];
    _order = [[Order alloc] init];
    _order.orderId = [orderDict objectForKey:@"orderid"];
    _order.payWay = [orderDict objectForKey:@"pay_way"];
    _order.total_fee =[NSString stringWithFormat:@"%.2f",[[orderDict objectForKey:@"pay_price"] doubleValue]/100];
    
}
@end

//
//  GetOrderDetailOperator.m
//  Jiu
//
//  Created by Molly on 16/2/15.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "GetOrderDetailOperator.h"
#import "Product.h"
@implementation GetOrderDetailOperator
- (id)initWithParamsDic:(NSDictionary *)params{
    if(self = [super initWithParamsDic:params]){
        self.action = @"home/Api/manageopenapi";
        self.order = [[Order alloc]init];
        self.order.productArr = [NSMutableArray array];
    }
    return self;
}
-(void)parseJson:(BaseModel *)baseModel{
    NSDictionary* dataDict = baseModel.data;

    NSDictionary* orderDict = [dataDict objectForKey:@"order"];
    _order.orderId = [orderDict objectForKey:@"orderid"];
    _order.total_fee = [NSString stringWithFormat:@"%.2f", [[orderDict objectForKey:@"pay_price"] doubleValue]/100];
    _order.payWay = [orderDict objectForKey:@"pay_way"];
//    _order.description = [orderDict objectForKey:@"title"];
    _order.time = [orderDict objectForKey:@"time"];
    _order.status = [orderDict objectForKey:@"status"];
    
    NSArray* dataArr = [dataDict objectForKey:@"order_detail"];
    for (NSDictionary* productDict in dataArr) {
        Product* product = [[Product alloc]init];
        
        product.detailId = [productDict objectForKey:@"detailid"];
        product.title = [productDict objectForKey:@"title"];
        product.orderId = [productDict objectForKey:@"orderid"];
        product.gid = [productDict objectForKey:@"gid"];
        product.countStr = [productDict objectForKey:@"count"];
        product.price = [NSString stringWithFormat:@"%.2f", [[productDict objectForKey:@"price"] doubleValue]/100];
        product.src = [NSString stringWithFormat:@"http://www.taojiuhui.cn/upload/%@",[productDict objectForKey:@"src"]];
        product.msg = [productDict objectForKey:@"msg"];
        [_order.productArr addObject:product];
    }
    
    NSDictionary* addressDict = [dataDict objectForKey:@"user_address"];
    AddressModel* addressModel = [[AddressModel alloc]init];
    addressModel.aid = [addressDict objectForKey:@"aid"];
    addressModel.region = [addressDict objectForKey:@"region"];
    addressModel.city = [addressDict objectForKey:@"city"];
    addressModel.qu = [addressDict objectForKey:@"qu"];
    addressModel.fullAddress = [addressDict objectForKey:@"full_adress"];
    addressModel.name = [addressDict objectForKey:@"name"];
    addressModel.phone = [addressDict objectForKey:@"phone"];
    addressModel.isUse = [addressDict objectForKey:@"is_use"];
    addressModel.isDefault = [addressDict objectForKey:@"is_default"];
    _order.defaultAddress = addressModel;
    
}

@end

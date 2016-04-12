//
//  GetSubmitOrderOperator.m
//  Jiu
//
//  Created by Molly on 16/1/21.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "GetSubmitOrderOperator.h"
#import "Product.h"
@implementation GetSubmitOrderOperator
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
    
    _order.orderId = [dataDict objectForKey:@"orderno"];
    
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
    NSDictionary* addressDict = [dataDict objectForKey:@"address"];
    AddressModel* addressModel = [[AddressModel alloc]init];
    
    if ([[addressDict objectForKey:@"name"] isEqualToString:@""]) {
        
        
        addressModel.aid = [addressDict objectForKey:@"aid"];
        addressModel.region = @"请输入省份";
        addressModel.city = @"请输入市";
        addressModel.qu = @"请输入区";
        addressModel.fullAddress = @"请输输入详细地址";
        addressModel.name = @"姓名";
        addressModel.phone = @"电话";
        addressModel.isUse = [addressDict objectForKey:@"is_use"];
        addressModel.isDefault = [addressDict objectForKey:@"is_default"];
        _order.defaultAddress = addressModel;

        
    }else {
    
    
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
    
    
}

@end

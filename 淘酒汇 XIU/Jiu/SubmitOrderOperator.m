//
//  SubmitOrderOperator.m
//  Jiu
//
//  Created by Molly on 15/11/19.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "SubmitOrderOperator.h"

@implementation SubmitOrderOperator
-(id)initWithParamsDic:(NSDictionary *)params{

    if(self = [super initWithParamsDic:params]){
        self.action = @"home/Api/manageopenapi";
        self.order = [[Order alloc] init];
    }
    return self;
}
-(void)parseJson:(BaseModel *)baseModel{

    NSDictionary* dataDict = baseModel.data;
    _order.orderId = [dataDict objectForKey:@"orderid"];
}
@end

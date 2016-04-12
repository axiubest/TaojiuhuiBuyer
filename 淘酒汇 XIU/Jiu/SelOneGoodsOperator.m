//
//  SelOneGoodsOperator.m
//  Jiu
//
//  Created by Molly on 15/11/26.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "SelOneGoodsOperator.h"

@implementation SelOneGoodsOperator

- (id)initWithParamsDic:(NSDictionary *)params{
    if(self = [super initWithParamsDic:params]){
        self.action = @"home/Api/manageopenapi";
    }
    return self;
}
-(void)parseJson:(BaseModel *)baseModel{
   
    _ret =[NSString stringWithFormat:@"%@",[baseModel.data objectForKey:@"code"]];
}

@end

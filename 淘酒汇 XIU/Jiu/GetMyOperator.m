//
//  GetMyOperator.m
//  Jiu
//
//  Created by Molly on 15/11/12.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "GetMyOperator.h"

@implementation GetMyOperator
-(id)initWithParamsDic:(NSDictionary *)params{
    if(self = [super initWithParamsDic:params]){
        self.action = @"home/Api/manageopenapi";
        
    }
    return self;
}
-(void)parseJson:(BaseModel *)baseModel{
    NSDictionary* dataDic = baseModel.data;
   
    _myModel = [[MyModel alloc]init];
    _myModel.uid = [dataDic objectForKey:@"uid"];
    _myModel.telephone = [dataDic objectForKey:@"telephone"];
    _myModel.status =[dataDic objectForKey:@"status"];
    _myModel.balance = [dataDic objectForKey:@"balance"];
    _myModel.credit = [dataDic objectForKey:@"credit"];
    _myModel.levelcredit = [dataDic objectForKey:@"levelcredit"];
}

@end

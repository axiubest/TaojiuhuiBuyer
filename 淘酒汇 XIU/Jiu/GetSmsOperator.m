//
//  GetSmsOperator.m
//  Jiu
//
//  Created by Molly on 15/10/29.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import "GetSmsOperator.h"

@implementation GetSmsOperator
-(id)initWithParamsDic:(NSDictionary *)params{
    if(self = [super initWithParamsDic:params]){
        self.action = @"home/Api/manageopenapi";
    }
    return self;
}
-(void)parseJson:(BaseModel *)baseModel{
    NSDictionary* dataDic = baseModel.data;
    _retStr = [dataDic objectForKey:@"ret"];
    //进行处理
    
//    _retStr = baseModel.dataStr;
    NSLog(@"接收到的信息%@",_retStr);
    NSLog(@"---------%@--------",@"11");
}
@end

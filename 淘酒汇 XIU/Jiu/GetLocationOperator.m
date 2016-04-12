//
//  GetLocationOperator.m
//  Jiu
//
//  Created by Molly on 16/1/6.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "GetLocationOperator.h"

@implementation GetLocationOperator
-(id)initWithParamsDic:(NSDictionary *)params{
    if (self = [super initWithParamsDic:params]) {
        self.action = @"home/Api/manageopenapi";
}
    return self;
}

-(void)parseJson:(BaseModel *)baseModel{
    
    NSDictionary* dataDic = baseModel.data;
    if ((NSNull *)[dataDic objectForKey:@"agentid"] != [NSNull null]) {
        _agentId = [dataDic objectForKey:@"agentid"];
    }else{
        _agentId = @"false";
    }
}
@end

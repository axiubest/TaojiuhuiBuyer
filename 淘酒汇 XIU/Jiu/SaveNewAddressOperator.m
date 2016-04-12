//
//  SaveNewAddressOperator.m
//  Jiu
//
//  Created by Molly on 15/11/20.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "SaveNewAddressOperator.h"

@implementation SaveNewAddressOperator

-(id)initWithParamsDic:(NSDictionary *)params{
    
    if(self = [super initWithParamsDic:params]){
        self.action = @"home/Api/manageopenapi";
    }
    return self;
}
-(void)parseJson:(BaseModel *)baseModel{
    NSDictionary* dataDict = baseModel.data;
}
@end

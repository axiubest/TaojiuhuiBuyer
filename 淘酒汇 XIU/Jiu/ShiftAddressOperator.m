//
//  ShiftAddressOperator.m
//  Jiu
//
//  Created by Molly on 16/2/15.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "ShiftAddressOperator.h"

@implementation ShiftAddressOperator
-(id)initWithParamsDic:(NSDictionary *)params{
    
    if(self = [super initWithParamsDic:params]){
        self.action = @"home/Api/manageopenapi";
    }
    return self;
}
-(void)parseJson:(BaseModel *)baseModel{
    
}
@end

//
//  GetAddressOperator.m
//  Jiu
//
//  Created by Molly on 15/11/20.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "GetAddressOperator.h"
#import "UserModel.h"
@implementation GetAddressOperator
-(id)initWithParamsDic:(NSDictionary *)params{
    
    if(self = [super initWithParamsDic:params]){
        self.action = @"home/Api/manageopenapi";
        self.tableData = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)parseJson:(BaseModel *)baseModel{
    NSArray* retArr = baseModel.retArr;
    for (NSDictionary*  dict in retArr) {
        UserModel* user = [[UserModel alloc]init];
        user.aid = [dict objectForKey:@"aid"];
        user.region = [dict objectForKey:@"region"];
        user.city = [dict objectForKey:@"city"];
        user.qu = [dict objectForKey:@"qu"];
        user.fullAddress = [dict objectForKey:@"full_adress"];
        user.name = [dict objectForKey:@"name"];
        user.telephone = [dict objectForKey:@"phone"];
        user.isDefault = [dict objectForKey:@"is_default"];
        
        [_tableData addObject:user];
    }
}
@end

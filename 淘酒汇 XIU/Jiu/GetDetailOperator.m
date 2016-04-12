//
//  GetDetailOperator.m
//  Jiu
//
//  Created by Molly on 16/1/19.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "GetDetailOperator.h"

@implementation GetDetailOperator
-(id)initWithParamsDic:(NSDictionary *)params{
    if(self = [super initWithParamsDic:params]){
        self.action = @"home/Api/manageopenapi";
        self.user = [[UserModel alloc] init];
        //self.detailData = [[NSMutableDictionary alloc]init];
    }
    return self;
}
//{"uid":"24","name":"æŽå˜‰å³»","email":"1053095533@qq.com","gander":"1","avatar":null,"birthday":"","status":"1"}

-(void)parseJson:(BaseModel *)baseModel{
    NSDictionary* dataDic = baseModel.data;
    
    _user.uid = [dataDic objectForKey:@"uid"];
    NSString* name = @"";
    if (!((NSNull* )[dataDic objectForKey:@"name"] == [NSNull null])) {
        name = [dataDic objectForKey:@"name"];
    }
    NSString* avatar = @"";
    if (!((NSNull* )[dataDic objectForKey:@"avatar"] == [NSNull null])) {
        avatar = [dataDic objectForKey:@"avatar"];
    }
    NSString* birthday = @"";
    if (!((NSNull* )[dataDic objectForKey:@"birthday"] == [NSNull null])) {
        birthday = [dataDic objectForKey:@"birthday"];
    }
    _user.name = name;
    _user.gander = [dataDic objectForKey:@"gander"];
    _user.avatar = avatar;
    _user.birthday = birthday;
    _user.status = [dataDic objectForKey:@"status"];
//    NSArray* keys = dataDic.allKeys;
//    
//    for (NSString* key in keys) {
//        NSString* value = [dataDic objectForKey:key];
//        
//        [_detailData setObject:value forKey:keys];
//    }
}

@end

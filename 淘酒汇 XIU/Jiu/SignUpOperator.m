//
//  SignUpOperator.m
//  Jiu
//
//  Created by Molly on 15/10/29.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import "SignUpOperator.h"

@implementation SignUpOperator
-(id)initWithParamsDic:(NSDictionary *)params{

    if (self = [super initWithParamsDic:params]) {
        self.action = @"home/Api/manageopenapi";
        _userModel = [[UserModel alloc]init];
    }
    return self;
}
-(void)parseJson:(BaseModel *)baseModel{

    NSDictionary* dataDic = baseModel.data;
    NSArray* keys = [dataDic allKeys];
    if (keys.count==1) {
        _userModel.num = [dataDic objectForKey:@"ret"];
        _userModel.uid = nil;
        _userModel.telephone = nil;
    }else{
    _userModel.num = nil;
    _userModel.uid =[dataDic objectForKey:@"userid"];
    _userModel.telephone = [dataDic objectForKey:@"telephone"];
    
NSLog(@"------------------%@-------点击登录按钮",_userModel.telephone);
    }
}
@end

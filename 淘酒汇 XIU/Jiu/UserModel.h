//
//  UserModel.h
//  Jiu
//
//  Created by Molly on 15/10/29.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel
@property(nonatomic,strong)NSString* num;
@property(nonatomic,strong)NSString* uid;
@property(nonatomic,strong)NSString* telephone;
@property(nonatomic,strong)NSString* fullAddress;
@property(nonatomic,strong)NSString* region;
@property(nonatomic,strong)NSString* city;
@property(nonatomic,strong)NSString* qu;
@property(nonatomic,strong)NSString* aid;
@property(nonatomic,strong)NSString* isDefault;
@property(nonatomic,strong)NSString* name;
@property(nonatomic,strong)NSString* email;
@property(nonatomic,strong)NSString* gander;//性别 1男/2女/3保密
@property(nonatomic,strong)NSString* avatar;//头像地址
@property(nonatomic,strong)NSString* birthday;
@property(nonatomic,strong)NSString* status;
@end

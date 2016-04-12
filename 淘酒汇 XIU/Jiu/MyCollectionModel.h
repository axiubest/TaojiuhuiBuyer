//
//  MyCollectionModel.h
//  Jiu
//
//  Created by mac on 16/2/26.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "BaseModel.h"

@interface MyCollectionModel : BaseModel


@property (nonatomic,strong) NSString *image1;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *agentid;
@property (nonatomic, copy) NSString *goods_id;



//登陆model

@property (nonatomic, strong)NSString *userid;

@property (nonatomic, strong)NSString *telephone;

@property (nonatomic, strong)NSString *password;




@end

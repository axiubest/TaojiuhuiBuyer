//
//  CartJiuModel.h
//  Jiu
//
//  Created by Molly on 15/11/26.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "BaseModel.h"

@interface CartJiuModel : BaseModel

@property(nonatomic,strong)NSString* cartid;
@property(nonatomic,strong)NSString* title;
@property(nonatomic,strong)NSString* count;
@property(nonatomic,strong)NSString* price;
@property(nonatomic,strong)NSString* image;
@property(nonatomic,strong)NSString* uid;
@property(nonatomic,strong)NSString* agentid;
@property(nonatomic,strong)NSString* gid;
@property(nonatomic,strong)NSString* status;
@end

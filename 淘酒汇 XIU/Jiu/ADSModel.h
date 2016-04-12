//
//  ADSModel.h
//  Jiu
//
//  Created by 张熔冰 on 15/10/22.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "BaseModel.h"

@interface ADSModel : BaseModel

@property(nonatomic, strong)NSString* adid;
@property(nonatomic, strong)NSString* idenfity;
@property(nonatomic, strong)NSString* path;
@property(nonatomic, strong)NSString* src;
@property(nonatomic, strong)NSString* href;
@property(nonatomic, strong)NSString* notice;
@property(nonatomic, strong)NSString* status;

@end

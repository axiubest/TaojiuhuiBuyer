//
//  GetDetailOperator.h
//  Jiu
//
//  Created by Molly on 16/1/19.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "BaseOperator.h"
#import "UserModel.h"
@interface GetDetailOperator : BaseOperator
@property(nonatomic,strong)UserModel* user;
//@property(nonatomic,strong)NSMutableDictionary* detailData;
@end

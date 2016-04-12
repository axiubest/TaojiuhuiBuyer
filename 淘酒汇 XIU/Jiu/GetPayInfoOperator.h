//
//  GetPayInfoOperator.h
//  Jiu
//
//  Created by Molly on 16/1/27.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "BaseOperator.h"
#import "Order.h"
@interface GetPayInfoOperator : BaseOperator
@property(nonatomic,strong)Order* order;
@end

//
//  GetOrderDetailOperator.h
//  Jiu
//
//  Created by Molly on 16/2/15.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "BaseOperator.h"
#import "Order.h"
@interface GetOrderDetailOperator : BaseOperator
@property(nonatomic,strong)Order* order;

@end

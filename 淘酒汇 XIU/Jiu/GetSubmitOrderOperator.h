//
//  GetSubmitOrderOperator.h
//  Jiu
//
//  Created by Molly on 16/1/21.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "BaseOperator.h"
#import "Order.h"

@interface GetSubmitOrderOperator : BaseOperator
@property(nonatomic,strong)Order* order;
@end

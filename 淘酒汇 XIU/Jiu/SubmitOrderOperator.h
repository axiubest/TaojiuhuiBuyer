//
//  SubmitOrderOperator.h
//  Jiu
//
//  Created by Molly on 15/11/19.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "BaseOperator.h"
#import "Order.h"
@interface SubmitOrderOperator : BaseOperator
@property(nonatomic,strong)Order* order;
@end

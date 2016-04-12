//
//  FillInOrderViewController.h
//  Jiu
//  填写订单
//  Created by 张熔冰 on 15/10/20.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
@interface FillInOrderViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong)NSString* totalPrice;
@property(nonatomic,strong)Order* order;
@property(nonatomic,strong)NSString* orderId;
@property(nonatomic, strong)NSMutableArray* tableData;
@property(nonatomic)NSString* payWayCode;
- (IBAction)submitOrder:(UIButton *)sender;

@end

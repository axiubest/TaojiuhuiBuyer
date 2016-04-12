//
//  OrderDetailViewController.h
//  Jiu
//
//  Created by 张熔冰 on 15/10/24.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Addition.h"
#import "UIView+Frame.h"

@interface OrderDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)NSArray* tableData;
@property(nonatomic,strong)NSString* orderId;

@end

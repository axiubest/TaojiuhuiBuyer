//
//  MyOrderViewController.h
//  Jiu
//
//  Created by zhangrongbing on 15/9/15.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainNavController.h"
#import "UILabel+Addition.h"
#import "UIView+Frame.h"
#import "OrderDetailViewController.h"

@interface MyOrderViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray* tableData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSString* uid;

@end

//
//  AddressViewController.h
//  Jiu
//
//  Created by zhangrongbing on 15/9/15.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) IBOutlet UITableView* tableView;
@property(nonatomic, strong) NSMutableArray* tableData;

@end

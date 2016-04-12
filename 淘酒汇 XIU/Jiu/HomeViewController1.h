//
//  HomeViewController1.h
//  Jiu
//
//  Created by 张熔冰 on 15/10/19.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"
#import "CycleScrollView.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+Image.h"
#import "TextButton.h"
#import "HomeTableViewCell.h"
#import "UILabel+Addition.h"
#import "MainNavController.h"
#import "LocationViewController.h"
#import "SearchViewController.h"
#import "TableViewCellDelegate.h"
#import "ProductInfoViewController.h"
#import "NetworkingManager.h"
#import "GetADSOperator.h"



@interface HomeViewController1 : UIViewController<UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate>

@property(nonatomic, strong)IBOutlet UITableView* tableView;
@property(nonatomic, strong)UIView* headerView;

@property(nonatomic, strong) NSArray* pageViewData;
@property(nonatomic,strong)NSMutableArray* salePathArr;
@property(nonatomic,strong) NSMutableArray* saleHrefArr;



@end

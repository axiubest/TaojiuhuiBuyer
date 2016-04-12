//
//  SearchViewController.h
//  Jiu
//
//  Created by zhangrongbing on 15/9/15.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"
#import "UISearchBar+Addition.h"
#import "CommodityListViewController.h"

@interface SearchViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property(nonatomic, strong)NSArray* tableData;

@end

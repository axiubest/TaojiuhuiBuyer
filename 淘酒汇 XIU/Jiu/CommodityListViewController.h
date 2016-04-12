//
//  CommodityListViewController.h
//  Jiu
//
//  Created by 张熔冰 on 15/10/21.
//  Copyright © 2015年 ;. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityTableViewCell.h"
#import "UISearchBar+Addition.h"
#import "DOPDropDownMenu.h"
#import "RightMenuViewController.h"

@interface CommodityListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>

@property(nonatomic, strong) NSMutableArray* tableData;

@property (nonatomic, weak) DOPDropDownMenu *menu;


@property(nonatomic,strong)NSString* mc;
@property(nonatomic,strong)NSString* bc;
@property(nonatomic,strong)NSString* keyword;
@end

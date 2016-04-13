//
//  CategoryViewController.h
//  Jiu
//
//  Created by 张熔冰 on 15/9/13.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"
#import "UILabel+Addition.h"
#import "LocationViewController.h"
#import "MainNavController.h"
#import "CategoryTableViewCell.h"
#import "SearchViewController.h"

@interface CategoryViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *xiuTableView;

@property(nonatomic, strong) NSArray* tableData;
@end

//
//  HomeTableViewHeaderViewController.h
//  Jiu
//
//  Created by 张熔冰 on 15/9/18.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCellDelegate.h"
#import "CommodityModel.h"

@interface HomeTableViewHeaderViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *commodityImg1;
@property (strong, nonatomic) IBOutlet UIImageView *commodityImg2;
@property (strong, nonatomic) IBOutlet UIImageView *commodityImg3;

@property(nonatomic, strong) id<TableViewCellDelegate> delegate;
@end

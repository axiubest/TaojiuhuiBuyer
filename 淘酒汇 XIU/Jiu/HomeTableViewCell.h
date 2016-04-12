//
//  HomeTableViewCell.h
//  Jiu
//
//  Created by 张熔冰 on 15/10/19.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCellDelegate.h"

@interface HomeTableViewCell : UITableViewCell

@property(nonatomic, strong)IBOutlet UIButton* analogyBtn1;//类似酒品
@property(nonatomic, strong)IBOutlet UIButton* analogyBtn2;//类似酒品
@property(nonatomic, strong)IBOutlet UIButton* analogyBtn3;//类似酒品

@property(nonatomic, strong)IBOutlet UIButton* commodityBtn1;
@property(nonatomic, strong)IBOutlet UIButton* commodityBtn2;
@property(nonatomic, strong)IBOutlet UIButton* commodityBtn3;

@property(nonatomic, strong) id<TableViewCellDelegate> delegate;

@end

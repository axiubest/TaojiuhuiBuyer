//
//  MyOrderTableViewCell.h
//  Jiu
//
//  Created by zhangrongbing on 15/9/15.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderTableViewCell : UITableViewCell

@property(nonatomic, strong)IBOutlet UIButton* statusBtn;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *payPrice;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLbl;
@property(nonatomic,strong)NSString* orderId;

@end

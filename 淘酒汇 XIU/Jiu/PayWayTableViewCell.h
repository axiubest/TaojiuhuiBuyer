//
//  PayWayTableViewCell.h
//  Jiu
//
//  Created by Molly on 15/11/29.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayWayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *payWayLbl;
@property (weak, nonatomic) IBOutlet UILabel *payInfoLbl;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@property (weak, nonatomic) IBOutlet UIImageView *payImgView;
@end

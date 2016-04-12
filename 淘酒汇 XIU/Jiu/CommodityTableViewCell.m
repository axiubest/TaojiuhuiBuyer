//
//  CommodityTableViewCell.m
//  Jiu
//
//  Created by 张熔冰 on 15/10/21.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "CommodityTableViewCell.h"

#import "MainNavController.h"
#import "ProductInfoViewController.h"
@implementation CommodityTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    [_discountLabel.layer setBorderColor:[UIColor redColor].CGColor];
//    [_discountLabel.layer setBorderWidth:0.5];
//    [_discountLabel.layer setMasksToBounds:YES];
    _discountLabel.alpha = 0.0;
    _limitLbl.alpha = 0.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)pressCellBtn:(id)sender {
    ProductInfoViewController* controller = [[ProductInfoViewController alloc]init];
    controller.gid = _gid;
    controller.goodsId = _goodsId;
    controller.agentId = _agentId;
    MainNavController* mainNavController = [[MainNavController alloc] initWithRootViewController:controller];
    [self.window.rootViewController presentViewController:mainNavController animated:YES completion:^{
        
    }];

}
@end

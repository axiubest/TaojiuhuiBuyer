//
//  CommodityTableViewCell.h
//  Jiu
//
//  Created by 张熔冰 on 15/10/21.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommodityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *limitLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *buyCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *infoLbl;
@property (weak, nonatomic) IBOutlet UIImageView *picImg;


- (IBAction)pressCellBtn:(id)sender;

@property(nonatomic,strong)NSString* gid;
@property(nonatomic,strong)NSString* goodsId;
@property(nonatomic,strong)NSString* agentId;
@end

//
//  ShoppingTableViewCell.h
//  Jiu
//
//  Created by 张熔冰 on 15/9/13.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImg;
@property (weak, nonatomic) IBOutlet UILabel *goodTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodPriceLbl;
@property (weak, nonatomic) IBOutlet UIButton *selectGoodsBtn;

@property(nonatomic, strong) IBOutlet UIButton* additionBtn;
@property(nonatomic, strong) IBOutlet UIButton* subtractionBtn;
@property(nonatomic, strong) IBOutlet UILabel* countLabel;
- (IBAction)pressAddBtn:(UIButton *)sender;
- (IBAction)pressSubBtn:(UIButton *)sender;

@property(nonatomic,strong)NSString* gid;
@end

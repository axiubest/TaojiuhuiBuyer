//
//  CollectionTableViewCell.h
//  Jiu
//
//  Created by 陈晓煚 on 16/2/25.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

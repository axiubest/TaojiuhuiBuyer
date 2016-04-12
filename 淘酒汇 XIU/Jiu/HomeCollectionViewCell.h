//
//  HomeCollectionViewCell.h
//  Jiu
//
//  Created by Molly on 15/11/6.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property(weak,nonatomic)IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

@property(nonatomic,strong)NSString* gid;
@property(nonatomic,strong)NSString* agentId;
@property(nonatomic,strong)NSString* goodsId;
@end

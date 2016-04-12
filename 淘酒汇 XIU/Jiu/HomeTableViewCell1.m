//
//  HomeTableViewCell1.m
//  Jiu
//
//  Created by Molly on 15/11/6.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "HomeTableViewCell1.h"
#import "HomeCollectionViewCell.h"
#import "HomeJiuModel.h"
#import "ProductInfoViewController.h"
#import "MainNavController.h"

#import "UIImageView+AFNetworking.h"
@interface HomeTableViewCell1()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{

    NSString* cellIdentifier;

}
@end
@implementation HomeTableViewCell1

- (void)awakeFromNib {
    
    cellIdentifier = @"HomeCollectionViewCell";
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellIdentifier];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.jiuModelArr.count > 0) {

        [self.collectionView reloadData];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.jiuModelArr.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//    if (!cell) {
//                cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeCollectionViewCell" owner:self options:nil] lastObject];
//           }
    
    HomeJiuModel* hJiuModel = _jiuModelArr[indexPath.row];
    [cell.goodsImg setImageWithURL:[NSURL URLWithString:hJiuModel.image1]];
    cell.titleLbl.text = hJiuModel.title;
    cell.priceLbl.text = [[NSString alloc]initWithFormat:@"￥%@",hJiuModel.price];
    
    cell.gid = hJiuModel.gid;
    cell.agentId = hJiuModel.agentId;
    cell.goodsId = hJiuModel.goodsId;
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat viewWidth = (kScreenWidth - 20)/3;
    return CGSizeMake(viewWidth, viewWidth/96*131);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 30, 0, 45);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    //int tag = indexPath.row;
    HomeCollectionViewCell* cell = (HomeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    ProductInfoViewController* controller = [[ProductInfoViewController alloc]init];
    controller.gid = cell.gid;
    controller.goodsId = cell.goodsId;
    controller.agentId = cell.agentId;
    MainNavController* mainNavController = [[MainNavController alloc] initWithRootViewController:controller];
    [self.window.rootViewController presentViewController:mainNavController animated:YES completion:^{
        
    }];
    }

@end

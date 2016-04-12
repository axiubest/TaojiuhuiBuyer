//
//  HomeTableViewCell1.h
//  Jiu
//
//  Created by Molly on 15/11/6.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)NSArray* jiuModelArr;
@end

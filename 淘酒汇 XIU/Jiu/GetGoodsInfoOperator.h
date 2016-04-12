//
//  GetGoodsInfoOperator.h
//  Jiu
//
//  Created by Molly on 15/11/26.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "BaseOperator.h"
#import "HomeJiuModel.h"

@interface GetGoodsInfoOperator : BaseOperator
@property(nonatomic,strong)HomeJiuModel* goodsInfoModel;
@property(nonatomic,strong)NSMutableArray* goodsDetailImageArr;
@property(nonatomic,strong)NSMutableDictionary* goodsDetailImageDict;
@property(nonatomic,strong)NSArray* paraArr;
@end

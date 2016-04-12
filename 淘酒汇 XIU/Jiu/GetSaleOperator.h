//
//  GetSaleOperator.h
//  Jiu
//
//  Created by Molly on 15/10/26.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import "BaseOperator.h"

@interface GetSaleOperator : BaseOperator

@property(nonatomic,strong)NSMutableArray* saleObject;
@property(nonatomic,strong)NSString* imgNum;

@property(nonatomic,strong,getter=getSalePathList)NSMutableArray* salePathList;
@property(nonatomic,strong,getter=getSaleHrefList)NSMutableArray* saleHrefList;

@end

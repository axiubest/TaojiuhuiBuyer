//
//  GetADSOperator.h
//  Jiu
//
//  Created by 张熔冰 on 15/10/22.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "BaseOperator.h"
#import "ADSModel.h"

@interface GetADSOperator : BaseOperator

@property(nonatomic, strong)NSMutableArray* adsObjects;
@property(nonatomic, strong)NSString* link;

@property(nonatomic, strong, getter=getAdsPathList)NSMutableArray* adsPathList;

@end

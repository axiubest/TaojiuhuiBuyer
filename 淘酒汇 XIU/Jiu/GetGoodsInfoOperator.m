//
//  GetGoodsInfoOperator.m
//  Jiu
//
//  Created by Molly on 15/11/26.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "GetGoodsInfoOperator.h"
@implementation GetGoodsInfoOperator

-(id)initWithParamsDic:(NSDictionary *)params{
    
    if (self = [super initWithParamsDic:params]) {
        self.action = @"home/Api/manageopenapi";
        
        self.goodsDetailImageArr = [[NSMutableArray alloc]init];
        self.goodsDetailImageDict = [[NSMutableDictionary alloc]init];
        self.goodsInfoModel = [[HomeJiuModel alloc]init];
        self.paraArr = [[NSArray alloc]init];
    }
    return self;
}
-(void)parseJson:(BaseModel *)baseModel{
    NSDictionary* dataDic = baseModel.data;
    
    NSDictionary* goodsInfo = [dataDic objectForKey:@"goods_info"];
    self.goodsInfoModel.title = [goodsInfo objectForKey:@"title"];
    self.goodsInfoModel.price = [NSString stringWithFormat:@"%.2f",[[goodsInfo objectForKey:@"price"] doubleValue]/100];
    self.goodsInfoModel.image1 = [goodsInfo objectForKey:@"image1"];
    self.goodsInfoModel.image2 = [goodsInfo objectForKey:@"image2"];
    self.goodsInfoModel.image3 = [goodsInfo objectForKey:@"image3"];
    self.goodsInfoModel.image4 = [goodsInfo objectForKey:@"image4"];
    self.goodsInfoModel.image5 = [goodsInfo objectForKey:@"image5"];
    
//    if([[dataDic objectForKey:@"telephone"] isEqual:@""]){
//        self.goodsInfoModel.telephone = @"-1";
//    }
//    else{
         self.goodsInfoModel.telephone = [dataDic objectForKey:@"telephone"];
//    }
   
    NSArray* goodsDetailImageArr = [dataDic objectForKey:@"goods_detail_image"];
    for (int i = 0; i < goodsDetailImageArr.count; i++) {
        NSDictionary* imageDic = goodsDetailImageArr[i];
        [self.goodsDetailImageArr addObject:[imageDic objectForKey:@"title"]];
        
        NSDictionary* jiuDicts = imageDic;
        [_goodsDetailImageDict setObject:[jiuDicts objectForKey:@"title"] forKey:[jiuDicts objectForKey:@"orderby"]];

    }
    
    //self.paraArr = [dataDic objectForKey:@"para"];
}

@end

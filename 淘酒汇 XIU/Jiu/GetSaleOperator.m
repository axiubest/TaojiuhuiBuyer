//
//  GetSaleOperator.m
//  Jiu
//
//  Created by Molly on 15/10/26.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import "GetSaleOperator.h"
#import "SaleModel.h"

@implementation GetSaleOperator
-(id)initWithParamsDic:(NSDictionary *)params{
    if (self = [super initWithParamsDic:params]) {
        self.action = @"home/Api/manageopenapi";
        _saleObject = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

-(void)parseJson:(BaseModel *)baseModel{

    NSDictionary* dataDic = baseModel.data;
    NSDictionary* saleDic = [dataDic objectForKey:@"sale"];
    NSArray* keys = [saleDic allKeys];
    
    for (int i = 0; i < keys.count ; i++) {
        
        NSString* imgNum = [[NSString alloc]initWithFormat:@"image%d",i+1];
        if ([keys[i] isEqualToString:imgNum]) {
            _imgNum = [saleDic objectForKey:keys[i]];
            continue;
        }
        
        SaleModel* saleModel = [[SaleModel alloc] init];
        NSDictionary* tempDic = [saleDic objectForKey:keys[i]];
        saleModel.src = [tempDic objectForKey:@"src"];
        saleModel.href = [tempDic objectForKey:@"href"];
        
        [_saleObject addObject:saleModel];
    }
    
}

-(NSArray*) getSalePathList{
    NSMutableArray* tempArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (SaleModel* saleModel in _saleObject) {
        NSString* pathStr = [[NSString alloc] initWithFormat:@"%@",saleModel.src];
        [tempArr addObject:pathStr];
    }
    return tempArr;
}
-(NSArray *)getSaleHrefList{
    NSMutableArray* tempArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (SaleModel* saleModel in  _saleObject) {
        NSString* hrefStr = [[NSString alloc]initWithFormat:@"%@",saleModel.href];
        [tempArr addObject:hrefStr];
    }
    return tempArr;
}

@end

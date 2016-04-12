//
//  GetSearchOpeartor.m
//  Jiu
//
//  Created by Molly on 16/1/20.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "GetSearchOpeartor.h"

#import "HomeJiuModel.h"
@implementation GetSearchOpeartor
-(id)initWithParamsDic:(NSDictionary *)params{
    if (self = [super initWithParamsDic:params]) {
        self.action = @"home/Api/manageopenapi";
        self.dataArr = [NSMutableArray array];
    }
    return self;
}

-(void)parseJson:(BaseModel *)baseModel{
    
    NSDictionary* dataDic = baseModel.data;
    NSArray* retArr = [dataDic objectForKey:@"data"];
    for (NSDictionary* dict in retArr) {
        HomeJiuModel* model = [[HomeJiuModel alloc]init];
        
        model.gid = [dict objectForKey:@"gid"];
        model.goodsId = [dict objectForKey:@"goods_id"];
        model.agentId = [dict objectForKey:@"agent_id"];
        model.typeId = [dict objectForKey:@"typeid"];
        model.stypeId = [dict objectForKey:@"stypeid"];
        model.title = [dict objectForKey:@"title"];
        model.price = [NSString stringWithFormat:@"%.2f",[[dict objectForKey:@"price"] doubleValue]/100];
        model.image1 = [NSString stringWithFormat:@"http://www.taojiuhui.cn/upload/%@",[dict objectForKey:@"image1"] ];
        
       //  http://www.taojiuhui.cn/2015-10-06/56135dd08933e.jpg
       // model.name = [dict objectForKey:@"name"];
        
        [_dataArr addObject:model];
    }
}

@end

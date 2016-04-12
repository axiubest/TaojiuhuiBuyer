//
//  GetCartOperator.m
//  Jiu
//
//  Created by Molly on 15/11/12.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "GetCartOperator.h"
#import "CartJiuModel.h"
@implementation GetCartOperator
-(id)initWithParamsDic:(NSDictionary *)params{
    if(self = [super initWithParamsDic:params]){
        self.action = @"home/Api/manageopenapi";
        self.cartGoodsArr = [NSMutableArray array];
    }
    return self;
}
- (void)parseJson:(BaseModel *)baseModel{

    NSArray* dataArr = baseModel.retArr;
    for (NSDictionary* dataDic in dataArr) {
        CartJiuModel* jiuModel = [[CartJiuModel alloc]init];
        
        jiuModel.cartid = [dataDic objectForKey:@"cartid"];
        jiuModel.title = [dataDic objectForKey:@"title"];
        jiuModel.price = [NSString stringWithFormat:@"%.2f",[[dataDic objectForKey:@"price"] doubleValue]/100];
        jiuModel.count = [dataDic objectForKey:@"count"];
        jiuModel.image = [NSString stringWithFormat:@"http://www.taojiuhui.cn/upload/%@",[dataDic objectForKey:@"image"]];
        jiuModel.status = [dataDic objectForKey:@"status"];
        jiuModel.gid = [dataDic objectForKey:@"gid"];
        
        [self.cartGoodsArr addObject:jiuModel];
    }
    
}
@end

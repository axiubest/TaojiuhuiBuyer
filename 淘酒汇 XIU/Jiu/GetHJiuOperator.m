//
//  GetHJiuOperator.m
//  Jiu
//
//  Created by Molly on 15/11/6.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "GetHJiuOperator.h"
#import "HomeJiuModel.h"
#import "CatagoryJiuModel.h"

@implementation GetHJiuOperator
-(id)initWithParamsDic:(NSDictionary *)params{

    if (self = [super initWithParamsDic:params]) {
        self.action = @"home/Api/manageopenapi";
        _homeCategoryArr = [[NSMutableArray alloc]init];
        _homeCategoryDics = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(void)parseJson:(BaseModel *)baseModel{
    NSDictionary* dataDic = baseModel.data;
    
    NSArray* tempArr = [dataDic allKeys];
   // _homeCategoryArr = [[NSArray alloc]init];
    for (int i = 0; i < tempArr.count; i++) {
        NSDictionary* tempDic = [dataDic objectForKey:tempArr[i]];
        NSString* title = [tempDic objectForKey:@"title"];
        [_homeCategoryArr addObject:title];
        [self.homeCategoryDics setObject:tempDic forKey:title];
    }
}
/**2015/11/12 接口更改后! categorylist是一个数组*/

-(NSMutableArray*)getCategoryListArr:(NSString*)categoryStr{
    NSMutableArray* tempArr = [[NSMutableArray alloc]init];
    
    NSDictionary* categoryDic = [self.homeCategoryDics objectForKey:categoryStr];
    NSArray* categoryListDic = [categoryDic objectForKey:@"categorylist"];
   
    for (NSDictionary* tempDic in categoryListDic) {
        
        HomeJiuModel* homeJiuModel = [[HomeJiuModel alloc]init];
        homeJiuModel.gid = [tempDic objectForKey:@"gid"];
        homeJiuModel.agentId = [tempDic objectForKey:@"agent_id"];
        homeJiuModel.goodsId = [tempDic objectForKey:@"goods_id"];
        homeJiuModel.typeId = [tempDic objectForKey:@"typeid"];
        homeJiuModel.stypeId = [tempDic objectForKey:@"stypeid"];
        homeJiuModel.title = [tempDic objectForKey:@"title"];
        homeJiuModel.price = [NSString stringWithFormat:@"%.2f", [[tempDic objectForKey:@"price"] doubleValue]/100];
        homeJiuModel.image1 = [NSString stringWithFormat:@"http://www.taojiuhui.cn/upload/%@",[tempDic objectForKey:@"image1"]];
        homeJiuModel.image2 = [NSString stringWithFormat:@"http://www.taojiuhui.cn/upload/%@",[tempDic objectForKey:@"image2"]];
        homeJiuModel.image3 = [NSString stringWithFormat:@"http://www.taojiuhui.cn/upload/%@",[tempDic objectForKey:@"image3"]];
        homeJiuModel.image4 = [NSString stringWithFormat:@"http://www.taojiuhui.cn/upload/%@",[tempDic objectForKey:@"image4"]];
        homeJiuModel.image5 = [NSString stringWithFormat:@"http://www.taojiuhui.cn/upload/%@",[tempDic objectForKey:@"image5"]];
        
        [tempArr addObject:homeJiuModel];
    }
    
    return tempArr;
}
/**2015/11/12 接口更改前 
 *categorylist 是一个字典
 
-(NSMutableArray*)getCategoryListArr:(NSString*)categoryStr{
    NSMutableArray* tempArr = [[NSMutableArray alloc]init];
    
    NSDictionary* categoryDic = [self.homeCategoryDics objectForKey:categoryStr];
    NSDictionary* categoryListDic = [categoryDic objectForKey:@"categorylist"];
    NSArray* temps = [categoryListDic allKeys];//0,1,2,3
    for (NSString* tempStr in temps) {
        
        NSDictionary* tempDic = [categoryListDic objectForKey:tempStr];
        
        HomeJiuModel* homeJiuModel = [[HomeJiuModel alloc]init];
        homeJiuModel.typeId = [tempDic objectForKey:@"typeid"];
        homeJiuModel.stypeId = [tempDic objectForKey:@"stypeid"];
        homeJiuModel.title = [tempDic objectForKey:@"title"];
        homeJiuModel.price = [tempDic objectForKey:@"price"];
        homeJiuModel.image1 = [tempDic objectForKey:@"image1"];
        homeJiuModel.image2 = [tempDic objectForKey:@"image2"];
        homeJiuModel.image3 = [tempDic objectForKey:@"image3"];
        homeJiuModel.image4 = [tempDic objectForKey:@"image4"];
        homeJiuModel.image5 = [tempDic objectForKey:@"image5"];
        
        [tempArr addObject:homeJiuModel];
    }
    
    return tempArr;
}
 */
-(NSMutableArray*)getItemsArr:(NSString*)categoryStr{
    NSMutableArray* tempArr = [[NSMutableArray alloc]init];
    
    NSDictionary* categoryDic = [self.homeCategoryDics objectForKey:categoryStr];
    NSDictionary* categoryListDic = [categoryDic objectForKey:@"items"];
    NSArray* temps = [categoryListDic allKeys];//0,1,2,3
    for (NSString* tempStr in temps) {
        
        NSDictionary* tempDic = [categoryListDic objectForKey:tempStr];
        CatagoryJiuModel* categoryJiuModel = [[CatagoryJiuModel alloc]init];
        
        categoryJiuModel.name = [tempDic objectForKey:@"name"];
        categoryJiuModel.logo = [tempDic objectForKey:@"logo"];
        [tempArr addObject:categoryJiuModel];
    }

    return tempArr;
}

@end

//
//  GetCategoryOpetator.m
//  Jiu
//
//  Created by Molly on 15/11/2.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "GetCategoryOpetator.h"

@implementation GetCategoryOpetator

-(id)initWithParamsDic:(NSDictionary *)params{

    if (self = [super initWithParamsDic:params]) {
        self.action = @"home/Api/manageopenapi";
        _parentDict = [[NSMutableDictionary alloc]init];
        
        _categoryJius = [[NSMutableArray alloc]initWithCapacity:0];
    }
    
    return self;
}

-(void)parseJson:(BaseModel *)baseModel{
    
    NSDictionary* dataDic = baseModel.data;
    NSDictionary* cates = [dataDic objectForKey:@"cates"];
    NSArray* jiuArrs = [cates allKeys];
    
    _categoryArrs = jiuArrs;
    
    for (int i = 0 ; i < jiuArrs.count; i++) {
        
        NSDictionary* jiuDicts = [cates objectForKey:jiuArrs[i]];
        [_parentDict setObject:jiuDicts forKey:jiuArrs[i]];

    }
    
}

/**2015/11/12 接口更改前 "白酒"等后面跟的是数组*/
-(NSMutableArray*)getCategoryJiuValue:(NSString *)jiuKey{
    NSMutableArray* temp = [[NSMutableArray alloc]initWithCapacity:0];
    
    NSArray* jiuArr = [_parentDict objectForKey:jiuKey];
    for (NSDictionary* jiu in jiuArr) {
        
        CatagoryJiuModel* jiuModel = [[CatagoryJiuModel alloc]init];
        jiuModel.category_id = [jiu objectForKey:@"category_id"];
        jiuModel.name = [jiu objectForKey:@"name"];
        jiuModel.parent_id = [jiu objectForKey:@"parent_id"];
        jiuModel.logo = [jiu objectForKey:@"logo"];
        
        [temp addObject:jiuModel];
        
    }
    
    return temp;
}

/**2015/11/12
 *接口更改前 "白酒"等后面跟的是字典
-(NSMutableArray*)getCategoryJiuValue:(NSString *)jiuKey{
    NSMutableArray* temp = [[NSMutableArray alloc]initWithCapacity:0];
    
    NSDictionary* jius = [_parentDict objectForKey:jiuKey];
    NSArray* jiuArr = [jius allKeys];
    for (NSString* jiuIndex in jiuArr) {
        
        NSDictionary* jiu = [jius objectForKey:jiuIndex];
        CatagoryJiuModel* jiuModel = [[CatagoryJiuModel alloc]init];
        jiuModel.category_id = [jiu objectForKey:@"category_id"];
        jiuModel.name = [jiu objectForKey:@"name"];
        jiuModel.parent_id = [jiu objectForKey:@"parent_id"];
        jiuModel.logo = [jiu objectForKey:@"logo"];
        
        [temp addObject:jiuModel];
        
    }
    
    return temp;
}

 */
@end

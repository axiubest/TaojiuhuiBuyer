//
//  GetADSOperator.m
//  Jiu
//
//  Created by 张熔冰 on 15/10/22.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "GetADSOperator.h"

@implementation GetADSOperator

-(id)initWithParamsDic:(NSDictionary *)params{
    if(self = [super initWithParamsDic:params]){
        self.action = @"home/Api/manageopenapi";
        _adsObjects = [[NSMutableArray alloc] initWithCapacity:0];
        _adsPathList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

-(void)parseJson:(BaseModel*) baseModel{
    NSDictionary* dataDic = baseModel.data;
    NSDictionary* adsDic = [dataDic objectForKey:@"ads"];
    NSArray* keys = [adsDic allKeys];
    
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    keys = [keys sortedArrayUsingComparator:cmptr];
    for (NSString* key in keys) {
        if ([key isEqualToString:@"link"]) {
            _link = [adsDic objectForKey:key];
            continue;
        }
        ADSModel* adsModel = [[ADSModel alloc] init];
        NSDictionary* tempDic = [adsDic objectForKey:key];
        adsModel.adid = [tempDic objectForKey:@"adid"];
        adsModel.idenfity = [tempDic objectForKey:@"idenfity"];
        adsModel.path = [tempDic objectForKey:@"path"];
        adsModel.src = [tempDic objectForKey:@"src"];
        adsModel.href = [tempDic objectForKey:@"href"];
        adsModel.notice = [tempDic objectForKey:@"notice"];
        adsModel.status = [tempDic objectForKey:@"status"];
        
        [_adsObjects addObject:adsModel];
    }
}

-(NSArray*) getAdsPathList{
    NSMutableArray* tempArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (ADSModel* adsModel in _adsObjects) {
        NSString* pathStr = [[NSString alloc] initWithFormat:@"%@%@%@", _link, adsModel.path, adsModel.src];
        
        [tempArr addObject:pathStr];
    }
    return tempArr;
}
@end

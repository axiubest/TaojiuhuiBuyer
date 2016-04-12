//
//  GetDetailDataOperator.m
//  Jiu
//
//  Created by Molly on 16/1/4.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "GetDetailDataOperator.h"

@implementation GetDetailDataOperator
-(id)initWithParamsDic:(NSDictionary *)params{
    if(self = [super initWithParamsDic:params]){
        self.action = @"home/Api/manageopenapi";
        self.detailData = [[NSMutableDictionary alloc]init];
    }
    return self;
}
-(void)parseJson:(BaseModel *)baseModel{
    NSDictionary* dataDic = baseModel.data;
    NSArray* keys = dataDic.allKeys;
    
    for (NSString* key in keys) {
        NSString* value = [dataDic objectForKey:key];
        
        [_detailData setObject:value forKey:key];
    }
}

@end

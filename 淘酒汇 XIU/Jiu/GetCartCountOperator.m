//
//  GetCartCountOperator.m
//  Jiu
//
//  Created by Molly on 15/11/20.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "GetCartCountOperator.h"

@implementation GetCartCountOperator
- (id)initWithParamsDic:(NSDictionary *)params{
    if(self = [super initWithParamsDic:params]){
        self.action = @"home/Api/manageopenapi";
        self.code = @"";
    }
    return self;
}
-(void)parseJson:(BaseModel *)baseModel{
    NSDictionary* dataDic = baseModel.data;
    NSString* tempStr = [NSString  stringWithFormat:@"%@",[dataDic objectForKey:@"code"]];
    _code = tempStr;
    //NSArray* dataArr = baseModel.retArr;
   // _count = [(NSDictionary*)dataArr[0] objectForKey:@"code"];
}

@end

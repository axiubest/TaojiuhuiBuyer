//
//  GetCancleOperator.m
//  Jiu
//
//  Created by Molly on 15/11/19.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "GetCancleOperator.h"

@implementation GetCancleOperator
-(id)initWithParamsDic:(NSDictionary *)params{

    if (self = [super initWithParamsDic:params]) {
        self.action = @"home/Api/manageopenapi";
    }
    return self;
}
-(void)parseJson:(BaseModel *)baseModel{

}
@end

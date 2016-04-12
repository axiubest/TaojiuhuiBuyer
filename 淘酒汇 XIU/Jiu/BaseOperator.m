//
//  BaseOperator.m
//  AFNetworkingDemo1
//
//  Created by 张熔冰 on 15/7/15.
//  Copyright © 2015年 ;. All rights reserved.
//

#import "BaseOperator.h"

@implementation BaseOperator

-(id)initWithParamsDic:(NSDictionary*) params{
    if(self =[super init]){
        NSString* domainPath = [[NSBundle mainBundle] pathForResource:@"path" ofType:@"plist"];
        _domain = [[[NSDictionary alloc] initWithContentsOfFile:domainPath] objectForKey:@"domain"];
        _paramsDic = params;
        
    }
    
    return self;
}

-(NSString*) getUrlStr{ //获取网络请求 “？”前的路径
    return [_domain stringByAppendingPathComponent:self.action];
}

//此方法暂时弃用  比较多余
-(NSURL*) getURLWithParams:(NSDictionary*) paramsDic andAction:(NSString*) action {
    //参数字符串
    NSMutableString* params = [[NSMutableString alloc] initWithCapacity:0];
    
    if (paramsDic) {
        NSArray* paramsKeys = [paramsDic allKeys];
        if ([paramsKeys count] == 1) {
            for (NSString* key in paramsKeys) {
                NSString* value = [paramsDic objectForKey:key];
                [params appendString:[NSString stringWithFormat:@"&%@=%@", key, value]];
            }
        }else{
            for (NSString* key in paramsKeys) {
                NSString* value = (NSString*)[paramsDic objectForKey:key];
                [params appendString:[NSString stringWithFormat:@"%@=%@&", key, value]];
            }
            if(params && [params length]>0){
                [params deleteCharactersInRange:NSMakeRange([params length]-1, 1)];
            }
        }
        _urlStr = [NSString stringWithFormat:@"%@/%@?%@",_domain, _action, params];
    }else{
        _urlStr = [NSString stringWithFormat:@"%@/%@",_domain, _action];
    }
    NSLog(@"url=%@",_urlStr);
    return [NSURL URLWithString:_urlStr];
}

-(void)parseJson:(BaseModel*) baseModel{
//    NSLog(@"errCode=%@, errMsg=%@, data=%@",baseModel.errCode, baseModel.errMsg, baseModel.data);
}
@end

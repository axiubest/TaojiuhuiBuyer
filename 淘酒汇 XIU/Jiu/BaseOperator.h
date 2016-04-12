//
//  BaseOperator.h
//  AFNetworkingDemo1
//
//  Created by 张熔冰 on 15/7/15.
//  Copyright © 2015年 persional. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseJson.h"

@interface BaseOperator : NSObject<ParseJson>

@property(nonatomic, strong) NSString* domain;//服务器地址
@property(nonatomic, strong) NSString* action;//方法名
@property(nonatomic, strong) NSDictionary* paramsDic;//参数
@property(nonatomic, strong, getter=getUrlStr) NSString* url;
@property(nonatomic, strong) NSString* urlStr;


-(id)initWithParamsDic:(NSDictionary*) params;

@end

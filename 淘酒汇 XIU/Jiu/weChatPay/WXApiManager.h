//
//  WXApiManager.h
//  Jiu
//
//  Created by A-XIU on 15/12/3.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApiObject.h"

@interface WXApiManager : NSObject

//预支付网关url地址
@property (nonatomic,strong) NSString* payUrl;
@property(nonatomic,strong)NSString* prepayId;
//回调url
@property(nonatomic,strong)NSString* notifyUrl;
//debug信息
@property (nonatomic,strong) NSMutableString *debugInfo;
@property (nonatomic,assign) NSInteger lastErrCode;//返回的错误码

//商户关键信息
@property (nonatomic,strong) NSString *appId,*mchId,*spKey;


//初始化函数
-(id)initWithAppID:(NSString*)appID
             mchID:(NSString*)mchID
             spKey:(NSString*)key;

//获取预支付订单信息（核心是一个prepayID）
- (NSMutableDictionary*)getPrepayWithOrderName:(NSString*)name
                                         price:(NSString*)price
                                        device:(NSString*)device;

@end

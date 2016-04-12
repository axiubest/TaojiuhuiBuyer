//
//  WXApiManager.m
//  Jiu
//
//  Created by A-XIU on 15/12/3.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//
#import "AFNetworking.h"
#import "WXApiManager.h"
#import <CommonCrypto/CommonDigest.h>
@implementation WXApiManager

-(id)initWithAppID:(NSString*)appID mchID:(NSString*)mchID spKey:(NSString*)key
{
    self = [super init];
    if(self)
    {
        //初始化私有参数，主要是一些和商户有关的参数
        self.payUrl    = @"https://api.mch.weixin.qq.com/pay/unifiedorder";
        if (self.debugInfo == nil){
            self.debugInfo  = [NSMutableString string];
        }
        [self.debugInfo setString:@""];
        self.appId = appID;//微信分配给商户的appID
        self.mchId = mchID;//
        self.spKey = key;//商户的密钥
    }
    return self;
}

//获取debug信息
-(NSString*) getDebugInfo
{
    NSString *res = [NSString stringWithString:self.debugInfo];
    [self.debugInfo setString:@""];
    return res;
}



//    NSMutableString *reqPars=[NSMutableString string];
//    //生成签名
//    sign = [self createMd5Sign:packageParams];
//    //生成xml的package
//    NSArray *keys = [packageParams allKeys];
//    [reqPars appendString:@"<xml>"];
//    for (NSString *categoryId in keys) {
//        [reqPars appendFormat:@"<%@>%@</%@>", categoryId, [packageParams objectForKey:categoryId],categoryId];
//    }
//    [reqPars appendFormat:@"<sign>%@</sign></xml>", sign];
    
//    return [NSString stringWithString:reqPars];
//获取package带参数的签名包
-(NSString *)genPackage:(NSMutableDictionary*)packageParams
{
    NSString *sign;
    [self createMd5Sign:packageParams];
    
    return sign;
}
//提交预支付
-(NSString *)sendPrepay:(NSMutableDictionary *)prePayParams
{
    NSString* prepayid = @"";
    
    //获取提交支付
    NSString* send = [self genPackage:prePayParams];
    
    //输出Debug Info
    [self.debugInfo appendFormat:@"API链接:%@", self.payUrl];
    [self.debugInfo appendFormat:@"发送的dict:%@", send];
    
    NSString *urlString  = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
//    NSString *urlString = [NSString stringWithFormat:@"https://api.mch.weixin.qq.com/pay/unifiedorder?appid=%@&mch_id=%@&nonce_str&=%@sign=%@body=%@out_trade_no=%@&total_fee&spbill_create_ip=%@&trade_type=APP&openid=%@",self.appId,self.mchId,@"2343243",send,@"111",@"7897",@"1",@"192.168.1.1",self.spKey];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
    
        prepayid = [dict objectForKey:@"prepayid"];
       
    }
     return prepayid;
}
    //解析服务端返回json数据
//    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager POST:urlString parameters:@{@"plat":@"ios"} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        if ( responseObject != nil) {
//            
//            NSString *requestTmp = [NSString stringWithString:operation.responseString];
//            
//            NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
//            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
//            //判断json转化后是否为字典
//            if (resultDic && [resultDic isKindOfClass:[NSDictionary class]]) {
//                
//                _prepayId = [resultDic objectForKey:@"prepayid"];
//                
//            }
//            
//            NSLog(@"url:%@",urlString);
//        }
//        
//
//    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//        
//    }];
//    prepayid = _prepayId;
//    return prepayid;


- (NSMutableDictionary*)getPrepayWithOrderName:(NSString*)name
                                         price:(NSString*)price
                                        device:(NSString*)device

{
    //支付类型，固定为APP
    NSString* orderType = @"APP";
    //发器支付的机器ip,暂时没有发现其作用
    NSString* orderIP = @"196.168.1.1";
    self.notifyUrl = @"http://";
    //随机数串
    srand( (unsigned)time(0) );
    NSString *noncestr  = [NSString stringWithFormat:@"%d", rand()];
    NSString *orderNO   = [NSString stringWithFormat:@"%ld",time(0)];
    
    //================================
           //预付单参数订单设置
    //================================
    NSMutableDictionary *packageParams = [NSMutableDictionary dictionary];
    
    [packageParams setObject: self.appId  forKey:@"appid"];       //开放平台appid
    [packageParams setObject: self.mchId  forKey:@"mch_id"];      //商户号
    [packageParams setObject: device  forKey:@"device_info"]; //支付设备号或门店号
    [packageParams setObject: noncestr     forKey:@"nonce_str"];   //随机串
    [packageParams setObject: orderType    forKey:@"trade_type"];  //支付类型，固定为APP
    [packageParams setObject: name     forKey:@"body"];        //订单描述，展示给用户
    [packageParams setObject: self.notifyUrl   forKey:@"notify_url"];  //支付结果异步通知
    [packageParams setObject: orderNO      forKey:@"out_trade_no"];//商户订单号
    [packageParams setObject: orderIP      forKey:@"spbill_create_ip"];//发器支付的机器ip
    [packageParams setObject: price   forKey:@"total_fee"];       //订单金额，单位为分
                //获取到prepayid后进行第二次签名
    NSString* prePayid = [self sendPrepay:packageParams];
    
            NSString    *package, *time_stamp, *nonce_str;
            //设置支付参数
            time_t now;
            time(&now);
            time_stamp  = [NSString stringWithFormat:@"%ld", now];
            nonce_str	= [self md5:time_stamp];
            //重新按提交格式组包，微信客户端暂只支持package=Sign=WXPay格式，须考虑升级后支持携带package具体参数的情况
            //package       = [NSString stringWithFormat:@"Sign=%@",package];
            package = @"Sign=WXPay";
            //第二次签名参数列表
            NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
            [signParams setObject: self.appId        forKey:@"appid"];
            [signParams setObject: nonce_str    forKey:@"noncestr"];
            [signParams setObject: package      forKey:@"package"];
            [signParams setObject: self.mchId        forKey:@"partnerid"];
            [signParams setObject: time_stamp   forKey:@"timestamp"];
            [signParams setObject: prePayid     forKey:@"prepayid"];
    
            //生成签名
            NSString *sign  = [self createMd5Sign:signParams];
            
            //添加签名
            [signParams setObject: sign forKey:@"sign"];
            
           // [debugInfo appendFormat:@"第二步签名成功，sign＝%@\n",sign];
            
            //返回参数列表
            return signParams;

  
}
//创建package签名
-(NSString*) createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
        
    }
    //添加key字段
    [contentString appendFormat:@"key=%@", self.spKey];
    //得到MD5 sign签名
    NSString *md5Sign =[self md5:contentString];
    
    //输出Debug Info
    [self.debugInfo appendFormat:@"MD5签名字符串：%@",contentString];
    
    return [md5Sign uppercaseString];
}
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // 调用MD5
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}
@end

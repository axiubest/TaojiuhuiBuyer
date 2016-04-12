//
//  PayInfoViewController.m
//  Jiu
//
//  Created by Molly on 16/1/27.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "PayInfoViewController.h"

#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"

#import "NetworkingManager.h"
#import "GetPayInfoOperator.h"

@interface PayInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *orderIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLbl;
@property(nonatomic,strong)Order* order;
@end

@implementation PayInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"收银台";
    
    [self requestPayInfo];
    _orderIdLbl.text = _orderId;
    
    UIBarButtonItem* rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(pressRight:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - public
- (IBAction)pressPay:(UIButton *)sender {
    if ([_payWay isEqualToString:@"支付宝支付"]) {
        //支付宝
        [self useAliPay];
    }else if([_payWay isEqualToString:@"微信支付"]){
        //微信
        [self useWeChatPay];
    }
}
-(void)pressRight:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark   微信支付
- (void)useWeChatPay {
    
}

#pragma mark - 支付宝支付
- (void)useAliPay{
    NSString *partner = @"2088911982910592";//商户ID
    NSString *seller = @"13354234423@163.com";//商家的支付宝账户
    NSString *privateKey = @"MIICXgIBAAKBgQDrtNTYYcCmvTMViF8mMDkZiHzdOqX8lr4I2ysX59FyxdcNxR+HK8L+P5Otej5q8oa9ZgnXg+Y3ray1HM/nb7q63ydLbonB6WYNGaKsZSy0NRSXkVvq5zUBzaq7asB6S4TwLNq9HdJFHqKrYEB+keikDQz/LrQ5fCSy1Rj995rZnQIDAQABAoGBANa6To0xwIgmJLuhGM15cQtJxDbmjwClc0ouH/wPPEgK4/evdSF3RJTK5oZLr0FO4GD67Exh5QEkPwpfzSdSKhEEOA18q15lBSeLtwgievFJVoGdeMNpX3KRzrbLw2o+H3HiIfbt25XHzg6vHWOpfKaMBWz1f2No/VXqdnOhdu8hAkEA+538jIbYx9soMA/+PhtECLSaOBY6N+5J7kEQi3/fVbgwIrMPkgCA22EQmUL/iLUDoczkjBywRLOWF4FvXwkU8wJBAO/P5T66PqVIkVj+aHpF3uI2tgRCoipgOPKmp6MTgYkNr1PazSO8EmOwpgGhUDe/t9g/NT3K2Ubxgu3EtRV0Oy8CQQD1f0z0s3D5dov8cO5IHIRB1iyOQqmk/pslmlgRM79tPFvCz2CGvHT9FvSCBMubz7lueaIYTrlxHqN35bMLT6ofAkA6gqjWMy7RuPDtm7T2EFIfM2YZiAB1AmEioxLHsRyrydD7Tqk6jMqX1CPMxgUCdR5v/owI9ZMpwgdF5/aes2s1AkEA2shaYpwGfDAbipX6XboZooH7nFdDVDDe0UQf/CPVNtWX4BKmBcGY85PWHCg/2TSkbiqWwXWfFMiusXRe0dkrKQ==";

    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"缺少partner或者seller或者私钥。"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  [self dismissViewControllerAnimated:YES completion:nil];
                                                              }];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    
 //   float totalprice = 0.0f;
    
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.service = @"mobile.securitypay.pay";//mobile.securitypay.pay
    order.inputCharset = @"utf-8";
    order.notifyURL = @"http://www.taojiuhui.cn/home/pay/alipay_pay_notifity";
    order.orderId = _order.orderId;
    order.total_fee = _order.total_fee;
    order.paymentType = @"1";
    order.body = _order.orderId;//商品描述暂时用订单号表示
    order.itBPay = @"30m";
//    order.showUrl = @"m.alipay.com";
    order.productName = _order.orderId;//商品名称暂时用订单号表示
    
    NSString *appScheme = @"wx834c4ce6291fc399";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    id<DataSigner> signer = CreateRSADataSigner([[NSBundle mainBundle] objectForInfoDictionaryKey:privateKey]);
    NSString *signedString = [signer signString:orderSpec];

    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        NSLog(@"%@",orderString);
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            //---  接收到的结果
        }];
    }
}
#pragma mark - 请求订单信息
/**请求订单信息
 http://www.taojiuhui.cn/home/Api/manageopenapi?action=order_detail&orderid=27&code=1&orderid=10002322&json=1
 orderid只传最长的就行
 */
- (void)requestPayInfo{
    GetPayInfoOperator* payInfoOperator = [[GetPayInfoOperator alloc]initWithParamsDic:@{@"code":@"1",@"action":@"order_detail",@"orderid":_orderId,@"json":@"1"}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:payInfoOperator withSuccessCallBack:^(BaseModel *model) {
        
        _order = [[Order alloc] init];
        _order = payInfoOperator.order;
        
         _totalPriceLbl.text = [NSString stringWithFormat:@"￥%@",_order.total_fee];
    } andFaildCallBack:^(id response) {
        
    }];
    
}
@end

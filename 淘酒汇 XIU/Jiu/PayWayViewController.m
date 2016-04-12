//
//  PayWayViewController.m
//  Jiu
//
//  Created by Molly on 15/11/29.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "PayWayViewController.h"
#import "PayWayTableViewCell.h"

#import "Product.h"

#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "WXApi.h"
#import "WXApiObject.h"
#import "WXApiManager.h"

#define APPID @"wx834c4ce6291fc399";
#define MCHID @"1253053601";//商户号
#define KEY @"b170839a4e24a3c9f2f2cf49b9a4223a";//商户秘钥
#define APPSECRET @"01c6d59a3f9024db6336662ac95c8e74";
#define NOTIET_URL @"http://www.taojiuhui.cn/home/pay/alipay_pay_notifity"; //支付宝--回调页面
#define SP_URL  @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php";// 微信 --获取服务器端支付数据地址(商户自定义)

@interface PayWayViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int payWayNum;
}
- (IBAction)pressPay:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray* payImgData;
@property (nonatomic,strong)NSArray* payWayData;
@property (nonatomic,strong)NSArray* payInfoData;
@property (nonatomic,strong)NSMutableArray* payBtnArr;


@end

@implementation PayWayViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    _tableView.delegate = self;
    _payImgData = @[@"weChat",@"AliPay"];
    _payWayData = @[@"微信",@"支付宝"];
    _payInfoData = @[@"推荐安装微信的用户使用",@"推荐安装支付宝的用户使用"];
    
    _payBtnArr = [NSMutableArray array];
    
    _tableView.tableFooterView = [[UIView alloc]init];
    
  //这里应该接收传递过来的product 信息
//    _product = [[Product alloc]init];
//    _product.price = @"1000.f";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_payImgData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString* cellIdtentifier = @"cell";
    
    PayWayTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdtentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PayWayTableViewCell" owner:self options:nil] lastObject];    }
    
     UIImage* img = [UIImage imageNamed: _payImgData[indexPath.row]];
    [cell.payImgView setImage:img];
    [cell.payWayLbl setText:_payWayData[indexPath.row]];
    [cell.payInfoLbl setText:_payInfoData[indexPath.row]];
    cell.payBtn.tag = indexPath.row;
    [_payBtnArr addObject:cell.payBtn];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:( NSIndexPath *)indexPath{
    
    payWayNum = (int)indexPath.row;
    for (UIButton* btn in _payBtnArr) {
        if (btn.tag == payWayNum) {
            btn.selected = YES;
        }
        else{
            btn.selected = NO;
        }
    }
}
#pragma mark - 产生随机订单号

- (void)useAliPay{
    NSString *partner = @"2088911982910592";
    //商家的支付宝账户
    NSString *seller = @"admin@taojiuhuin.cn";
    NSString *privateKey = @"8bioyz0til721f9n8mdp4wjyb6t0md2t";
    
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
    
    float totalprice = 0.0f;

    
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
//    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
//    order.productName = _product.subject; //商品标题
//    order.productDescription = _product.body; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f",_product.price]; //商品价格
//    order.notifyURL =  @"http://www.xxx.com"; //回调URL
//    order.tradeNO = _order.orderId;
    order.total_fee = [NSString stringWithFormat:@"%.2f",totalprice];
    order.service = @"mobile.securitypay.pay";
    order.notifyURL = @"http://www.taojiuhui.cn/home/pay/alipay_pay_notifity";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    NSString *appScheme = @"wx834c4ce6291fc399";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            
            //---  接收到的结果
        }];
        
    }


}
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
#pragma mark - 微信支付
- (void)useWeChatPay{
    //创建支付签名对象 && 初始化支付签名对象
    WXApiManager* wxpayManager = [[WXApiManager alloc]initWithAppID:@"wx834c4ce6291fc399" mchID:@"1253053601" spKey:@"b170839a4e24a3c9f2f2cf49b9a4223a"];
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    //生成预支付订单，实际上就是把关键参数进行第一次加密。
    NSString* device = @"10000";//商户号
    //订单标题，展示给用户
    NSString* orderName = @"30030";
    //订单金额,单位（分）
    NSString* orderPrice = @"10";//以分为单位的整数
    //支付设备号或门店号
    NSString* orderDevice = device;

   NSMutableDictionary* dict = [wxpayManager getPrepayWithOrderName:orderName price:orderPrice device:orderDevice];
    
    
    NSMutableString* retcode = [dict objectForKey:@"retcode"];
                if (retcode.intValue == 0){
                    PayReq* req = [[PayReq alloc]init];
                    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                    req.partnerId           = [dict objectForKey:@"partnerid"];
                    req.prepayId            = [dict objectForKey:@"prepayid"];
                    req.nonceStr            = [dict objectForKey:@"noncestr"];
                    req.timeStamp           = stamp.intValue;
                    req.package             = [dict objectForKey:@"package"];
                    req.sign                = [dict objectForKey:@"sign"];
                    req.openID              = [dict objectForKey:@"appid"];
    
                    //日志输出
                    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
   
                    BOOL flag = [WXApi sendReq:req];
                }
    
    NSLog(@"ok%@",@"sss");
}
#pragma mark - public
- (IBAction)pressPay:(UIButton *)sender {
    switch (payWayNum) {
        case 1:{
            [self useAliPay];
            break;
        }
        case 0:{
           [self useWeChatPay];
            break;
        }
        default:
            break;
    }
    
}

@end


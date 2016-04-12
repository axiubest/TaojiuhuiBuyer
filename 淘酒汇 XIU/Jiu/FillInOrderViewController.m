//
//  FillInOrderViewController.m
//  Jiu
//
//  Created by 张熔冰 on 15/10/20.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "FillInOrderViewController.h"
#import "PayWayViewController.h"

#import "Product.h"
#import "SubmitOrderOperator.h"
#import "NetworkingManager.h"

#import "UIImageView+AFNetworking.h"
#import "FillInOrderRow1TableViewCell.h"
#import "FillInOrderRow2TableViewCell.h"
#import "FillInOrderRow3TableViewCell.h"

#import "MainNavController.h"
#import "ShoppingCartViewController.h"
#import "PayCashViewController.h"
#import "PayInfoViewController.h"
#import "PayWayPickViewController.h"
#import "PayWayPickerView.h"
#import "AddressViewController.h"
#define keyWindow [UIApplication sharedApplication].keyWindow
@interface FillInOrderViewController ()<PayWayPickerViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    NSString* _taxfeel;
    NSString* _uid;
    NSString* _routeId;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *teleBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *payPriceLbl;
@property(nonatomic,strong)PayWayPickerView* pickerView;

@end

@implementation FillInOrderViewController
- (PayWayPickerView *)pickerView{
    
    if (!_pickerView) {
        _pickerView = [PayWayPickerView instanceTextView];
        _pickerView.delegate = self;
    }
    return _pickerView;
}
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
    self.title = @"填写订单";
    _tableData = @[_order.productArr, @[@""], @[@""], @[@"优惠券",@"消费积分"], @[@"商品金额", @"运费"]];
    
    AddressModel* defaultAddress = _order.defaultAddress;
    _nameLbl.text = defaultAddress.name;
    [_teleBtn setTitle:defaultAddress.phone forState:UIControlStateNormal];
    _addressLbl.text = [NSString stringWithFormat:@"%@%@%@%@",defaultAddress.region,defaultAddress.city,defaultAddress.qu,defaultAddress.fullAddress];
    _payPriceLbl.text = [NSString stringWithFormat:@"￥%@",_totalPrice];
    _routeId = defaultAddress.aid;
    
    _payWayCode = @"货到付款";
    _taxfeel = @"0";
    _orderId = _order.orderId;
    _uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView{
    return [_tableData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tableData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString* cellIdentifier = @"cell";
    
    if (indexPath.section ==0) {
        FillInOrderRow1TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = (FillInOrderRow1TableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"FillInOrderRow1TableViewCell" owner:nil options:nil] lastObject];
        }
        
        Product* product = _order.productArr[indexPath.row];
        NSString* price = product.price;
        cell.priceLbl.text = [NSString stringWithFormat:@"￥%@",price];
        cell.infoLbl.text = product.title;
        [cell.imgView setImageWithURL:[NSURL URLWithString:product.src]];
        return cell;
        
    }else if(indexPath.section == 2){
        FillInOrderRow3TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = (FillInOrderRow3TableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"FillInOrderRow3TableViewCell" owner:nil options:nil] lastObject];
        }

        [cell.selectBtn addTarget:self action:@selector(pressSelectBtn:)  forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else if (indexPath.section ==1){
        FillInOrderRow2TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = (FillInOrderRow2TableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"FillInOrderRow2TableViewCell" owner:nil options:nil] lastObject];
        }
        
        cell.payWayLbl.text = _payWayCode;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    
    }
    else
    {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        if (indexPath.section ==1){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FillInOrderRow2TableViewCell" owner:self options:nil] lastObject];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
    }else if(indexPath.section == 3){
        NSString* text = _tableData[indexPath.section][indexPath.row];
        cell.textLabel.text = text;
        cell.detailTextLabel.text = @"未使用";
        [cell.detailTextLabel setTextColor:[UIColor blackColor]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == 4 && indexPath.row == 0){
        NSString* text = _tableData[indexPath.section][indexPath.row];
        cell.textLabel.text = text;
        cell.detailTextLabel.text =[NSString stringWithFormat:@"￥%@",_totalPrice];
        [cell.detailTextLabel setTextColor:[UIColor redColor]];
    }
    else if (indexPath.section == 4 && indexPath.row == 1){
        NSString* text = _tableData[indexPath.section][indexPath.row];
        cell.textLabel.text = text;
        cell.detailTextLabel.text = @"￥0.00";
        [cell.detailTextLabel setTextColor:[UIColor redColor]];
    }
         return cell;
    }
}

-(CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else if (indexPath.section == 1){
        return 44;
    }else if (indexPath.section == 2){
        return 44;
    }
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        
        [self.pickerView initData];
        [self.pickerView.pickerView selectRow:self.pickerView.firstComponentRow inComponent:0 animated:YES];
    [keyWindow addSubview:self.pickerView];
//        PayWayPickViewController* controller = [[PayWayPickViewController alloc] init];
//        MainNavController* mainNavController = [[MainNavController alloc] initWithRootViewController:controller];
//        
//        [self.navigationController presentViewController:mainNavController animated:YES completion:^{
//            controller.block = ^(NSInteger* payWayCode){
//                _payWayCode = payWayCode;
//                [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//            };
//        }];
       
//        PayWayViewController* controller = [[PayWayViewController alloc]init];
//        controller.order = _order;
//        [self.navigationController pushViewController:controller animated:YES];
    }
}
#pragma mark - pickerView

- (void)payWayPickerViewDidPick:(NSString *)payway{
    
    _payWayCode = payway;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - public
- (void)pressSelectBtn:(UIButton *)sender{

    bool select = !sender.selected;
    sender.selected = select;
    if (sender.selected) {
        _taxfeel = @"1";
    }
    else{
        _taxfeel = @"0";
    }
}

/**提交订单
 http://www.taojiuhui.cn/home/Api/manageopenapi?action=submitorder&checkboxs=&regionid=&uid=&json=1
 
 新 http://www.taojiuhui.cn/home/Api/manageopenapi?action=checkout_detail&code=&orderid=10002322&pay_way=&taxfee=&routeid=1&uid=1&json=1
 code是优惠券
 taxfee 1为是需要发票 0不需要
 pay_way 1支付宝 2微信支付 0线下支付
 */
- (void)requestSubmitOrder:(NSString *)payWayStr{
    SubmitOrderOperator* submitOperator = [[SubmitOrderOperator alloc]initWithParamsDic:@{@"action":@"checkout_detail",@"code":@"",@"orderid":_orderId,@"pay_way":payWayStr,@"taxfee":_taxfeel,@"routeid":_routeId,@"uid":_uid,@"json":@"1"}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    [manager asyncTask:self.view withOperator:submitOperator withSuccessCallBack:^(BaseModel *model) {
        
        if ([payWayStr isEqualToString:@"0"]) {
            PayCashViewController* controller = [[PayCashViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }else
        {
            
            PayInfoViewController * payController = [[PayInfoViewController alloc] init];
            payController.orderId = submitOperator.order.orderId;
            payController.payWay = _payWayCode;
        
            [self.navigationController pushViewController:payController animated:YES];
        }
        
    } andFaildCallBack:^(id response) {
        
    }];
}
- (IBAction)pressShfitAddressBtn:(UIButton *)sender {
}
#pragma mark - 提交订单


- (IBAction)submitOrder:(UIButton *)sender {
    
    
    
    NSString* payWayStr = @"";
    if ([_payWayCode isEqualToString:@"支付宝支付"]) {
        payWayStr = @"1";
    }else if([_payWayCode isEqualToString:@"微信支付"]){
        payWayStr = @"2";
    }
    else{
        payWayStr = @"0";
    }
    [self requestSubmitOrder:payWayStr];
}






#pragma mark  点击顶部地址按钮跳转设置地址界面
- (IBAction)ChickedAddressBtn:(UIButton *)sender {
    AddressViewController *address = [[AddressViewController alloc] init];
    [self.navigationController pushViewController:address animated:YES];
    
}

@end

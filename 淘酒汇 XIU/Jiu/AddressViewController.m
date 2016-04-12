//
//  AddressViewController.m
//  Jiu
//
//  Created by zhangrongbing on 15/9/15.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import "AddressViewController.h"
#import "AddAddressViewController.h"
#import "AddressTableViewCell.h"
#import "EditAddressViewController.h"
#import "EditAllAddressDetailViewController.h"

#import "UserModel.h"
#import "DelAddressOperator.h"
#import "GetAddressOperator.h"
#import "SetDefaultAddressOperator.h"
#import "NetworkingManager.h"

@interface AddressViewController ()
@property(nonatomic,strong)NSMutableArray* addressSetBtnArr;
@end

@implementation AddressViewController
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
    self.addressSetBtnArr = [[NSMutableArray alloc]init];
    self.title = @"我的地址";
    
    self.tableView.tableFooterView = [[UIView alloc]init];
}
- (void)viewWillAppear:(BOOL)animated{

    _tableData = [[NSMutableArray alloc]init];
    [self requestAddress];
}
#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_tableData != nil) {
        return [_tableData count];
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString* cellIdentifier = @"cell";
    
    AddressTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddressTableViewCell" owner:nil options:nil] lastObject];
    }
    
    if (_tableData != nil) {
        
        [cell.editBtn addTarget:self action:@selector(pressEditBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.addressSetBtnArr addObject:cell.setDefaultAddressBtn];
        [cell.setDefaultAddressBtn addTarget:self action:@selector(pressSetDefaultAddressBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.deleteBtn addTarget:self action:@selector(pressDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.deleteBtn setTag:indexPath.row];
        
        UserModel* user = _tableData[indexPath.row];
        cell.infoLbl.text = [NSString stringWithFormat:@"%@ %@",user.name,user.telephone];
        cell.addressLbl.text = [NSString stringWithFormat:@"%@ %@ %@ %@",user.region,user.city,user.qu,user.fullAddress];
        cell.tag = [user.aid intValue];
        cell.aid = user.aid;
        cell.deleteBtn.tag = [user.aid intValue];
        if ([user.isDefault isEqualToString:@"1"]) {
            cell.setDefaultAddressBtn.selected = YES;
        }else{
            cell.setDefaultAddressBtn.selected = NO;
        }
        
    }

    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - Public


-(void)pressEditBtn:(id)sender{
    EditAllAddressDetailViewController* controller = [[EditAllAddressDetailViewController alloc] init];
    
    controller.aid = ((AddressTableViewCell*)[[sender superview] superview]).aid;
    [self.navigationController pushViewController: controller animated:YES];
}

- (IBAction)pressAddAdressBtn:(id)sender {
    [self.navigationController pushViewController:[[AddAddressViewController alloc] init] animated:YES];
}

-(void)pressSetDefaultAddressBtn:(UIButton*)sender{
    
    [self requestSetDefaultAddress:sender];
    
    sender.selected = YES;
    for (UIButton* setAddressBtn in self.addressSetBtnArr) {
        if (setAddressBtn != sender) {
            setAddressBtn.selected = NO;
        }
    }
}

-(void)pressDeleteBtn:(id)sender{
//    UIButton* btn = (UIButton*)sender;
//    NSInteger tag = btn.tag;
//    [_tableData removeObjectAtIndex:tag];
    [_tableView reloadData];
    
    [self resquestDelAddress:sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 请求 删除地址
/**http://www.taojiuhui.cn/home/Api/manageopenapi?action=delroute&aid=1&json=1

 */
- (void)resquestDelAddress:(UIButton*)sender{
    
    NSString* aid = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    DelAddressOperator* delOprator = [[DelAddressOperator alloc]initWithParamsDic:@{@"action":@"delroute",@"aid": aid,@"json":@"1"}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    [manager asyncTask:self.view withOperator:delOprator withSuccessCallBack:^(BaseModel *model) {
        
        [self requestAddress];
    } andFaildCallBack:^(id response) {
        
    }];
}
#pragma mark - 请求 设为默认地址
/**http://www.taojiuhui.cn/home/Api/manageopenapi?action=shiftroute&aid=27&is_default=1
 
 新 http://www.taojiuhui.cn/home/Api/manageopenapi?action=shiftroute&aid=1&uid=1&json=1*/
- (void)requestSetDefaultAddress:(UIButton*)sender{

    NSString* isDefault = @"1";
    SetDefaultAddressOperator* defaultAddressOperator = [[SetDefaultAddressOperator alloc]initWithParamsDic:@{@"action":@"shiftroute",@"aid": ((AddressTableViewCell*)[[sender superview] superview]).aid,@"uid":[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],@"is_default":isDefault}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:defaultAddressOperator withSuccessCallBack:^(BaseModel *model) {
        
        NSLog(@"--------%@------请求成功----------",@"设置默认地址");
        
    } andFaildCallBack:^(id response) {
        
    }];
}
#pragma mark - 请求 我的地址
/**http://www.taojiuhui.cn/home/Api/manageopenapi?action=address&uid=13&aid=4&json=1
  

 */
- (void)requestAddress{
    GetAddressOperator* addressOperator = [[GetAddressOperator alloc]initWithParamsDic:@{@"action":@"address",@"uid":[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],@"aid":@"4",@"json":@"1"}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:addressOperator withSuccessCallBack:^(BaseModel *model) {
        _tableData = addressOperator.tableData;
        [_tableView reloadData];
        NSLog(@"--------%@------请求成功----------",@"我的地址");
    } andFaildCallBack:^(id response) {
        
    }];
}


@end

//
//  MyViewController.m
//  Jiu
//
//  Created by 张熔冰 on 15/9/13.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "MyViewController.h"
#import "CommodityStatusTableViewCell.h"
#import "SettingsViewController.h"
#import "MyOrderViewController.h"
#import "AddressViewController.h"
#import "MyAccountViewController.h"
//#import "SignUpViewController.h"
#import "MyCollectionViewController.h"

#import "MyModel.h"
#import "GetMyOperator.h"
#import "NetworkingManager.h"

#import "XIULandViewController.h"


#import "IsLogin.h"
@interface MyViewController ()<CommodityStatusTableViewCellDelegate>
@property(nonatomic,strong)NSString* uid;







@property (nonatomic, strong) CommodityStatusTableViewCell *viewCell;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"我的";

    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;
    
    _tableData = @[@[@"我的订单",@""],@[@"我的账号",@"我的收藏",@"地址管理"],@[@"我的活动",@"意见反馈",@"系统设置"]];
    
    UIBarButtonItem* rightBarBtnItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"setting-selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressSettingBtn:)];
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
    
//    UITapGestureRecognizer* signUpTapGesturecoginzer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressSignUp:)];
//    [self.myImage addGestureRecognizer:signUpTapGesturecoginzer];
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //NSString* flag = [[NSUserDefaults standardUserDefaults]objectForKey:@"uid"];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"uid"] != nil) {
        [self requestMyPage];
    }else{
        _teleLbl.text = @"";
        _balanceBtn.text = @"";
        _creditBtn.text = @"";
        
        if (![_myImage isDescendantOfView:_myImgView]) {
            [_myImage addSubview:_myImgView];
            [_myImage addSubview:_loginInfoLbl];
        }
    }
}
#pragma mark - 请求个人中心
/**
 *http://www.taojiuhui.cn/home/Api/manageopenapi
 *?action=mine&uid=29&json=1
 */
-(void)requestMyPage{

    GetMyOperator* myOperator = [[GetMyOperator alloc]initWithParamsDic:@{@"action":@"mine",@"uid":[[NSUserDefaults standardUserDefaults]objectForKey:@"uid"],@"json":@"1"}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:myOperator withSuccessCallBack:^(BaseModel *model) {
       
        MyModel* myModel = myOperator.myModel;
        _teleLbl.text = myModel.telephone;
        _balanceBtn.text = [NSString stringWithFormat:@"余额:%@",myModel.balance];
        _creditBtn.text = [NSString stringWithFormat:@"积分:%@",myModel.credit ];
        
        [_loginInfoLbl removeFromSuperview];
        [_myImgView removeFromSuperview];
        
        UIImageView* myImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 90, 90)];
        [myImgView setImage:[UIImage imageNamed:@"my"]];
        [_myImage addSubview:myImgView];
        
    } andFaildCallBack:^(id response) {
        
    }];
}

#pragma mark - UItableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_tableData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger rowCount = [(NSArray*)[_tableData objectAtIndex:section] count];
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString* text = [[_tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:text];
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        CommodityStatusTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"CommodityStatusTableViewCell" owner:nil options:nil] lastObject];
        cell.mydelegate = self;
        
        
//        return (UITableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"CommodityStatusTableViewCell" owner:nil options:nil] lastObject];
        return cell;

        
    }
    return cell;
}


#warning !!!
- (void)CommodityStatusTableViewCell:(CommodityStatusTableViewCell *)cell urlStr:(NSString *)urlStr {
    IsLogin* login = [[IsLogin alloc]init];
    NSString* uid = [login isLoginIn:self.navigationController];
    if (![uid isEqualToString:@""]) {
        _uid = uid;
    }else{
        return;
    }
    MyOrderViewController* orderController = [[MyOrderViewController alloc] init];
    orderController.uid = _uid;
    
    [self.navigationController pushViewController:orderController animated: YES];
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* text = [[_tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if ([text isEqualToString:@"系统设置"]||[text isEqualToString:@"我的订单"]||[text isEqualToString:@"地址管理"]||[text isEqualToString:@"我的账号"]) {
        IsLogin* login = [[IsLogin alloc]init];
        NSString* uid = [login isLoginIn:self.navigationController];
        if (![uid isEqualToString:@""]) {
            _uid = uid;
        }else{
            return;
        
        }
    }
   
    
    if ([text isEqualToString:@"系统设置"]) {
        [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
    }
    
    if ([text isEqualToString:@"我的订单"]) {
        MyOrderViewController* orderController = [[MyOrderViewController alloc] init];
        orderController.uid = _uid;
        [self.navigationController pushViewController:orderController animated: YES];
    }
    if ([text isEqualToString:@"地址管理"]) {
        [self.navigationController pushViewController:[[AddressViewController alloc] init] animated: YES];
    }
    if ([text isEqualToString:@"我的账号"]) {
        MyAccountViewController* accountController = [[MyAccountViewController alloc] init];
        accountController.uid = _uid;
        [self.navigationController pushViewController:accountController animated: YES];
    }
    if ([text isEqualToString:@"我的收藏"]) {
        MyCollectionViewController *mycollection = [[MyCollectionViewController alloc] init];
        mycollection.uid = _uid;
        [self.navigationController pushViewController:mycollection animated:YES];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 1) {
        return 100.f;
    }
    return 44.f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil; 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - public
-(void)pressSettingBtn:(id)sender{

}
- (IBAction)signUpBtn:(id)sender {
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"uid"] == nil) {
        
        XIULandViewController* signUpViewController = [[XIULandViewController alloc]initWithNibName:@"XIULandViewController" bundle:nil];
        [self.navigationController pushViewController:signUpViewController animated:YES];
    }
    else{
        return;
    //如果登录了就跳转到修改头像界面
    }
   
}
//-(void)pressSignUp:(UITapGestureRecognizer*)sender{
//

//    SignUpViewController* signUpViewController = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
//    [self.navigationController pushViewController:signUpViewController animated:YES];
//

//    MainNavController* navController = [[MainNavController alloc]initWithRootViewController:signUpViewController];
//    [self presentViewController:navController animated:YES completion:^{
//    }];
    
//}





@end

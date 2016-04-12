//
//  AddAddressViewController.m
//  Jiu
//
//  Created by 张熔冰 on 15/9/15.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "AddAddressViewController.h"
#import "AddressTableViewCell.h"
#import "EditAddressViewController.h"

#import "SaveNewAddressOperator.h"
#import "NetworkingManager.h"

#import "CityPickerView.h"
#import "FMDB.h"

#define keyWindow [UIApplication sharedApplication].keyWindow
@interface AddAddressViewController ()<UITableViewDataSource,UITableViewDelegate,CityPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)CityPickerView* cityPickView;
@property(nonatomic,strong)NSMutableDictionary* returnedUserIndoDic;
@property(nonatomic,copy)NSString* address;

@property(nonatomic,strong)NSString* provinceName;
@property(nonatomic,strong)NSString* cityName;
@property(nonatomic,strong)NSString* regionName;
@end

@implementation AddAddressViewController


- (NSMutableDictionary *)returnedUserIndoDic{
    
    if (!_returnedUserIndoDic) {
        _returnedUserIndoDic = [NSMutableDictionary dictionary];
    }
    return _returnedUserIndoDic;
}

- (CityPickerView *)cityPickView{
    
    if (!_cityPickView) {
        _cityPickView = [CityPickerView instanceTextView];
        _cityPickView.delegate = self;
    }
    return _cityPickView;
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
    self.title = @"添加收货人";
    
    _tableData = @[@"收货人:",@"联系方式:",@"所在地区:", @"详细地址:"];
    _tableView.tableFooterView = [[UIView alloc]init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _tableData[indexPath.row];
    
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3) {
        UITextField* userNameField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, 240, 44)];
        userNameField.tag = indexPath.row + 1000;
        [cell.contentView addSubview:userNameField];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if (indexPath.row == 2) {
        if (self.address == nil) {
            cell.detailTextLabel.text = @"无";
        }
        else{
            cell.detailTextLabel.text = self.address;
        }
        cell.detailTextLabel.tag = indexPath.row + 1000;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 2) {
        
        NSString * provincecode = [self.returnedUserIndoDic objectForKey:@"provinceCode"];
        NSString * citycode = [self.returnedUserIndoDic objectForKey:@"cityCode"];
        NSString * regionCode = [self.returnedUserIndoDic objectForKey:@"regionCode"];
        
        if ([self getareaName].length > 2) {
            [self.cityPickView rolltoProvince:provincecode City:citycode Area:regionCode];
        }
        else
        {
            [self.cityPickView initData];
        }
        
        [self.cityPickView.pickview selectRow:self.cityPickView.firstComponentRow inComponent:0 animated:YES];
        [self.cityPickView.pickview selectRow:self.cityPickView.secondComponentRow inComponent:1 animated:YES];
        [self.cityPickView.pickview selectRow:self.cityPickView.thirdComponentRow inComponent:2 animated:YES];
        
        [keyWindow addSubview:self.cityPickView];
    }
}

#pragma mark - Public

- (IBAction)pressSaveAddressBtn:(UIButton *)sender {
    [self requestSaveNewAddress];
}

#pragma mark - 请求 保存新的地址
/**
 
 新 http://www.taojiuhui.cn/home/Api/manageopenapi?action=creroute&city=1&uid=1&area=1&qu=1&full_address=1&name=1&phone=1&json=1
 http://www.taojiuhui.cn/home/Api/manageopenapi?action=creroute&region=&city=&qu=&full_address=&name=&phone=&is_use=&is_deafult=&uid=
 
 
 */
- (void)requestSaveNewAddress{

    UITextField* nameLbl = (UITextField*)[self.view viewWithTag:1000];
    UITextField* teleLbl = (UITextField*)[self.view viewWithTag:1001];
   // UITextField*  addressLbl = (UITextField*)[self.view viewWithTag:1002];
    UITextField* detailLbl = (UITextField*)[self.view viewWithTag:1003];
    
    NSString* name = nameLbl.text;
    NSString* tele = teleLbl.text;
    NSString* address = _address;
    NSString* fullAddress = detailLbl.text;
    
    if ([name isEqualToString:@""]||[tele isEqualToString:@""]||address == nil||[fullAddress isEqualToString:@""]){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"请完善所有信息后再添加!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancleAction];
        [self.navigationController presentViewController:alert animated:YES completion:^{
        }];

    }
    else{
        
        SaveNewAddressOperator* saveOperator = [[SaveNewAddressOperator alloc]initWithParamsDic:@{@"action":@"creroute",@"region":_provinceName,@"city":_cityName,@"qu":_regionName,@"full_address":fullAddress,@"name":name,@"phone":tele,@"json":@"1",@"is_use":@"0",@"is_default":@"0",@"uid":[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]}];
        NetworkingManager* manager = [NetworkingManager sharedInstance];
        
        [manager asyncTask:self.view withOperator:saveOperator withSuccessCallBack:^(BaseModel *model) {
            
            [self.navigationController popViewControllerAnimated:YES];
            NSLog(@"-----%@----请求成功------",@"添加新的地址");
        } andFaildCallBack:^(id response) {
            
        }];
    }
   
}
#pragma mark - CityPickerViewDelegate

- (void)CityPickerViewDidPickProvince:(NSString *)provincecode City:(NSString *)citycode Area:(NSString *)areacode cityallname:(NSString *)name proviceName:(NSString *)provicename cityName:(NSString *)cityname areaName:(NSString *)areaname
{
    [self.returnedUserIndoDic setValue:provincecode forKey:@"provinceCode"];
    [self.returnedUserIndoDic setValue:citycode forKey:@"cityCode"];
    [self.returnedUserIndoDic setValue:areacode forKey:@"regionCode"];
    
    self.address = name;
    
    _provinceName = provicename;
    _cityName = cityname;
    _regionName = areaname;
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
}


- (NSString *)getareaName//取出地名
{
    NSString* dbPath = [[NSBundle mainBundle] pathForResource:@"citys" ofType:@"db"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    if (![database open]) {
        return @"";
    }
    
    //    provinceCode 省
    //    cityCode 市
    //    regionCode 区
    
    NSString * provincecode = [self.returnedUserIndoDic objectForKey:@"provinceCode"];
    NSString * citycode = [self.returnedUserIndoDic objectForKey:@"cityCode"];
    NSString * regionCode = [self.returnedUserIndoDic objectForKey:@"regionCode"];
    
    NSString * provincename = @"";
    NSString * cityname = @"";
    NSString * regionname = @"";
    
    
    if (provincecode.length > 0) {
        NSString * sqlstr = [NSString stringWithFormat:@"select * from jdp_org where level = 1 and orgcode = %@",provincecode];
        FMResultSet *resultSet = [database executeQuery:sqlstr];
        while ([resultSet next]) {
            provincename = [resultSet stringForColumn:@"orgname"];
        }
    }
    
    if (citycode.length > 0) {
        NSString * sqlstr = [NSString stringWithFormat:@"select * from jdp_org where level = 2 and orgcode = %@",citycode];
        FMResultSet *resultSet = [database executeQuery:sqlstr];
        while ([resultSet next]) {
            cityname = [resultSet stringForColumn:@"orgname"];
        }
    }
    
    if (regionCode.length > 0) {
        NSString * sqlstr = [NSString stringWithFormat:@"select * from jdp_org where level = 3 and orgcode = %@",regionCode];
        FMResultSet *resultSet = [database executeQuery:sqlstr];
        while ([resultSet next]) {
            regionname = [resultSet stringForColumn:@"orgname"];
        }
    }
    
    [database close];
    
    return [NSString stringWithFormat:@"%@ %@ %@",provincename,cityname,regionname];
}


@end

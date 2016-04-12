//
//  EditAllAddressDetailViewController.m
//  Jiu
//
//  Created by Molly on 15/11/20.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "EditAllAddressDetailViewController.h"
#import "EditAddressViewController.h"
#import "AddressTableViewCell.h"

#import "GetDetailDataOperator.h"
#import "UpdateAddressOperator.h"
#import "DelAddressOperator.h"
#import "NetworkingManager.h"

#import "FMDB.h"
#import "CityPickerView.h"
#define keyWindow [UIApplication sharedApplication].keyWindow
@interface EditAllAddressDetailViewController ()<UITableViewDelegate,UITableViewDataSource,CityPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)saveEdit:(UIButton *)sender;
@property (nonatomic,strong)NSMutableDictionary* detailData;

@property(nonatomic,strong)CityPickerView* cityPickView;
@property(nonatomic,strong)NSMutableDictionary* returnedUserIndoDic;
@property(nonatomic,copy)NSString* address;

@property(nonatomic,strong)NSString* provinceName;
@property(nonatomic,strong)NSString* cityName;
@property(nonatomic,strong)NSString* regionName;
@property(nonatomic,strong)NSString* flag;
@end

@implementation EditAllAddressDetailViewController
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑收货人";
    
    _tableData = @[@"收货人:",@"联系方式:",@"所在城市:", @"详细地址:"];
    
    UIBarButtonItem* rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(pressRight:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    [self getDetailData];
    _tableView.tableFooterView = [[UIView alloc]init];
    
    _flag = @"edit";
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
    if(_detailData != nil){
    NSString* key = @"";
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3) {
        UITextField* userNameField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, 240, 44)];
        userNameField.tag = indexPath.row+1000;
        [cell.contentView addSubview:userNameField];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        switch (indexPath.row) {
            case 0:{
                key = @"name";
                break;
            }
            case 1:{
                key = @"phone";
                break;
            }
            case 3:{
                key = @"full_adress";
                break;
            }
            default:
                break;
        }
        userNameField.text = [_detailData objectForKey:key];
    }
    
        if (indexPath.row == 2) {
            
            //cell.detailTextLabel.text = @"无";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if ([_flag isEqualToString:@"edit"]) {
                _provinceName = [_detailData objectForKey:@"region"];
                _cityName = [_detailData objectForKey:@"city"];
                _regionName = [_detailData objectForKey:@"qu"];
            }
            cell.detailTextLabel.text= [NSString stringWithFormat:@"%@ %@ %@",_provinceName,_cityName,_regionName];
            cell.detailTextLabel.tag = indexPath.row + 1000;
        }
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

#pragma mark - 请求 删除地址
/**http://www.taojiuhui.cn/home/Api/manageopenapi
 *?action=delroute&aid=1&json=1
 aid是地址id  
 
新 http://www.taojiuhui.cn/home/Api/manageopenapi?action=delroute&aid=1&json=1
 */
- (void)requestDelAddress{
    DelAddressOperator* delOprator = [[DelAddressOperator alloc]initWithParamsDic:@{@"action":@"delroute",@"aid":_aid,@"json":@"1"}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    [manager asyncTask:self.view withOperator:delOprator withSuccessCallBack:^(BaseModel *model) {
        
        
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"请求---%@",@"del地址");
    } andFaildCallBack:^(id response) {
        
    }];
}

#pragma mark - 请求 修改地址
/**
新 http://www.taojiuhui.cn/home/Api/manageopenapi?action=editroute&region=&city=&qu=&full_address=&name=&phone=&aid=1&json=1
 */

- (void)requestUpdateAddress{
    UITextField* nameLbl = (UITextField*)[self.view viewWithTag:1000];
    UITextField* teleLbl = (UITextField*)[self.view viewWithTag:1001];
    UITextField*  addressLbl = (UITextField*)[self.view viewWithTag:1002];
    UITextField* detailLbl = (UITextField*)[self.view viewWithTag:1003];
    
    NSString* name = nameLbl.text;
    NSString* tele = teleLbl.text;
    NSString* address = addressLbl.text;
    NSString* fullAddress = detailLbl.text;
    
    if ([name isEqualToString:@""]||[tele isEqualToString:@""]||[address isEqualToString:@"无"]||[fullAddress isEqualToString:@""]){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"请完善所有信息后再添加!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancleAction];
        [self.navigationController presentViewController:alert animated:YES completion:^{
        }];
        
    }
    
    UpdateAddressOperator* updateOperator =[ [UpdateAddressOperator alloc]initWithParamsDic:@{@"action":@"editroute",@"region":_provinceName,@"city":_cityName,@"qu":_regionName,@"full_address":fullAddress,@"phone":tele,@"name":name,@"aid":_aid,@"json":@"1" }];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:updateOperator withSuccessCallBack:^(BaseModel *model) {
        
        [self.navigationController popViewControllerAnimated:YES];
    } andFaildCallBack:^(id response) {
        
    }];
}
#pragma mark - 请求 显示一条详细地址信息
/**
 新 http://www.taojiuhui.cn/home/Api/manageopenapi?action=fetchroute&aid=51&json=1
 */
- (void)getDetailData{
    GetDetailDataOperator* getOperator = [[GetDetailDataOperator alloc]initWithParamsDic:@{@"action":@"fetchroute",@"aid":_aid,@"json":@"1"}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:getOperator withSuccessCallBack:^(BaseModel *model) {
        
        _detailData = getOperator.detailData;
        
        [_tableView reloadData];
        
    } andFaildCallBack:^(id response) {
        
    }];
}
#pragma mark - CityPickerViewDelegate

- (void)CityPickerViewDidPickProvince:(NSString *)provincecode City:(NSString *)citycode Area:(NSString *)areacode cityallname:(NSString *)name proviceName:(NSString *)provicename cityName:(NSString *)cityname areaName:(NSString *)areaname
{
    [self.returnedUserIndoDic setValue:provincecode forKey:@"provinceCode"];
    [self.returnedUserIndoDic setValue:citycode forKey:@"cityCode"];
    [self.returnedUserIndoDic setValue:areacode forKey:@"regionCode"];
    
    self.address = name;
    
    _flag = @"change";
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


#pragma mark - Public
-(void)pressRight:(id)sender{
    
    [self requestDelAddress];
}


- (IBAction)saveEdit:(UIButton *)sender {

     [self requestUpdateAddress];
//    if (_address == nil || ) {
//        
//        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"您未修改任何信息,请修改后保存" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        [alert addAction:cancleAction];
//        [self.navigationController presentViewController:alert animated:YES completion:^{
//        }];
//
//    }
//    else{
//       
//
//    }
    
}
@end

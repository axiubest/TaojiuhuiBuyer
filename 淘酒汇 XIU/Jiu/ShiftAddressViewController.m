//
//  ShiftAddressViewController.m
//  Jiu
//
//  Created by Molly on 16/2/15.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "ShiftAddressViewController.h"
#import "GetAddressOperator.h"
#import "NetworkingManager.h"
#import "ShiftAddressOperator.h"
@interface ShiftAddressViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSMutableArray* tableData;

@end

@implementation ShiftAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 请求切换地址
/**http://www.taojiuhui.cn/home/Api/manageopenapi?action=shiftroute&uid=50&aid=108&json=1
*/
- (void)requestSetDefaultAddress:(UIButton*)sender{

    ShiftAddressOperator* shiftAddressOperator = [[ShiftAddressOperator alloc] initWithParamsDic:@{@"action":@"shiftroute",@"uid":@"73"}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:shiftAddressOperator withSuccessCallBack:^(BaseModel *model) {
        
        NSLog(@"--------%@------请求成功----------",@"设置默认地址");
        
    } andFaildCallBack:^(id response) {
        
    }];
}

#pragma mark - 请求 我的地址
/**
 http://www.taojiuhui.cn/home/Api/manageopenapi?action=routelist&uid=29&json=1
 */
- (void)requestAddress{
    GetAddressOperator* addressOperator = [[GetAddressOperator alloc]initWithParamsDic:@{@"action":@"routelist",@"uid":[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],@"json":@"1"}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:addressOperator withSuccessCallBack:^(BaseModel *model) {
        _tableData = addressOperator.tableData;
        [_tableView reloadData];
        NSLog(@"--------%@------请求成功----------",@"我的地址");
    } andFaildCallBack:^(id response) {
        
    }];
}

@end

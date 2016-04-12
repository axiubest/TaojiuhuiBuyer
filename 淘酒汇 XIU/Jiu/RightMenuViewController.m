//
//  RightMenuViewController.m
//  Jiu
//
//  Created by 张熔冰 on 15/10/21.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "RightMenuViewController.h"

@interface RightMenuViewController (){
    NSArray* jiuData;
    NSArray* pinpaiData;
    NSArray* jiageData;
    NSArray* xiangxingData;
    NSArray* dushuData;
}

@end

@implementation RightMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"筛选";
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem* leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(pressLeftBtn:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UIBarButtonItem* rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(pressLeftBtn:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    [_btn.layer setBorderColor:[UIColor redColor].CGColor];
    [_btn.layer setBorderWidth:1.f];
    _tableData = @[@"酒类",@"品牌",@"价格",@"香型",@"度数"];
    jiuData = @[@"全部",@"白酒",@"啤酒",@"葡萄酒",@"保健酒",@"洋酒",@"饮料",@"其他"];
    pinpaiData = @[@"全部",@"五粮液",@"泸州老窖",@"山河",@"牛栏山"];
    jiageData = @[@"全部",@"0-299",@"300-699",@"700-1199"];
    xiangxingData = @[@"全部",@"鼓香型",@"凤香型"];
    dushuData = @[@"全部",@"35度以下", @"35-39度"];
}

#pragma mark - UITableViewDetegory
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
    cell.detailTextLabel.text = @"全部";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PublicListViewController* controller = [[PublicListViewController alloc] initWithNibName:@"PublicListViewController" bundle:nil];
    NSArray* tempArr = nil;
    switch (indexPath.row) {
        case 0:
            tempArr = jiuData;
            break;
        case 1:
            tempArr = pinpaiData;
            break;
        case 2:
            tempArr = jiageData;
            break;
        case 3:
            tempArr = xiangxingData;
            break;
        case 4:
            tempArr = dushuData;
        default:
            break;
    }
    if ([controller respondsToSelector:@selector(setTableData:)]) {
        [controller setTableData:tempArr];
    }
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)pressLeftBtn:(id)sender{
    _didSelectedCancel();
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

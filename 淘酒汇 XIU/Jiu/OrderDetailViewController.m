//
//  OrderDetailViewController.m
//  Jiu
//  订单详情
//  Created by 张熔冰 on 15/10/24.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "DetailOrder1TableViewCell.h"
#import "DetailOrder2TableViewCell.h"
#import "FillInOrderRow2TableViewCell.h"
#import "FillInOrderRow3TableViewCell.h"
#import "Order.h"
@interface OrderDetailViewController ()
@property(strong,nonatomic)Order* order;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    
    _order = [[Order alloc] init];
    _tableData = @[@[@""], @[@"",@""], @[@""], @[@"优惠券",@"消费积分"], @[@"商品金额", @"运费"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_tableData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tableData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell* cell = nil;
//    if (indexPath.section == 0) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailOrder1TableViewCell" owner:self options:nil] lastObject];
//    }else if (indexPath.section == 1 && indexPath.row ==0){
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailOrder2TableViewCell" owner:self options:nil] lastObject];
//    }else if(indexPath.section == 1 && indexPath.row ==1){
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"FillInOrderRow2TableViewCell" owner:self options:nil] lastObject];
//    }else if(indexPath.section == 2){
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"FillInOrderRow3TableViewCell" owner:self options:nil] lastObject];
//    }else if(indexPath.section == 3){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
//        [cell.textLabel setText:_tableData[indexPath.section][indexPath.row]];
//        [cell.detailTextLabel setText:@"未使用"];
//    }else if(indexPath.section == 4){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
//        [cell.textLabel setText:_tableData[indexPath.section][indexPath.row]];
//        [cell.detailTextLabel setText:@"￥0.00"];
//        [cell.detailTextLabel setTextColor:[UIColor redColor]];
//    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    return cell;
    
    NSString* cellIdentifier = @"cell";
    
    if (indexPath.section ==0) {
        DetailOrder1TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailOrder1TableViewCell" owner:self options:nil] lastObject];
        
    }
    else if(indexPath.section == 2){
        FillInOrderRow3TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = (FillInOrderRow3TableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"FillInOrderRow3TableViewCell" owner:nil options:nil] lastObject];
        }
        
//        [cell.selectBtn addTarget:self action:@selector(pressSelectBtn:)  forControlEvents:UIControlEventTouchUpInside];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        return cell;
    }
    else if (indexPath.section ==1){
        
        if (indexPath.row==0) {
            DetailOrder2TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = (DetailOrder2TableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"DetailOrder2TableViewCell" owner:nil options:nil] lastObject];
            }
            return cell;

        }else{
            FillInOrderRow2TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = (FillInOrderRow2TableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"FillInOrderRow2TableViewCell" owner:nil options:nil] lastObject];
            }
            return cell;
        }
    }
    else if(indexPath.section == 3){
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell.textLabel setText:_tableData[indexPath.section][indexPath.row]];
        [cell.detailTextLabel setText:@"未使用"];
        return cell;
        
    }
    else{
        //(indexPath.section == 4)
        NSString* priceStr = @"￥0.00";
        if (indexPath.row == 0) {
            priceStr = [NSString stringWithFormat:@"￥%@",_order.total_fee];
        }
       UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell.textLabel setText:_tableData[indexPath.section][indexPath.row]];
        [cell.detailTextLabel setText:priceStr];
        [cell.detailTextLabel setTextColor:[UIColor redColor]];
        return cell;
        
    }
    return nil;
//
//    else
//    {
//        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
//        if (indexPath.section ==1){
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"FillInOrderRow2TableViewCell" owner:self options:nil] lastObject];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            
//        }else if(indexPath.section == 3){
//            NSString* text = _tableData[indexPath.section][indexPath.row];
//            cell.textLabel.text = text;
//            cell.detailTextLabel.text = @"未使用";
//            [cell.detailTextLabel setTextColor:[UIColor blackColor]];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }else if (indexPath.section == 4 && indexPath.row == 0){
//            NSString* text = _tableData[indexPath.section][indexPath.row];
//            cell.textLabel.text = text;
//            cell.detailTextLabel.text =[NSString stringWithFormat:@"￥%@",_totalPrice];
//            [cell.detailTextLabel setTextColor:[UIColor redColor]];
//        }
//        else if (indexPath.section == 4 && indexPath.row == 1){
//            NSString* text = _tableData[indexPath.section][indexPath.row];
//            cell.textLabel.text = text;
//            cell.detailTextLabel.text = @"￥0.00";
//            [cell.detailTextLabel setTextColor:[UIColor redColor]];
//        }
//        return cell;
//    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(8, 0, kScreenWidth, 40)];
    [view setBackgroundColor:[UIColor whiteColor]];
    UIButton* checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 4, 32, 32)];
    [checkBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [checkBtn setImage:[UIImage imageNamed:@"check-selected"] forState:UIControlStateSelected];
    [view addSubview:checkBtn];
    
    UIImageView* locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 10, 20, 20)];
    [locationImageView setImage:[UIImage imageNamed:@"location-black"]];
    [view addSubview:locationImageView];
    
    UILabel* locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [locationLabel setFitText:@"沈阳" font:[UIFont systemFontOfSize:16.f]];
    [locationLabel setTextColor:[UIColor blackColor]];
    CGRect rect = locationLabel.frame;
    rect.origin.x = 60;
    rect.origin.y = (40-rect.size.height)/2;
    [locationLabel setFrame:rect];
    [view addSubview:locationLabel];
    
    UIImageView* arrowsRightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationLabel.x+locationLabel.width+5, 12.5, 15, 15)];
    [arrowsRightImageView setImage:[UIImage imageNamed:@"arrows-right-black"]];
    [view addSubview:arrowsRightImageView];
    if (section == 1) {
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 113.f;
    }else if(indexPath.section == 1 && indexPath.row == 0){
        return 80;
    }else if(indexPath.section == 2){
        return 90;
    }
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 40.f;
    }
    return 0.1f;
}

#pragma mark - 请求订单详情
- (void)requestOrderDetail{

}


@end

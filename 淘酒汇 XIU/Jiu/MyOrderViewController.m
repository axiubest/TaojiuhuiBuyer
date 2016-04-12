//
//  MyOrderViewController.m
//  Jiu
//
//  Created by zhangrongbing on 15/9/15.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderTableViewCell.h"
#import "GetOrderOperator.h"
#import "OrderModel.h"
#import "NetworkingManager.h"

@interface MyOrderViewController ()
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIButton *waitPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *waitGoodsBtn;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
- (IBAction)pressAllBtn:(UIButton *)sender;
- (IBAction)pressWaitPayBtn:(UIButton *)sender;
- (IBAction)pressWaitGoodsBtn:(UIButton *)sender;
- (IBAction)pressFinishBtn:(UIButton *)sender;

@property(nonatomic,strong)NSMutableArray* statusViewArr;
@property(nonatomic,strong)NSString* status;
@end

@implementation MyOrderViewController

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
    self.title = @"我的订单";
    
    _statusViewArr = [NSMutableArray array];
    [self createStatusView];
    
    _status = @"1";
    [self requestOrder];
    
    _tableView.tableFooterView = [[UIView alloc]init];
}


#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return [_tableData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   // return [_tableData[section] count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"cell";
    MyOrderTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = (MyOrderTableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"MyOrderTableViewCell" owner:nil
                                                                   options:nil] lastObject];
        cell.selectionStyle = 0;
    }
    
    OrderModel* orderModel = _tableData[indexPath.section];
    int count = 0;
    if ([orderModel.price intValue] != 0) {
        count = [orderModel.pay_price intValue]/[orderModel.price intValue];;
    }
    
    cell.price.text = orderModel.price;
    cell.title.text = orderModel.title;
    cell.goodsCountLbl.text = [[NSString alloc]initWithFormat:@"*%d",count];
    cell.countLbl.text = [[NSString alloc]initWithFormat:@"共%d件商品",count ];
    cell.payPrice.text = [[NSString alloc]initWithFormat:@"合计:￥%@",orderModel.pay_price];
    cell.orderId = orderModel.orderid;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 208.f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(8, 0, kScreenWidth, 40)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView* locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 10, 20, 20)];
    [locationImageView setImage:[UIImage imageNamed:@"location-black"]];
    [view addSubview:locationImageView];
    
    UILabel* locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [locationLabel setFitText:@"沈阳" font:[UIFont systemFontOfSize:16.f]];
    [locationLabel setTextColor:[UIColor blackColor]];
    CGRect rect = locationLabel.frame;
    rect.origin.x = 30;
    rect.origin.y = (40-rect.size.height)/2;
    [locationLabel setFrame:rect];
    [view addSubview:locationLabel];
    
    UIImageView* arrowsRightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationLabel.x+locationLabel.width+5, 12.5, 15, 15)];
    [arrowsRightImageView setImage:[UIImage imageNamed:@"arrows-right-black"]];
    [view addSubview:arrowsRightImageView];
    OrderModel* orderModel = _tableData[section];
    NSString* statusStr = orderModel.status;
    switch ([statusStr intValue]) {
        case 2:{
            statusStr = @"待付款";
            break;
        }
        case 3:{
            statusStr = @"待发货";
            break;
        }
        case 4:{
            statusStr = @"已完成";
            break;
        }

        default:
            break;
    }
    UILabel* statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 80-8, 0, 80, 40)];
    [statusLabel setText:statusStr];
    [statusLabel setTextAlignment:NSTextAlignmentRight];
    [statusLabel setTextColor:[UIColor redColor]];
    [view addSubview:statusLabel];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;{
    return 40;
}


#pragma mark  tableViewCell点击方法 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderDetailViewController* controller = [[ OrderDetailViewController alloc] initWithNibName:@"OrderDetailViewController" bundle:nil];
    controller.orderId = ((MyOrderTableViewCell* )[tableView cellForRowAtIndexPath:indexPath]).orderId;

    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark - public
- (void)createStatusView{
    
    CGFloat y = _allBtn.frame.origin.y+_allBtn.frame.size.height;
    CGFloat width = 64.f;
    CGFloat heigth = 6.f;
    
    UIView* allStatusView = [[UIView alloc]initWithFrame:CGRectMake(_allBtn.frame.origin.x, y, width, heigth)];
    allStatusView.backgroundColor = [UIColor redColor];
    _allBtn.tag = 1;
    allStatusView.tag = _allBtn.tag + 10;
    [_statusViewArr addObject:allStatusView];
    [_statusView addSubview:allStatusView];
    
    UIView* waitPayView = [[UIView alloc]initWithFrame:CGRectMake(_waitPayBtn.frame.origin.x, y, width, heigth)];
    waitPayView.backgroundColor = [UIColor clearColor];
    _waitPayBtn.tag = 2;
    waitPayView.tag = _waitPayBtn.tag + 10;
    [_statusViewArr addObject:waitPayView];
    [_statusView addSubview:waitPayView];
    
    UIView* waitGoodsView = [[UIView alloc]initWithFrame:CGRectMake(_waitGoodsBtn.frame.origin.x, y, width, heigth)];
    waitGoodsView.backgroundColor = [UIColor clearColor];
    _waitGoodsBtn.tag = 3;
    waitGoodsView.tag = _waitGoodsBtn.tag + 10;
    [_statusViewArr addObject:waitGoodsView];
    [_statusView addSubview:waitGoodsView];
    
    UIView* finishView = [[UIView alloc]initWithFrame:CGRectMake(_finishBtn.frame.origin.x, y, width, heigth)];
    finishView.backgroundColor = [UIColor clearColor];
    _finishBtn.tag = 4;
    finishView.tag = _finishBtn.tag + 10;
    [_statusViewArr addObject:finishView];
    [_statusView addSubview:finishView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)pressAllBtn:(UIButton *)sender {
    _status = @"1";
    [self pressStatusBtn:sender];
}

- (IBAction)pressWaitPayBtn:(UIButton *)sender {
     _status = @"2";
    [self pressStatusBtn:sender];
}

- (IBAction)pressWaitGoodsBtn:(UIButton *)sender {
    _status = @"3";
    [self pressStatusBtn:sender];
}

- (IBAction)pressFinishBtn:(UIButton *)sender {
    _status = @"4";
    [self pressStatusBtn:sender];
}

- (void)pressStatusBtn:(UIButton *)pressedBtn{
    
    for (UIView* v in self.statusViewArr) {
        if (v.tag != pressedBtn.tag+10) {
           [v setBackgroundColor:[UIColor clearColor]];
        }
        else{
            [v setBackgroundColor:[UIColor redColor]];
        }
    }
    
    [self requestOrder];
}
#pragma mark - requestOrder请求订单信息
/**
 http://www.taojiuhui.cn/home/Api/manageopenapi?action=order&uid=24&agentid=1&status=1&json=1
 */
- (void)requestOrder{
    NSString* agentId = [[NSUserDefaults standardUserDefaults] objectForKey:@"agentId"];
    GetOrderOperator* orderOperator = [[GetOrderOperator alloc]initWithParamsDic:@{@"action":@"order",@"uid":_uid,@"agentid":agentId,@"status":_status,@"json":@"1"}];
    NSLog(@"%@🍎", _uid);
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:orderOperator withSuccessCallBack:^(BaseModel *model) {
        
        _tableData = orderOperator.orderArrs;
        [_tableView reloadData];
    } andFaildCallBack:^(id response) {
        
    }];
}
@end

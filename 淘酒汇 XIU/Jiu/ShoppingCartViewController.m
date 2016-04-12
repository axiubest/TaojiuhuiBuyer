//
//  ShoppingCartViewController.m
//  Jiu
//
//  Created by 张熔冰 on 15/9/13.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingTableViewCell.h"

#import "GetSubmitOrderOperator.h"
#import "GetCartCountOperator.h"
#import "GetCartOperator.h"
#import "SelOneGoodsOperator.h"
#import "SelectAllGoodsOperator.h"
#import "NetworkingManager.h"

#import "CartJiuModel.h"
#import "IsLogin.h"

#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"


#import "AddressViewController.h"
#import "XIUShoppingListModel.h"
@interface ShoppingCartViewController (){
    int count;
    double _totalPrice;
    bool _allSelected;
}
@property (weak, nonatomic) IBOutlet UIButton *selectAllBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLbl;
@property(strong,nonatomic)NSMutableArray* selectAddressBtnArr;
@property(nonatomic,strong)NSMutableArray* selectGoodsBtnArr;
@property(nonatomic,strong)NSMutableArray* cartGoodsArr;

@property(nonatomic,strong)NSString* uid;
@property(nonatomic,strong)NSString* agentId;
@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;
    
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    self.navigationItem.rightBarButtonItem.title = @"编辑";
    

    
    
    self.selectAddressBtnArr = [[NSMutableArray alloc]init];
    self.selectGoodsBtnArr = [[NSMutableArray alloc]init];
    self.cartGoodsArr= [NSMutableArray array];

    

    self.title = @"购物车";
    _tableView.tableFooterView = [[UIView alloc]init];
    
    if ([_flag isEqualToString:@"1"]) {
        UIBarButtonItem* leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrows-left-selected"] style:UIBarButtonItemStylePlain target:self action:@selector(pressCancleBtn:)];
        self.navigationItem.leftBarButtonItem = leftBtn;
    }
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView setEditing:NO];
    
    IsLogin* login = [[IsLogin alloc]init];
    
    NSString* uid = [login isLoginIn:self.navigationController];
    if (![uid isEqualToString:@""]) {
        _uid = uid;
    }else{
        return;
    }
    
    _uid = [[NSUserDefaults standardUserDefaults]objectForKey:@"uid"];
    
    _agentId = [[NSUserDefaults standardUserDefaults]objectForKey:@"agentId"];
    _totalPrice = 0.0;
    _allSelected = YES;
    
    
    
    [self requestShoppingCart];
}
#pragma mark - 请求 选择所有商品
/**http://www.taojiuhui.cn/home/Api/manageopenapi?action=choosen_all&uid=26&agentid=1&status=1
 
 * 新 http://www.taojiuhui.cn/home/Api/manageopenapi?action=choose_all&uid=&agentid=&status=1
 
 1为空 ,2为选中
 
 */
- (void)requestSelectedAllGoods:(NSString*)status{

    SelectAllGoodsOperator* allGoodsOperator = [[SelectAllGoodsOperator alloc]initWithParamsDic:@{@"action":@"choose_all",@"uid":_uid,@"agentid":_agentId,@"status":status}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:allGoodsOperator withSuccessCallBack:^(BaseModel *model) {
        
        double totalPrice = 0.00;

        if ([status isEqualToString:@"2"]) {
            for (UIButton* sender in self.selectGoodsBtnArr) {
                ShoppingTableViewCell* cell = (ShoppingTableViewCell*) [[sender superview] superview];
                double price = [[cell.goodPriceLbl.text substringFromIndex:1] doubleValue];
                int countNum = [cell.countLabel.text intValue];
                totalPrice += price*countNum;
            }
        }
        _totalPriceLbl.text = [NSString stringWithFormat:@"%.2f",totalPrice];
        NSLog(@"--------%@成功--------",@"选择购物车所有商品");
    } andFaildCallBack:^(id response) {
        
    }];
}
#pragma mark - 请求获取购物车信息
/**
新http://www.taojiuhui.cn/home/Api/manageopenapi?action=cart&uid=29&agentid=1&json=1
 */
- (void)requestShoppingCart{
    GetCartOperator* cartOperator = [[GetCartOperator alloc]initWithParamsDic:@{@"action":@"cart",@"agentid":_agentId,@"uid":_uid,@"json":@"1"}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:cartOperator withSuccessCallBack:^(BaseModel *model) {
      
        self.cartGoodsArr = cartOperator.cartGoodsArr;

        [_tableView reloadData];
        
        if([self.cartGoodsArr count] == 0){
            _selectAllBtn.selected = NO;
        }
        NSLog(@"--------获取%@--------",@"购物车信息成功");
        if ([cartOperator.cartGoodsArr count] == 0) {
            _totalPriceLbl.text = [NSString stringWithFormat:@"%.2f",0.00];
        }
    } andFaildCallBack:^(id response) {
        
    }];
}



#pragma mark - 请求 选择一个购物车
/**
新  http://www.taojiuhui.cn/home/Api/manageopenapi?action=choosen&cartid=1&status=&json=1
 *没有返回值 ,cartid是购物车id
 
cartid  [NSString stringWithFormat:@"%ld",cell.selectGoodsBtn.tag]
 */
- (void)requestSelectedOneGoods:(UIButton*)sender{

    NSString* status = @"";
    if(sender.selected){
        status = @"1";
    }else{
        status = @"0";
    }
    SelOneGoodsOperator* oneGoodsOperator = [[SelOneGoodsOperator alloc]initWithParamsDic:@{@"action":@"choosen",@"cartid":[NSString stringWithFormat:@"%ld",(long)sender.tag],@"json":@"1",@"status":status}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:oneGoodsOperator withSuccessCallBack:^(BaseModel *model) {
        NSString* ret = oneGoodsOperator.ret;
        
        if ([ret isEqualToString:@"1"]) {
           ShoppingTableViewCell* cell = (ShoppingTableViewCell*) [[sender superview] superview];
            double price = [[cell.goodPriceLbl.text substringFromIndex:1] doubleValue];
             count = [cell.countLabel.text doubleValue];
            double total = 0;
            if (sender.selected) {
                 total = price*count + [_totalPriceLbl.text doubleValue];
            }else{
                 total = [_totalPriceLbl.text doubleValue] - price*count;
            }
           
            _totalPriceLbl.text = [NSString stringWithFormat:@"%.2f",total];
        }
        NSLog(@"--------%@成功--------",@"选择一个购物车");
    } andFaildCallBack:^(id response) {
        
    }];

    
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cartGoodsArr count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"cell";
    ShoppingTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = (ShoppingTableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"ShoppingTableViewCell" owner:nil options:nil] lastObject];
    }
    if (self.cartGoodsArr != nil) {
        CartJiuModel* jiuModel = _cartGoodsArr[indexPath.row];

        [cell.goodImg setImageWithURL:[NSURL URLWithString:jiuModel.image]];
        cell.goodTitleLbl.text = jiuModel.title;
        cell.goodPriceLbl.text = [[NSString alloc]initWithFormat:@"￥%@",jiuModel.price];
        cell.countLabel.text = jiuModel.count;
        cell.selectGoodsBtn.tag = [jiuModel.cartid intValue];
        cell.gid = jiuModel.gid;
        
        if ([jiuModel.status isEqualToString:@"1"]) {
            cell.selectGoodsBtn.selected = YES;
    
            double price = [jiuModel.price doubleValue];
            int countNum = [jiuModel.count intValue];
            _totalPrice += price*countNum;
        }else{
            _allSelected = NO;
        }
        
        if(indexPath.section == (self.cartGoodsArr.count - 1)){
            _totalPriceLbl.text = [NSString stringWithFormat:@"%.2f",_totalPrice];
            if ([self.cartGoodsArr count]>0) {
                _selectAllBtn.selected = _allSelected;
            }
            
        }
    }
    [cell.additionBtn addTarget:self action:@selector(pressAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.subtractionBtn addTarget:self action:@selector(pressSubBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectGoodsBtn addTarget:self action:@selector(selectOneChart:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectGoodsBtnArr addObject:cell.selectGoodsBtn];
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(8, 0, kScreenWidth, 40)];
    [view setBackgroundColor:[UIColor whiteColor]];
//    UIImageView* locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 20, 20)];
//    [locationImageView setImage:[UIImage imageNamed:@"location-black"]];
//    [view addSubview:locationImageView];
    
    UILabel* locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [locationLabel setFitText:@"沈阳" font:[UIFont systemFontOfSize:16.f]];
    [locationLabel setTextColor:[UIColor blackColor]];
    CGRect rect = locationLabel.frame;
    rect.origin.x = 8;
    rect.origin.y = (40-rect.size.height)/2;
    [locationLabel setFrame:rect];
    [view addSubview:locationLabel];
    
    UIImageView* arrowsRightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationLabel.x+locationLabel.width+5, 12.5, 15, 15)];
    [arrowsRightImageView setImage:[UIImage imageNamed:@"arrows-right-black"]];
    [view addSubview:arrowsRightImageView];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
#pragma mark - public
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)pressCancleBtn:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)pressSettlementBtn:(id)sender {
    
    if(![_totalPriceLbl.text isEqualToString:@"0.00"]){
          [self requestSubmitOrder];
    }
  
}

- (IBAction)pressSelectAllBtn:(UIButton *)sender {
    count = 0;
    bool selectStatus = !sender.selected;
    sender.selected = selectStatus;
    
    for (UIButton* goodsBtn in self.selectGoodsBtnArr) {
        goodsBtn.selected = selectStatus;
    }
    if(selectStatus){
        //全选
        NSString* status = @"2";
        [self requestSelectedAllGoods:status];
    }
    else{
        //取消全选
        NSString* status = @"1";
        [self requestSelectedAllGoods:status];
    }
}
- (void)selectOneChart:(UIButton*)sender{
    
    sender.selected = !sender.selected;
    
    bool selected = YES;
    for (UIButton* goodsBtn in self.selectGoodsBtnArr) {
        if (!goodsBtn.selected) {
            selected = NO;
        }
    }
    _selectAllBtn.selected = selected;

    [self requestSelectedOneGoods:sender];
}

- (void)pressAddBtn:(UIButton *)sender {
    NSString* action = @"1";
    [self requestUpadteCount:action pressBtn:sender];
}

- (void)pressSubBtn:(UIButton *)sender {
    NSString* action = @"-1";
    [self requestUpadteCount:action pressBtn:sender];
}
#pragma mark - 请求 结算
/**
 http://www.taojiuhui.cn/home/Api/manageopenapi?action=checkout&uid=29&agentid=1&json=1
新 http://www.taojiuhui.cn/home/Api/manageopenapi?action=checkout&agentid=1&uid=29&json=1
 */
- (void)requestSubmitOrder{
    
    GetSubmitOrderOperator* submitOperator = [[GetSubmitOrderOperator alloc]initWithParamsDic:@{@"action":@"checkout",@"uid":_uid,@"agentid":_agentId,@"json":@"1"}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:submitOperator
   withSuccessCallBack:^(BaseModel *model) {
       
       
       FillInOrderViewController* controller = [[FillInOrderViewController alloc] init];
       controller.order = submitOperator.order;
       
//       地址判断，  如果没有设置默认地址，那么order.address为空，传入会报错，
//       if ([submitOperator.order.defaultAddress.city isEqualToString:@""] && [submitOperator.order.defaultAddress.fullAddress isEqualToString:@""]) {
//           
//           [self showInfo:@"请设置默认收货地址"];
//           
//           AddressViewController *add = [[AddressViewController alloc] init];
//           [self.navigationController pushViewController:add animated:YES];
//       }else {
           controller.totalPrice = _totalPriceLbl.text;
           [self.navigationController pushViewController:controller animated:YES];
//       }

   } andFaildCallBack:^(id response) {
       
   }];

}
#pragma mark - 请求增加或减少商品数量
/**请求 增加或减少商品数量--Action 1为增加 0为减少 count数量 cartid购物车id
 *http://www.taojiuhui.cn/home/Api/manageopenapi?action=updatecart&act=1&json=1&cartid=1
 
 
 * 新http://www.taojiuhui.cn/home/Api/manageopenapi?action=add_cart&gid=29&agentid=1&uid=70&count=-1&json=1
 
 count是数量
 
 1是加 -1是减
 */
-(void)requestUpadteCount:(NSString*)action pressBtn:(UIButton*)sender{
    
    ShoppingTableViewCell* cell = (ShoppingTableViewCell*) [[[sender superview] superview] superview];
     NSLog(@"-----%@",cell.countLabel.text);
    count = [cell.countLabel.text intValue];
   
    if (count == 0) {
        [cell.subtractionBtn setUserInteractionEnabled:NO];
    }else{
        [cell.subtractionBtn setUserInteractionEnabled:YES];
    }
    if (count!=0) {

        NSString* gid = cell.gid;
        
        GetCartCountOperator* cartOperator = [[GetCartCountOperator alloc]initWithParamsDic:@{@"action":@"add_cart",@"count":action,@"gid":gid,@"agentid":_agentId,@"uid":_uid,@"json":@"1"}];
        NetworkingManager* manager = [NetworkingManager sharedInstance];
        [manager asyncTask:cell.countLabel withOperator:cartOperator withSuccessCallBack:^(BaseModel *model) {
            if([cartOperator.code isEqual:@"1"]){
                
                double price = [[cell.goodPriceLbl.text substringFromIndex:1] doubleValue];
                double total = [_totalPriceLbl.text doubleValue];

                if ([action isEqual:@"1"]) {
                    if (cell.selectGoodsBtn.selected) {
                        total += price;
                    }
                    count++;
                }
                if ([action isEqual:@"-1"]) {
                    if (cell.selectGoodsBtn.selected) {
                        total -= price;
                    }
                    count--;
                }
           
                if (cell.selectGoodsBtn.selected) {
                    _totalPriceLbl.text = [NSString stringWithFormat:@"%.2f",total];

                }

                cell.countLabel.text = [NSString stringWithFormat:@"%d",count];
            }
            
            
        } andFaildCallBack:^(id response) {
            
        }];
        
    }
    
}


#pragma mark   tableView编辑

//-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
//    [super setEditing:editing animated:YES];
//    if (editing) {
//        self.navigationItem.rightBarButtonItem.title = @"完成";
//        [self.tableView setEditing:editing animated:YES];
//    }else{
//        self.navigationItem.rightBarButtonItem.title = @"编辑";
//        [self.tableView setEditing:editing animated:YES];
//        
//    }
//}
//-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return 1;
//}
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//
//        [self.cartGoodsArr removeObjectAtIndex:indexPath.row];
//        
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
//
//        [_tableView reloadData];
//        [self deleteDataSourceOfCollectionListForRowIndexPath:(NSIndexPath *)indexPath];
//        
//    }
//    }
//
//
///**
// 删除购物车产品接口
// http://www.taojiuhui.cn/home/Api/manageopenapi?action=del_cart&cartid=752json=1
// */
//#pragma mark  删除购物车产品接口
//- (void)deleteDataSourceOfCollectionListForRowIndexPath:(NSIndexPath *)indexPath {
//    IsLogin* login = [[IsLogin alloc]init];
//    NSString* uid = [login isLoginIn:self.navigationController];
//    if (![uid isEqualToString:@""]) {
//        _uid = uid;
//    }else{
//        return;
//    }
//    
//    NSString *path = [NSString stringWithFormat:@"http://www.taojiuhui.cn/home/Api/manageopenapi?action=del_cart&cartid=%@json=1", [self.cartGoodsArr[indexPath.row] cartid]];
//
//    
//    NSString *urlString = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:path]];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];
//    
//    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSLog(@"-----------购物车删除成功----------");
//        
//    }
//     
//         failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
//             NSLog(@"购物车删除失败%@", error);
//         }];
//
//}





#pragma mark - public
-(void)showInfo:(NSString* )infoStr{
    
    UILabel* lbl = [[UILabel alloc]init];
    lbl.text = infoStr;
    lbl.font = [UIFont systemFontOfSize:10.f];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor whiteColor];
    lbl.backgroundColor = [UIColor blackColor];
    lbl.frame = CGRectMake(0, 0, 150, 50);
    lbl.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    lbl.alpha = 0.0;
    
    [self.view addSubview:lbl];
    [UIView animateWithDuration:1.0 animations:^{
        lbl.alpha = 0.7;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            lbl.alpha = 0.0;
        } completion:^(BOOL finished) {
            [lbl removeFromSuperview];
            
        }];
        
    }];
}

@end

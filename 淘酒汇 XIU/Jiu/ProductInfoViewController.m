//
//  ProductInfoViewController.m
//  PagingDemo
//
//  Created by Liu jinyong on 15/8/6.
//  Copyright (c) 2015年 Baidu 91. All rights reserved.
//


/**
wrong    
    此页面设计有误， 点击进入此页面后， 会加载所有信息， 如果用户不下拉，数据元素， 图片请求依然会进行， 流量消耗大，
    是否阻塞线程待定
 
    更改：
    界面搭建在数据请求之前， 既框架先搭建， 数据之后铺到View中
 */



#import "ProductInfoViewController.h"
#import "UIScrollView+JYPaging.h"
#import "ProductDetailViewController.h"
#import "UIView+Frame.h"
#import "UILabel+Addition.h"
#import "UIButton+Image.h"
#import "UIImageView+AFNetworking.h"

#import "GetGoodsInfoOperator.h"
#import "GetCollectOperator.h"
#import "GetCancleOperator.h"
#import "AddChartOperator.h"
#import "NetworkingManager.h"
#import "AFNetworking.h"

#import "MainNavController.h"
#import "ShoppingCartViewController.h"
#import "GetNowTime.h"
#import "IsLogin.h"

@interface ProductInfoViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(nonatomic,strong)HomeJiuModel* goodsInfoModel;
@property(nonatomic,strong)NSMutableArray* goodsDetailImageArr;
//@property(nonatomic,strong)NSDictionary* goodsDetailImageDict;
@property(nonatomic,strong)NSArray* paraArr;

@property(nonatomic,strong)NSString* uid;

@end

@implementation ProductInfoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品详情";
   
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;
    
    UIBarButtonItem* leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrows-left-selected"] style:UIBarButtonItemStylePlain target:self action:@selector(pressCancleBtn:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    _scrollView.scrollEnabled = YES;
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
//    UIView* topView = [self generateTopView];
//    [_scrollView addSubview:topView];
//
//    _scrollView.contentSize = CGSizeMake(0, topView.height);
//    
//    ProductDetailViewController *detailVC = [[ProductDetailViewController alloc] init];
//    [self addChildViewController:detailVC];
//    
//    if (detailVC.view != nil) {
//        _scrollView.secondScrollView = detailVC.scrollView;
//    }
    
    [self requestGoodsInfo];
    

}


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
- (void)creatTabbar{
    UIView* tabBar = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-118, kScreenWidth, 54)];
    tabBar.backgroundColor = [UIColor blackColor];
    tabBar.alpha = 0.8;
    [self.view addSubview:tabBar];

    CGFloat btnWidth = kScreenWidth/3;
    UIButton* contactBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, btnWidth,44)];
    [contactBtn setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [contactBtn setWhiteTitle:@"联系我们"];
    [contactBtn addTarget:self action:@selector(pressContactBtn:) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:contactBtn];
    UIButton* shopChartBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnWidth, 0, btnWidth, 54)];
    [shopChartBtn setWhiteTitle:@"购物车"];
    [shopChartBtn setImage:[UIImage imageNamed:@"shopping"] forState:UIControlStateNormal];
    [shopChartBtn addTarget:self action:@selector(pressCartBtn:) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:shopChartBtn];
    
    UIButton* addChartBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnWidth*2, 0, btnWidth, 54)];
    [addChartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addChartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addChartBtn.backgroundColor = [UIColor redColor];
    [addChartBtn addTarget:self action:@selector(pressAddChartBtn:) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:addChartBtn];
}
-(UIView*) generateTopView{
    UIView* topView = [[UIView alloc] init];
    UIView* commodityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kCommodityViewHeight)];
    commodityView.backgroundColor = [UIColor whiteColor];
    UIImageView* commodityImageView = [[UIImageView alloc] initWithFrame:commodityView.frame];
    //[commodityImageView setImage:[UIImage imageNamed:@"commodity"]];
    //[commodityImageView setImage:self.goodsInfoModel.image1];
    NSString* urlStr = [[NSString alloc]initWithFormat:@"http://www.taojiuhui.cn/upload/%@",self.goodsInfoModel.image1];
    NSLog(@"url img - %@",urlStr);
    [commodityImageView setImageWithURL:[NSURL URLWithString:urlStr]];
    commodityImageView.contentMode = UIViewContentModeScaleAspectFit;
    commodityImageView.center = commodityView.center;
    [commodityView addSubview:commodityImageView];
    [topView addSubview:commodityView];
    //图片下方横线
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, commodityView.frame.size.height, kScreenWidth, 1)];
    [lineView setBackgroundColor:[UIColor grayColor]];
    [topView addSubview:lineView];
    
    UIView* commodityNameView = [[UIView alloc] initWithFrame:CGRectMake(0, lineView.frame.origin.y+1, kScreenWidth, kLableHeight*4)];
    UILabel* commodityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth- kScreenWidth*0.2, kLableHeight*3)];
    //[commodityNameLabel setText:@"53°茅台飞天500ml国酒茅台，传世飞天，限量抢购"];
    [commodityNameLabel setText:self.goodsInfoModel.title];
    commodityNameLabel.numberOfLines = 0;
    
    //价格
    UILabel* commodityPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(commodityNameLabel.x, commodityNameLabel.y+commodityNameLabel.height, commodityNameLabel.width, kLableHeight)];
    //[commodityPriceLabel setText:@"￥1000.00"];
    [commodityPriceLabel setText:[[NSString alloc]initWithFormat:@"￥%@",self.goodsInfoModel.price]];
    [commodityPriceLabel setTextColor:[UIColor redColor]];
    
    [commodityNameView addSubview:commodityPriceLabel];
    
    //关注左侧竖线
    UIView* lineView1 = [[UIView alloc] initWithFrame:CGRectMake(commodityNameLabel.frame.size.width, 0, 1, kLableHeight*4)];
    [lineView1 setBackgroundColor:[UIColor grayColor]];
    [commodityNameLabel addSubview:lineView1];
    [commodityNameView addSubview:commodityNameLabel];
    
    //收藏按钮
    UIButton* collectBtn = [[UIButton alloc] initWithFrame:CGRectMake(commodityNameLabel.frame.size.width+1, commodityNameLabel.frame.origin.y, kScreenWidth*0.2, commodityNameLabel.frame.size.height)];
    [collectBtn setMTitle:@"收藏"];
    [collectBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"collect-selected"] forState:UIControlStateSelected];
    [collectBtn setImage:[UIImage imageNamed:@"collect-selected"] forState:UIControlStateHighlighted];
    
    [collectBtn addTarget:self action:@selector(pressCollectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [commodityNameView addSubview:collectBtn];
    
    [topView addSubview:commodityNameView];
    
    //名字下边的边框
    UIView* lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, commodityNameView.frame.origin.y+commodityNameView.frame.size.height, kScreenWidth, 1)];
    [lineView2 setBackgroundColor:[UIColor grayColor]];
    [topView addSubview:lineView2];
    
    //团购view
    UIView* groupBuyingView = [[UIView alloc] initWithFrame:CGRectMake(0, lineView2.frame.origin.y+1, kScreenWidth, kLableHeight*3)];
    UILabel* groupBuyingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, groupBuyingView.frame.size.height)];
    [groupBuyingLabel setText:@"团购"];
    [groupBuyingLabel setTextColor:[UIColor darkGrayColor]];
    [groupBuyingView addSubview:groupBuyingLabel];
    UILabel* groupBuyContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, kScreenWidth-50, groupBuyingView.frame.size.height)];
    [groupBuyContentLabel setText:@"该商品目前享受团购价格"];
    [groupBuyingView addSubview:groupBuyContentLabel];
    
    //团购下方横线
    UIView* lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, groupBuyingView.frame.origin.y+groupBuyingView.frame.size.height+1, kScreenWidth, 1)];
    [lineView3 setBackgroundColor:[UIColor grayColor]];
    [topView addSubview:lineView3];
    
    //提示
    UIView* promptView = [[UIView alloc] initWithFrame:CGRectMake(0, lineView3.frame.origin.y+1, kScreenWidth, kLableHeight*3)];
    UILabel* promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, promptView.frame.size.height)];
    [promptLabel setText:@"提示"];
    [promptLabel setTextColor:[UIColor grayColor]];
    UILabel* promptContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, kScreenWidth-50, kLableHeight*3)];
    [promptContentLabel setText:@"支持7天无理由退货，支持货到付款"];
    [promptView addSubview:promptLabel];
    [promptView addSubview:promptContentLabel];
    [topView addSubview:promptView];
    [topView addSubview:groupBuyingView];
    //提示下方横线
    UIView* lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, promptView.frame.size.height+promptView.frame.origin.y, kScreenWidth, 1)];
    [lineView4 setBackgroundColor:[UIColor grayColor]];
    [topView addSubview:lineView4];
    
    float topHeight = lineView4.frame.size.height + lineView4.frame.origin.y;
    [topView setFrame:CGRectMake(0, 0, kScreenWidth, topHeight)];
    return topView;
}

- (void)pressContactBtn:(UIButton* )sender{
    
    //-----这里的判断条件有问题
//        if(self.goodsInfoModel.telephone == [NSNull null]){
//            [self showInfo:@"暂时没有联系电话!"];
//        }
    

    
            NSString* url = [NSString stringWithFormat:@"tel://%@",self.goodsInfoModel.telephone];
    if ([url isEqualToString:@""]) {
        [self showInfo:@"暂时没有联系电话!"];
    }else {
    
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
    
}
-(void)pressCollectBtn:(UIButton*)sender{

    sender.selected = (!sender.selected);
    
    if (sender.selected) {
        [self requestCollect];
    }
    else{
        [self requestCancleCollect];
    }
}

- (void)pressCancleBtn:(id*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pressCartBtn:(UIButton*)sender{
    IsLogin* login = [[IsLogin alloc]init];
    
    NSString* uid = [login isLoginIn:self.navigationController];
    if (![uid isEqualToString:@""]) {
        _uid = uid;
        ShoppingCartViewController* controller = [[ShoppingCartViewController alloc]init];
        MainNavController* navController = [[MainNavController alloc]initWithRootViewController:controller];
        controller.flag = @"1";
        [self presentViewController:navController animated:YES completion:nil];
    }
}
#pragma mark - 请求 商品详情
/**请求 商品详情
 *http://www.taojiuhui.cn/home/Api/manageopenapi?action=detail&gid=4&json=1
 */
- (void)requestGoodsInfo{

    self.goodsDetailImageArr = [[NSMutableArray alloc]init];
    self.goodsInfoModel = [[HomeJiuModel alloc]init];
    self.paraArr = [[NSArray alloc]init];

//    GetGoodsInfoOperator* getInfoOperator = [[GetGoodsInfoOperator alloc]initWithParamsDic:@{@"action":@"detail",@"gid":@"4",@"json":@"1"}];
    GetGoodsInfoOperator* getInfoOperator = [[GetGoodsInfoOperator alloc]initWithParamsDic:@{@"action":@"detail",@"gid":_gid,@"json":@"1"}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    [manager asyncTask:self.view withOperator:getInfoOperator withSuccessCallBack:^(BaseModel *model) {
        
        self.goodsInfoModel = getInfoOperator.goodsInfoModel;
        self.goodsDetailImageArr = getInfoOperator.goodsDetailImageArr;
        //self.goodsDetailImageDict = getInfoOperator.goodsDetailImageDict;
        self.paraArr = getInfoOperator.paraArr;
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        
#pragma mark  数据请求完成后铺数据
#warning !!!!!!!!!! viewController生命周期
        UIView *topView = [self generateTopView];
        [_scrollView addSubview:topView];
    
        _scrollView.contentSize = CGSizeMake(0, topView.height);
    
        ProductDetailViewController *detailVC = [[ProductDetailViewController alloc] init];
        
        [self addChildViewController:detailVC];
    
        if (detailVC.view != nil) {
            [detailVC addDetailImage:getInfoOperator.goodsDetailImageDict];
            _scrollView.secondScrollView = detailVC.scrollView;
        }

        
    } andFaildCallBack:^(id response) {
        
    }];
    
    
//    获取数据后铺到View上
        [self creatTabbar];
}


#pragma mark - 请求收藏
- (void)requestCollect{
    
    
    IsLogin* login = [[IsLogin alloc]init];
    
    NSString* uid = [login isLoginIn:self.navigationController];
    if (![uid isEqualToString:@""]) {
        _uid = uid;
    }else{
        return;
    }

    
    NSString *tep = @"http://www.taojiuhui.cn/home/Api/manageopenapi?";
    NSString *path = [NSString stringWithFormat:@"%@action=goods_fav&uid=%@&goods_id=%@&agentid=%@&json=1", tep, _uid, _gid, _agentId];
    NSLog(@"🍎%@, %@, %@, %@", _uid, _agentId, _uid, _gid);

    
    NSString *urlString = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:path]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];

    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"添加收藏成功－－－－－－－－－－－");
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"------添加收藏失败%@", error);
    }];
    
}














#pragma mark - 请求取消收藏
/**请求取消收藏
 http://www.taojiuhui.cn/home/Api/manageopenapi
 ?action=goods_fav_del&uid=24&json=1&goods_id=19
 */
- (void)requestCancleCollect{
    
    IsLogin* login = [[IsLogin alloc]init];
    
    NSString* uid = [login isLoginIn:self.navigationController];
    if (![uid isEqualToString:@""]) {
        _uid = uid;
    }else{
        return;
    }
    
    GetCancleOperator* canleOperator = [[GetCancleOperator alloc]initWithParamsDic:@{@"action":@"goods_fav_del",@"uid":_uid,@"json":@"1",@"good_id":_goodsId}];
    NSLog(@"🍎%@, %@", _uid, _goodsId);
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:canleOperator withSuccessCallBack:^(BaseModel *model) {
 NSLog(@"-----%@----请求成功-------------",@"取消收藏");
    } andFaildCallBack:^(id response) {
        
    }];
}
#pragma mark - 请求 添加到购物车
/**请求加入购物车
 *http://www.taojiuhui.cn/home/Api/manageopenapi?action=add_cart&gid=26&agentid=1&uid=31&count=1
 http://www.taojiuhui.cn/home/Api/manageopenapi?action=add_cart&gid=29&agentid=1&uid=24&count=1&json=1
 */
- (void)pressAddChartBtn:(id)sender{
    
    IsLogin* login = [[IsLogin alloc]init];
    
    NSString* uid = [login isLoginIn:self.navigationController];
    if (![uid isEqualToString:@""]) {
        _uid = uid;
    }else{
        return;
    }
     NSLog(@"------加入购物 gid %@------",_gid);
    
    AddChartOperator* cartOperator = [[AddChartOperator alloc]initWithParamsDic:@{@"action":@"add_cart",@"gid":_gid,@"agentid":_agentId,@"uid":_uid,@"count":@"1",@"json":@"1"}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    [manager asyncTask:self.view withOperator:cartOperator withSuccessCallBack:^(BaseModel *model) {
        [self showInfo:@"您已成功添加到购物车!"];
        NSLog(@"------加入购物车%@------",@"1111");
    } andFaildCallBack:^(id response) {
        
    }];
}


@end

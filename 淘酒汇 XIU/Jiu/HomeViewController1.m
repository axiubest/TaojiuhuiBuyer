//
//  HomeViewController1.m
//  Jiu
//
//  Created by 张熔冰 on 15/10/19.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "HomeViewController1.h"
#import "GetSaleOperator.h"
#import "GetHJiuOperator.h"
#import "HomeTableViewCell1.h"

#import "QRCodeViewController.h"
@interface HomeViewController1 (){
    
    UIView* removableLineView;//可移动的线
    /**放"分类"的类别*/
    NSArray* scrollData;
    GetHJiuOperator* hJiuOpreator;
    NSArray* collectionData;
    int selectedBtn;
}
/**被选择的"类别"按钮*/
@property (nonatomic,strong)NSMutableArray *selectedViews;

@property (nonatomic, strong) UIView *adView;//广告位

/**首页 显示酒分类*/
@property(nonatomic,strong)UIScrollView* categoryScrollView;

@property(nonatomic,strong)UILabel* addressLabel;
@property(nonatomic,strong)NSString* agentId;

@property (nonatomic,strong) NSString *addressTitle;

@end

@implementation HomeViewController1

- (NSMutableArray *)selectedViews{
    
    if (!_selectedViews) {
        _selectedViews = [NSMutableArray array];
    }
    return  _selectedViews;
}





-(void)viewWillAppear:(BOOL)animated{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"agentId"] == nil) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"13" forKey:@"agentId"];
    }
    
    
    _agentId = [[NSUserDefaults standardUserDefaults] objectForKey:@"agentId"];
//    _agentId = @"13";
    [self.navigationController.navigationBar setBarTintColor:kMainColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self generateNavView];

    [self generateHeadeView];
}
-(void)viewDidDisappear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;
  

}

-(void)generateNavView{
   
    //扫码
    UIBarButtonItem* leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn-scan"] style:UIBarButtonItemStyleDone target:self action:@selector(pressLeftBtn:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    //搜索
    UIBarButtonItem* rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn-search"] style:UIBarButtonItemStyleDone target:self action:@selector(pressRightBtn:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    //titleView
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, self.navigationController.navigationBar.frame.size.height-44,0);
    _tableView.contentInset = insets;
    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 190, 28)];
    [titleView setBackgroundColor:[UIColor clearColor]];
    UILabel* addressLabel = [[UILabel alloc] init];
    [addressLabel setFitText:[[NSUserDefaults standardUserDefaults]objectForKey:@"city"] font:[UIFont fontWithName:@"Arial" size:16]];


    [addressLabel setTextColor:[UIColor whiteColor]];
    
    addressLabel.center = titleView.center;
    UITapGestureRecognizer* singlGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressLocationBtn:)];
    [titleView addGestureRecognizer:singlGesture];
    [titleView addSubview:addressLabel];
    //定位图标
    UIImageView* locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(addressLabel.x-30, 0, 25, 25)];
    [locationImageView setImage:[UIImage imageNamed:@"location"]];
    [titleView addSubview:locationImageView];

    //左箭头
    UIImageView* leftArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(addressLabel.x+addressLabel.width, 0, 25, 25)];
    [leftArrowImageView setImage:[UIImage imageNamed:@"arrows-right1"]];
    [titleView addSubview:leftArrowImageView];
    
    self.navigationItem.titleView = titleView;
}
- (void)generateHeadeView{
    _headerView = [[UIView alloc] init];
    [_headerView setAutoresizesSubviews:YES];
    [_headerView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin];
    //轮播
    UIView* pageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
    
    GetADSOperator* operator = [[GetADSOperator alloc] initWithParamsDic:@{@"action":@"home_focus",@"json":@"1"}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:pageView withOperator:operator withSuccessCallBack:^(BaseModel *model) {
        CycleScrollView* cycleScrollView = [[CycleScrollView alloc] initWithFrame:pageView.bounds animationDuration:3.f];
        
        NSMutableArray* viewsArray = [@[] mutableCopy];
        _pageViewData = operator.adsPathList;
        //         _pageViewData = @[@"http://www.xxjxsj.cn/article/UploadPic/2009-10/2009101018545196251.jpg"];
        for (int i = 0; i < [_pageViewData count]; i++) {
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:pageView.frame];
            [imageView setImageWithURL:[NSURL URLWithString:_pageViewData[i]] placeholderImage:nil];
            [viewsArray addObject:imageView];
        }
        cycleScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            return viewsArray[pageIndex];
        };
        [cycleScrollView setTotalPagesCount:^NSInteger(void){
            return [_pageViewData count];
        }];
        //    __block UIViewController* blockSelf = self;
        [cycleScrollView setTapActionBlock:^(NSInteger pageIndex) {
            
        }];
        [pageView addSubview:cycleScrollView];
        //--
        [self requestAdvert];
        
    } andFaildCallBack:^(id response) {
        //-
        [self requestAdvert];
        
    }];
    
    [_headerView addSubview:pageView];
    
    
    // UIView* adView = [[UIView alloc]initWithFrame:CGRectMake(0, pageView.height, kScreenWidth,170)];
    UIView* adView = [[UIView alloc]initWithFrame:CGRectMake(0, pageView.height, kScreenHeight, (kHOME_ADPageViewHeight-3*5)+10+5*2)];
    [_headerView addSubview:adView];
    
    self.adView = adView;
    
    //横线
    UIView* lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, adView.height+adView.y, kScreenWidth, 0.5)];
    [lineView1 setBackgroundColor:[UIColor grayColor]];
    [_headerView addSubview:lineView1];
    
    /**分类按钮*/
    selectedBtn = 0;//初始化时选中的类别
    //    UIScrollView* categoryScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,lineView1.height+lineView1.y, kScreenWidth, kScreenWidth / 4-14)];
    UIScrollView* categoryScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,lineView1.height+lineView1.y, kScreenWidth, kScreenWidth / 4 - 14)];
    [_headerView addSubview:categoryScrollView];
    self.categoryScrollView =categoryScrollView;
    
    //横线
    UIView* lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0,categoryScrollView.height+categoryScrollView.y, kScreenWidth, 0.5)];
    [lineView2 setBackgroundColor:[UIColor grayColor]];
    [_headerView addSubview:lineView2];
    [_headerView setFrame:CGRectMake(0, 0, kScreenWidth, lineView2.y+lineView2.height)];
    
    _tableView.tableHeaderView = _headerView;
}
#pragma mark - 广告位

- (void)requestAdvert{
    
    //广告位
    /**
    
     新:接口数据测试 http://www.taojiuhui.cn/home/Api/manageopenapi?action=home_act&json=1 */
    
    GetSaleOperator* saleOperator = [[GetSaleOperator alloc]initWithParamsDic:@{@"action":@"home_act",@"json":@"1"}];
    NetworkingManager* saleManager = [NetworkingManager sharedInstance];
    
    [saleManager asyncTask:self.adView withOperator:saleOperator withSuccessCallBack:^(BaseModel *model) {
        _salePathArr = saleOperator.salePathList;
        _saleHrefArr = saleOperator.saleHrefList;
        
        CGFloat activityBtnHeight = (kHOME_ADPageViewHeight-3*5)/2;
        CGFloat activityBtnWidth = (kScreenWidth-3*5)/2;
        
        for (int i = 0; i < _salePathArr.count; i ++ ) {
            NSString *urlStr = [self adPath:_salePathArr[i]];
            //1.创建一个ImageView
            UIImageView *adImageV = [[UIImageView alloc]init];
            //2.加载网络图片
            //之前的SDImage删掉不用了
            [adImageV setImageWithURL:[NSURL URLWithString:urlStr]];
            //3.设置frame
            adImageV.frame = CGRectMake(5 + i % 2 * ((kScreenWidth - 15) / 2 + 5) , 10 + i / 2 * ((self.adView.height - 20) / 2 + 5), activityBtnWidth, activityBtnHeight);
            
            adImageV.tag = i + 1000;
            
            //圆角
            adImageV.layer.cornerRadius = 6;
            adImageV.layer.masksToBounds = YES;
            
            //给imageView 添加手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAdImageV:)];
            [adImageV addGestureRecognizer:tap];
            
            [self.adView addSubview:adImageV];
        }
        //执行请求广告位之后,执行请求首页商品(酒分类及其内容)
        [self requestGoods];
 
    } andFaildCallBack:^(id response) {
        [self requestGoods];
    }];
    
}
#pragma mark - 首页商品列表分类scrollerView
/**首页商品列表分类
 *action=home_goods&json=1&agentid=1
 */
-(void)requestGoods{
        hJiuOpreator = [[GetHJiuOperator alloc]initWithParamsDic:@{@"action":@"home_goods",@"json":@"1",@"agentid":_agentId}];
    NetworkingManager* hJiuManager = [NetworkingManager sharedInstance];
    
    [hJiuManager asyncTask:self.view withOperator:hJiuOpreator withSuccessCallBack:^(BaseModel *model) {
        scrollData = hJiuOpreator.homeCategoryArr;
        
        NSArray* imagesNameArr = @[@"baijiu",@"pijiu",@"putaojiu",@"baojianjiu",@"putaojiu",@"baojianjiu",@"baojianjiu",];
        
        CGFloat btnWidth = kScreenWidth / 4;
        for (int i= 0; i < [scrollData count]; i++) {
            
            UIButton* categoryBtn = [[UIButton alloc] initWithFrame:CGRectMake(i*btnWidth,0 , btnWidth, btnWidth-20.f)];
            [categoryBtn setMTitle:scrollData[i]];
            [categoryBtn setImage:[UIImage imageNamed:imagesNameArr[i]] forState:UIControlStateNormal];
            categoryBtn.tag = i;
            [categoryBtn addTarget:self action:@selector(pressCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [_categoryScrollView addSubview:categoryBtn];
            
            //加红色底边
            UIView* selectedBarView = [[UIView alloc]initWithFrame:CGRectMake(5 + i * btnWidth,btnWidth - 16, btnWidth - 10, 2)];
            selectedBarView.backgroundColor = [UIColor whiteColor];
            selectedBarView.tag = 100 +i ;
            if (i == 0) {
                selectedBarView.backgroundColor = [UIColor redColor];
            }
            [self.selectedViews addObject:selectedBarView];
            [_categoryScrollView addSubview:selectedBarView];
        }
        
        [_categoryScrollView setContentSize:CGSizeMake( btnWidth*[scrollData count],60)];

        [_headerView addSubview:_categoryScrollView];
        
       [_tableView reloadData];
        
    } andFaildCallBack:^(id response) {
        
    }];
}
#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   NSMutableArray* goods = [hJiuOpreator getCategoryListArr:scrollData[selectedBtn]];
    
    NSString* cellIdentifier = @"cell";
    HomeTableViewCell1* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell1" owner:self options:nil] lastObject];
    }
    cell.jiuModelArr = goods;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray* goods = [hJiuOpreator getCategoryListArr:scrollData[selectedBtn]];
    
    CGFloat viewWidth = (kScreenWidth - 20)/3;
    return goods.count*(viewWidth/96*131/2)+30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"--------点击%@---------",@"111");
}
#pragma mark - Public

-(void)generateCategoryScrollView{
  
}

-(void)pressCategoryBtn:(UIButton*)sender{
    NSArray* subViews = [_categoryScrollView subviews];
    for (UIView* selectedView in subViews) {
        if (selectedView.tag == 100+sender.tag) {
            selectedView.backgroundColor = [UIColor redColor];
        }
        else{
            selectedView.backgroundColor = [UIColor whiteColor];
        }
    }
    NSInteger tag = sender.tag;
    selectedBtn = (int)tag;
    [self.tableView reloadData];
  }

#pragma mark - tapAdImageV 点击广告位

- (void)tapAdImageV:(UITapGestureRecognizer *)tap{
    
    UIView *tapView = tap.view;
    switch (tapView.tag) {
            
        case 1000://广告位第一张图
        {
            
        }
            break;
        case 1001://广告位第二张图
        {
            
        }
            break;
        case 1002://广告位第三张图
        {
            
        }
            break;
            
        default:
        {//广告位第四张图
            
        }
            break;
    }
    
    
}

#pragma mark - UITableViewCellDelegate

-(void)selectItemCallBack:(NSInteger)index{
    ProductInfoViewController* controller = [[ProductInfoViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - public
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSString*)adPath:(NSString*)path{
    NSLog([[NSString alloc]initWithFormat:@"http://www.taojiuhui.cn/%@",path],@"src");
    return [[NSString alloc]initWithFormat:@"http://www.taojiuhui.cn/%@",path];
}

-(void)pressLeftBtn:(id)sender{
    
    QRCodeViewController* codeController = [[QRCodeViewController alloc]initWithNibName:@"QRCodeViewController" bundle:nil];
    MainNavController* navController = [[MainNavController alloc]initWithRootViewController:codeController];
    
    [self presentViewController:navController animated:YES completion:nil];
}

-(void)pressRightBtn:(id)sender{
    SearchViewController* controller = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    MainNavController* navController = [[MainNavController alloc] initWithRootViewController:controller];
    [self presentViewController:navController animated:YES completion:^{
        
    }];
}

-(void)pressLocationBtn:(id)sender{
    
    LocationViewController* controller = [[LocationViewController alloc] init];

   MainNavController* mainNavController = [[MainNavController alloc] initWithRootViewController:controller];
    
    [self.navigationController presentViewController:mainNavController animated:YES completion:^{
        controller.block = ^(NSString* city){
            _addressLabel.text = city;
           // _agentId = agentId;
        };
    }];
}

@end

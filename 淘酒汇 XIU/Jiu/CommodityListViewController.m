//
//  CommodityListViewController.m
//  Jiu
//
//  Created by 张熔冰 on 15/10/21.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "CommodityListViewController.h"

#import "MainNavController.h"
#import "ProductInfoViewController.h"

#import "HomeJiuModel.h"
#import "NetworkingManager.h"
#import "GetSearchOpeartor.h"
#import "UIImageView+WebCache.h"
@interface CommodityListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray* _dataArr;
    NSArray* compositeData;//综合
    NSArray* salesCountData;//销量
    NSArray* priceData;//价格
    NSArray* filterData;//筛选
    int _page;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIWindow *mainWindow;
@end

@implementation CommodityListViewController

- (id)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.view.frame = frame;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    _tableData = @[@"",@"",@""];
    _tableData = [NSMutableArray array];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    

    UISearchBar* searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 240, 44)];
    [searchBar setPlaceholder:@"白酒"];
    [searchBar setBackgroundColorImage:[UIColor clearColor]];
    UIView* searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 44)];
    [searchView addSubview:searchBar];
    self.navigationItem.titleView = searchView;
    
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pressCancelBtn:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
#pragma mark 功能暂时取消， 服务器无url  解开即可使用
//    compositeData = @[@"综合",@"限时省"];
//    salesCountData = @[@"销量",@"由高到低",@"由低到高"];
//    priceData = @[@"价格",@"由高到低",@"由低到高"];
//    filterData = @[@"筛选"];
//    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
//    menu.delegate = self;
//    menu.dataSource = self;
//    [self.view addSubview:menu];
//    _menu = menu;
//    [menu selectDefalutIndexPath];
//    //请求搜索数据
    _page = 1;
    [self requestSearch];
    _tableView.tableFooterView = [[UIView alloc]init];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CommodityTableViewCell";
    
    CommodityTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommodityTableViewCell" owner:self options:nil] lastObject];
    }
    HomeJiuModel* model = _dataArr[indexPath.row];
    cell.gid = model.gid;
    cell.agentId = [[NSUserDefaults standardUserDefaults]objectForKey:@"agentId"];
    cell.goodsId = model.goodsId;
    cell.priceLbl.text = [NSString stringWithFormat:@"￥%@",model.price];
    cell.infoLbl.text = model.title;
//    xxx人购买无参数
//    cell.buyCountLbl.text =
    
    [cell.picImg sd_setImageWithURL:[NSURL URLWithString:model.image1]];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPath");
    CommodityTableViewCell* cell = (CommodityTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    ProductInfoViewController* controller = [[ProductInfoViewController alloc]init];
    controller.gid = cell.gid;
    controller.goodsId = cell.goodsId;
    controller.agentId = cell.agentId;
    MainNavController* mainNavController = [[MainNavController alloc] initWithRootViewController:controller];
    [self presentViewController:mainNavController animated:YES completion:^{
        
    }];

}
#pragma mark MenuDelegate

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 4;
}

-(NSInteger)withoutIndicatorInColumn:(DOPDropDownMenu *)menu{
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return compositeData.count;
    }else if (column == 1){
        return salesCountData.count;
    }else if(column == 2){
        return priceData.count;
    }else{
        return 0;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return compositeData[indexPath.row];
    } else if (indexPath.column == 1){
        return salesCountData[indexPath.row];
    } else if(indexPath.column == 2){
        return priceData[indexPath.row];
    }else{
        return filterData[indexPath.row];
    }
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.item >= 0) {
        NSLog(@"点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    }
}

- (void)menu:(DOPDropDownMenu *)menu didSelectMenuAtIndexPath:(NSInteger)index{
    if (index == 3) {
        [self generateRightMenu];
    }
}

-(void)menu:(DOPDropDownMenu *)menu didDismissMenu:(NSInteger)index{
    [self selectRightMenuCancel];
}
- (void)generateRightMenu{
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(kScreenWidth/10, 0, kScreenWidth*9/10, kScreenHeight)];
    window.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    window.windowLevel = UIWindowLevelNormal;
    window.hidden = NO;
    [window makeKeyAndVisible];
    
    RightMenuViewController* controller = [[RightMenuViewController alloc] initWithNibName:@"RightMenuViewController" bundle:nil];
    
    if([controller respondsToSelector:@selector(setDidSelectedCancel:)])
    [controller setDidSelectedCancel:^{
        [self selectRightMenuCancel];
    }];
    
    if ([controller respondsToSelector:@selector(setDidSelectedOK:)]) {
        [controller setDidSelectedOK:^{
            [self selectRightMenuOK];
        }];
    }
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    controller.view.frame = window.bounds;
    
    window.rootViewController = nav;
    self.mainWindow = window;
}

-(void)selectRightMenuCancel{
    [_mainWindow resignKeyWindow];
    _mainWindow = nil;
}

-(void)selectRightMenuOK{
    
    [self selectRightMenuCancel];
}
#pragma mark - 请求 显示搜索结果
/**http://www.taojiuhui.cn/home/Api/manageopenapi?action=search&mc=白酒bc=剑南春&keyword=&json=1&page=1&agentid=1
 mc是主分类,bc是子分类,keyword是关键字, mc=白酒
 */
- (void)requestSearch{
    
    if (_keyword==nil) {
        _keyword = @"";
    }
    if (_mc == nil) {
        _mc = @"";
    }
    if (_bc == nil) {
        _bc = @"";
    }
    GetSearchOpeartor* searchOperator = [[GetSearchOpeartor alloc]initWithParamsDic:@{@"action":@"search",@"mc": [_mc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"bc":[_bc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"keyword":[_keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"json":@"1",@"page":[NSString stringWithFormat:@"%d",_page],@"agentid":[[NSUserDefaults standardUserDefaults]objectForKey:@"agentId"]}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:searchOperator withSuccessCallBack:^(BaseModel *model) {
    
        _dataArr = searchOperator.dataArr;
        [_tableView reloadData];
        
    } andFaildCallBack:^(id response) {
        
    }];
}
#pragma mark - public
-(void)pressCancelBtn:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

//
//  CategoryViewController.m
//  Jiu
//
//  Created by 张熔冰 on 15/9/13.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "CategoryViewController.h"

#import "NetworkingManager.h"
#import "GetCategoryOpetator.h"



#import "XIUCategoryTableViewCell.h"
#import "CatagoryJiuModel.h"
#import "QRCodeViewController.h"

#import "CommodityListViewController.h"

@interface CategoryViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSArray* scrollData;
    
    NSString* cellIdentifier;
    NSString* jiuIndex;
    GetCategoryOpetator* cateOpreator;
    NSString* _gid;
    NSString* _goodsId;
    NSString* _agentId;
}
@property(nonatomic,strong)UILabel* addressLabel;
@end

@implementation CategoryViewController

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    
    jiuIndex = @"";
    [self requestCategory];
    cellIdentifier = @"XIUCell";

    [self.xiuTableView registerNib:[UINib nibWithNibName:@"XIUCategoryTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    
        [self generateNavView];
}

-(void)viewDidDisappear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类";
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
    
}
#pragma mark - collectionView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    XIUCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.backgroundColor = [UIColor whiteColor];
    CatagoryJiuModel* jiu = _tableData[indexPath.row];
    [cell.jiuNameLbl setText:jiu.name];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CatagoryJiuModel* jiu = _tableData[indexPath.row];
    NSString* mc = jiuIndex;
    if ([mc isEqualToString:@""]) {
        mc = scrollData[0];
    }
    NSString* bc = jiu.name;
    
    [self requestSearchMc:mc requestBc:bc];
}

#pragma mark - 请求 home页的商品
/**http://www.taojiuhui.cn/home/Api/manageopenapi?action=category&json=1
 */
-(void)requestCategory{
    cateOpreator = [[GetCategoryOpetator alloc]initWithParamsDic:@{@"action":@"category",@"json":@"1"}];
  
    NetworkingManager* cateManager = [NetworkingManager sharedInstance];
    [cateManager asyncTask:self.view withOperator:cateOpreator withSuccessCallBack:^(BaseModel *model) {
        NSLog(@"请求成功:%@",model.data);
        scrollData = cateOpreator.categoryArrs;
         _tableData = [cateOpreator getCategoryJiuValue:cateOpreator.categoryArrs[0]];

        [self.xiuTableView reloadData];
        [self generateLeftScrollView];
        
        
    } andFaildCallBack:^(id response) {
        
    }];
}
#pragma mark - 跳转 搜索结果

- (void)requestSearchMc:(NSString*)mc requestBc:(NSString*)bc{
    CommodityListViewController* controller = [[CommodityListViewController alloc]init];
    controller.mc = mc;
    controller.bc = bc;
    MainNavController* mainNavController = [[MainNavController alloc] initWithRootViewController:controller];
        [self.navigationController presentViewController:mainNavController animated:YES completion:^{
    
        }];
}
#pragma mark - public

-(void)generateLeftScrollView{
    for (int i = 0; i < [scrollData count]; i++) {
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, i*61, 100, 60)];
        [btn setTitle:[scrollData objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"gray@80*100"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"white@80*100"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"white@80*100"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(pressCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        //横线
        UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(btn.x, btn.height, btn.width, 0.5)];
        [lineView setBackgroundColor:[UIColor blackColor]];
        [btn addSubview:lineView];
        [_scrollView addSubview:btn];
    }
    [_scrollView.subviews[0] setSelected:YES];
    _scrollView.contentSize = CGSizeMake(100, [scrollData count] * 80);
}

-(void)pressCategoryBtn:(UIButton*)sender{
    NSArray* subViews = [_scrollView subviews];
    for (UIView* v in subViews) {
        if ([v isKindOfClass:[UIButton class]]) {
            [(UIButton*)v setSelected:NO];
        }
    }
    
    NSInteger tag = ((UIButton*)sender).tag;
    [subViews[tag] setSelected:YES];
    
    jiuIndex = scrollData[tag];
    _tableData = [cateOpreator getCategoryJiuValue:jiuIndex];
    
    [self.xiuTableView reloadData];
    
}
-(void)createCategoryTableView{

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



@end

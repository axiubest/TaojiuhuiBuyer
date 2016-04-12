//
//  SearchViewController.m
//  Jiu
//
//  Created by zhangrongbing on 15/9/15.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"

#import "CommodityListViewController.h"
#import "MainNavController.h"
@interface SearchViewController ()<UISearchBarDelegate>
{
    UISearchBar* mSearchBar;
    UITapGestureRecognizer *tap;
}

@property (weak, nonatomic) IBOutlet UITableView *tabletView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableData = @[@"泸州老窖",@"洋河蓝"];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pressCancelBtn:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    mSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 240, 44)];
    [mSearchBar setPlaceholder:@"洋河系列火热限购中!"];
    [mSearchBar setBackgroundColorImage:[UIColor clearColor]];
    mSearchBar.delegate = self;
    UIView* searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 44)];
    [searchView addSubview:mSearchBar];
    
    self.navigationItem.titleView = searchView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _tableData[indexPath.row];
    return cell;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(8, 0, kScreenWidth, 40)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel* label = [[UILabel alloc] initWithFrame:view.bounds];
    [label setText:@"历史搜索"];
    [view addSubview:label];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.f]];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;{
    return 40;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CommodityListViewController* controller = [[CommodityListViewController alloc] initWithNibName:@"CommodityListViewController" bundle:nil];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [mSearchBar resignFirstResponder];
}

#pragma mark - UISearchBarDelegate
//
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTableView:)];
    [self.tabletView addGestureRecognizer:tap];
    
}
//
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{

    [self.tabletView removeGestureRecognizer:tap];
    
}
//
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//    searchBar.showsCancelButton = NO;
//    [searchBar resignFirstResponder];
//}

//键盘右下角的 search
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    
    CommodityListViewController* controller = [[CommodityListViewController alloc]init];
    controller.keyword = searchBar.text;
    MainNavController* mainNavController = [[MainNavController alloc] initWithRootViewController:controller];
    [self.navigationController presentViewController:mainNavController animated:YES completion:^{
        
    }];

}

#pragma mark - Public
-(void)pressCancelBtn:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)tapTableView:(UITapGestureRecognizer *)tap{
    
    UIView *view = tap.view;
    if (view == self.tabletView) {
        [mSearchBar resignFirstResponder];
    }


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

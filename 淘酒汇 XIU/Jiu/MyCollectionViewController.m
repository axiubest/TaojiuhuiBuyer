//
//  MyCollectionViewController.m
//  Jiu
//
//  Created by mac on 16/2/26.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "CollectionTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "ProductInfoViewController.h"
#import "IsLogin.h"

#import "MyCollectionModel.h"

@interface MyCollectionViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UITableView *table;
@end

@implementation MyCollectionViewController


- (void)viewWillAppear:(BOOL)animated {
    
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    _table = table;
    
    UINib *nib = [UINib nibWithNibName:@"CollectionTableViewCell" bundle:nil];
    [_table registerNib:nib forCellReuseIdentifier:@"UITableViewCell"];
    
    table.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:table];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏管理";
    self.dataArr = [NSMutableArray array];
    
    
   // [self addNib];
//    [self.view addSubview:self.tableView];
//    列表网络请求
    [self GetCollecViewListDataSource];

}
#pragma mark － 请求 收藏列表网络请求
-(void)GetCollecViewListDataSource
{
    
    IsLogin* login = [[IsLogin alloc]init];
    
    NSString* uid = [login isLoginIn:self.navigationController];
    if (![uid isEqualToString:@""]) {
        _uid = uid;
    }else{
        return;
    }
    NSString *path = [NSString stringWithFormat:@"http://www.taojiuhui.cn/home/Api/manageopenapi?action=goods_fav_list&uid=%@&json=1", _uid];
    NSString *urlString = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:path]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];
    
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"-----------请求收藏夹信息成功----------");
        if (![_uid  isEqual: @""]) {
            for (NSDictionary *dic in responseObject) {
                MyCollectionModel *model = [[MyCollectionModel alloc] init];
                model.title = [dic objectForKey:@"title"];
                
                model.image1 =[NSString stringWithFormat:@"http://www.taojiuhui.cn/upload/%@", [dic objectForKey:@"image1"]];
                model.price = [dic objectForKey:@"price"];
                model.goods_id = [dic objectForKey:@"goods_id"];
                [_dataArr addObject:model];
            }
                [_table reloadData];
        }

    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                NSLog(@"请求收藏夹信息失败%@", error);
    }];

}

#pragma mark  tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"UITableViewCell";
    CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[CollectionTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier];
    }
    cell.goodsLabel.text = [NSString stringWithFormat:@"商品名称：%@",  [self.dataArr[indexPath.row] title]];
    [cell.goodsImage sd_setImageWithURL:[NSURL URLWithString:[self.dataArr[indexPath.row] image1]]];
    NSString *price = [NSString stringWithFormat:@"价格 :%.2f",  [_dataArr[indexPath.row] price].doubleValue/100.00];
    cell.priceLabel.text = price;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark  tableView编辑
//- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
//    [super setEditing:editing animated:animated];
//    if (editing) {
//        self.navigationItem.rightBarButtonItem.title = @"完成";
//        [_table setEditing:editing animated:YES];
//    }else {
//        self.navigationItem.rightBarButtonItem.title = @"编辑";
//        [_table setEditing:editing animated:YES];
//    }
//}
//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 1;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//       
//        if (_dataArr != nil) {
//            [self.dataArr removeObjectAtIndex:indexPath.row];
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
//
//
//        }else {
//            [self.dataArr removeObjectAtIndex:indexPath.row];
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
//            
//            [ tableView deleteSections: [NSIndexSet indexSetWithIndex: indexPath.section]withRowAnimation:4];
//        }
//      
//    [self deleteDataSourceOfCollectionListForRowIndexPath:(NSIndexPath *)indexPath];
//    }
//}
#pragma mark 点击cell跳转到商品详情
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//
//    ProductInfoViewController *product = [[ProductInfoViewController alloc] init];
//    
//#warning !  服务器缺少参数
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:product];
//    [self.navigationController pushViewController:product animated:YES];
//
//}


#pragma mark - 解析 删除收藏夹商品
/**删除收藏夹商品
 http://www.taojiuhui.cn/home/Api/manageopenapi?action=goods_fav_del&uid=50&goods_id=892&json=1
 */
- (void)deleteDataSourceOfCollectionListForRowIndexPath:(NSIndexPath *)indexPath {
    IsLogin* login = [[IsLogin alloc]init];
    
    NSString* uid = [login isLoginIn:self.navigationController];
    if (![uid isEqualToString:@""]) {
        _uid = uid;
    }else{
        return;
    }
    
    NSString *xiuGoodsId = [self.dataArr[indexPath.row] goods_id];
    
    
#warning      服务器端口配置－－－uid应改为GID
    NSString *path = [NSString stringWithFormat:@"http://www.taojiuhui.cn/home/Api/manageopenapi?action=goods_fav_del&uid=%@&goods_id=%@&json=1", _uid, xiuGoodsId];
    NSLog(@"📷%@", xiuGoodsId);
    NSString *urlString = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:path]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];
    
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"-----------收藏夹删除成功----------");
    }
         failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
             NSLog(@"收藏夹删除失败%@", error);
         }];
    
}

@end

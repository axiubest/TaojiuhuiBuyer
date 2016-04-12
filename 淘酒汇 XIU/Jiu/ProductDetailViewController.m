//
//  ProductDetailViewController.m
//  PagingDemo
//
//  Created by Liu jinyong on 15/8/6.
//  Copyright (c) 2015年 Baidu 91. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "UIView+Frame.h"


#import "UIImageView+AFNetworking.h"

@interface ProductDetailViewController (){
    UIView* line;
}

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 1)];
    //添加切换按钮
    UIView* categoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    UIButton* leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 44)];
    [leftBtn setTitle:@"图文详情" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [leftBtn addTarget:self action:@selector(pressLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 44)];
    [rightBtn setTitle:@"商品评价" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [rightBtn addTarget:self action:@selector(pressRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [categoryView addSubview:leftBtn];
    [categoryView addSubview:rightBtn];
    
    [_scrollView addSubview:categoryView];

    
//    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, 2138)];
//    [imageView setImage:[UIImage imageNamed:@"commodityaa"]];
//    [_scrollView addSubview:imageView];
//    [_scrollView setContentSize:CGSizeMake(0, 2138)];
}

-(void)addDetailImage:(NSDictionary* )goodsDetailImageDict{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0,45,kScreenWidth,2100)];
    
    NSArray* keys = [goodsDetailImageDict allKeys];
    for (int i = 0; i< keys.count;i++ ) {
        NSString* urlStr = [goodsDetailImageDict objectForKey:[NSString stringWithFormat:@"%d",i]];
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i * 251, kScreenWidth, 251)];
        [imageView setImageWithURL:[NSURL URLWithString:urlStr]];
        
        [view addSubview:imageView];
    }
    
    [_scrollView addSubview:view];
    [_scrollView setContentSize:CGSizeMake(0, 45+keys.count*251+54)];

}

-(void)pressLeftBtn:(id)sender{
    [UIView animateWithDuration:0.2 animations:^{
        
    }];
}

-(void)pressRightBtn:(id)sender{
    [UIView animateWithDuration:0.2 animations:^{
        
    }];
}


@end

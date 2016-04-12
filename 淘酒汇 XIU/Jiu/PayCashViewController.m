//
//  PayCashViewController.m
//  Jiu
//
//  Created by Molly on 16/1/27.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "PayCashViewController.h"
#import "MainNavController.h"
#import "ShoppingCartViewController.h"
@interface PayCashViewController ()

@end

@implementation PayCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(pressRight:)];
    self.navigationItem.leftBarButtonItem = rightBtn;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pressRight:(id)sender{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
//[self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];

//
//    ShoppingCartViewController* controller = [[ShoppingCartViewController alloc] init];
//    MainNavController* navController = [[MainNavController alloc]initWithRootViewController:controller];
//    controller.flag = @"1";
//    MainNavController* navController = [[MainNavController alloc] init];
//    [self.navigationController presentViewController:navController animated:YES completion:nil];
//    [self.navigationController popToRootViewControllerAnimated:controller];
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

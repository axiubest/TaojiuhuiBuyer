//
//  MainNavController.m
//  Jiu
//
//  Created by 张熔冰 on 15/9/13.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "MainNavController.h"

@interface MainNavController ()

@end

@implementation MainNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationBar setBarTintColor:kMainColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self.navigationBar setTintColor:[UIColor blackColor]];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

//
//  AppDelegate.m
//  Jiu
//
//  Created by zhangrongbing on 15/9/11.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "HomeViewController1.h"
#import "MainNavController.h"
#import "CategoryViewController.h"
#import "ShoppingCartViewController.h"
#import "MyViewController.h"
#import "SignUpViewController.h"

#import "WXApi.h"
#import "WXApiManager.h"
#import <AlipaySDK/AlipaySDK.h>
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    MainTabBarController* mainViewController = [[MainTabBarController alloc] init];
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    
    //首页
    HomeViewController1* homeViewController = [[HomeViewController1 alloc] initWithNibName:@"HomeViewController1" bundle:nil];
    MainNavController* homePageNavController = [[MainNavController alloc] initWithRootViewController:homeViewController];
    UITabBarItem* homeTabbar = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"home"] selectedImage:[UIImage imageNamed:@"home-selected"]];
    [homeTabbar setTag:0];
    homePageNavController.tabBarItem = homeTabbar;
    
    //分类
    CategoryViewController* categoryViewController = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
     MainNavController* categoryPageNavController = [[MainNavController alloc] initWithRootViewController:categoryViewController];
    UITabBarItem* categoryTabbar = [[UITabBarItem alloc] initWithTitle:@"分类" image:[UIImage imageNamed:@"category"] selectedImage:[UIImage imageNamed:@"category-selected"]];
    [categoryTabbar setTag:1];
    categoryPageNavController.tabBarItem = categoryTabbar;
    
    //购物车
    ShoppingCartViewController* shoppingViewController = [[ShoppingCartViewController alloc] initWithNibName:@"ShoppingCartViewController" bundle:nil];
    MainNavController* shoppingPageNavController = [[MainNavController alloc] initWithRootViewController:shoppingViewController];
    UITabBarItem* shoppingTabbar = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[UIImage imageNamed:@"shopping"] selectedImage:[UIImage imageNamed:@"shopping-selected"]];
    [shoppingTabbar setTag:2];
    shoppingPageNavController.tabBarItem = shoppingTabbar;
    
    //我的
    MyViewController* myViewController = [[MyViewController alloc] initWithNibName:@"MyViewController" bundle:nil];
    MainNavController* myPageNavController = [[MainNavController alloc] initWithRootViewController:myViewController];
    UITabBarItem* myTabbar = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"my"] selectedImage:[UIImage imageNamed:@"my-selected"]];
    [myTabbar setTag:3];
    myPageNavController.tabBarItem = myTabbar;
  
    mainViewController.viewControllers = @[homePageNavController, categoryPageNavController, shoppingPageNavController, myPageNavController];
    
    _window.rootViewController = mainViewController;
    [_window makeKeyAndVisible];
    
    
    //向微信注册wx834c4ce6291fc399  APP_ID
    [WXApi registerApp:@"wx834c4ce6291fc399" withDescription:@"demo 2.0"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIImage*) createImageWithColor: (UIColor*) color withRect:(CGRect)rect

{
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}
#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp{
     
    if ([resp isKindOfClass:[PayResp class]]) {
        switch (resp.errCode) {
            case WXSuccess:
            {
                
                NSLog(@"%@成功",@"微信支付");
                break;
            }
            case -2:{
                NSLog(@"%@用户退出",@"微信支付");
                break;
            }
            default:{
                NSLog([NSString stringWithFormat:@"支付失败!retcode = %d retstr = %@",resp.errCode,resp.errStr]);
                break;
            }
        }
    }
    
    
}

#pragma mark - 支付
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    else if ([url.host isEqualToString:@"platfoemapi"]) {
        [[AlipaySDK defaultService]processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    else{
        //跳转支付宝钱包进行支付，处理支付结果
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    
    return YES;
}
@end

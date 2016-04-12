//
//  IsLogin.m
//  Jiu
//
//  Created by Molly on 16/1/6.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "IsLogin.h"
#import "SignUpViewController.h"//暂时取消

#import "XIULandViewController.h"

@implementation IsLogin
/**是否登录
 返回@""说明已经登录
 */
- (NSString* )isLoginIn:(UINavigationController*) navigationController{
    NSString* uid = @"";
    //    if (![[NSUserDefaults standardUserDefaults] objectIsForcedForKey:@"uid"]||[[NSUserDefaults standardUserDefaults]objectForKey:@"uid"] != nil) {
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"uid"] == nil) {
        
        XIULandViewController* landViewController = [[XIULandViewController alloc]initWithNibName:@"XIULandViewController" bundle:nil];
//        signUpViewController.flag = @"0";
        [navigationController pushViewController:landViewController animated:YES];
    }else{
        uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    }
    return uid;
}


@end

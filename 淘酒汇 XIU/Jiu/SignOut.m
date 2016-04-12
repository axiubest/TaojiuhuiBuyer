//
//  SignOut.m
//  Jiu
//
//  Created by Molly on 16/1/6.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "SignOut.h"

@implementation SignOut
- (void)signOut:(UINavigationController*) navigationController thisView:(UIView*)view{
    UILabel* lbl = [[UILabel alloc]init];
    lbl.frame = CGRectMake(0, 0, 200, 50);
    lbl.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    lbl.textColor = [UIColor whiteColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.backgroundColor = [UIColor blackColor];
    lbl.alpha = 0.0;
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"] != nil){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"您确定要退出吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"uid"];
//            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"tele"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"uid"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"tele"];
            
            
            lbl.text = @"您已成功退出";
            [view addSubview:lbl];
            [UIView animateWithDuration:1.0 animations:^{
                lbl.alpha = 0.7;
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
                    lbl.alpha = 0.0;
                } completion:^(BOOL finished) {
                    [lbl removeFromSuperview];
                }];
                
            }];
            

        }];
        UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:confirmAction];
        [alert addAction:cancleAction];
        
        [navigationController presentViewController:alert animated:YES completion:^{
        }];
        
    }else{
        
        lbl.text = @"尚未登录";
        [view addSubview:lbl];
        [UIView animateWithDuration:1.0 animations:^{
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
                lbl.alpha = 0.0;
            } completion:^(BOOL finished) {
                [lbl removeFromSuperview];
            }];
        }];
        
    }


}
@end

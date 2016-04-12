//
//  XIULandViewController.m
//  Jiu
//
//  Created by A-XIU on 16/3/22.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "XIULandViewController.h"

#import "AFNetworking.h"
#import <CommonCrypto/CommonCrypto.h>

#import "MyCollectionModel.h"

@interface XIULandViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;



@property (nonatomic, strong) NSString *MD5Password;

@end

@implementation XIULandViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (NSString *)md5:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0],result[1],result[2],result[3],result[4], result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]];
    
    
}


#pragma mark  账号密码请求
- (void)getLandURL {
    
    NSString *path = [NSString stringWithFormat:@"http://www.taojiuhui.cn/home/Api/manageopenapi?action=login&telephone=%@&json=1", _userNameLabel.text];
    

    
    NSString *urlString = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:path]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];
    
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
    
    
        
//        根据返回结果判断是否注册，  如果返回code＝ 1，则为未注册，  需要注册
        
        _MD5Password = [self md5:_passwordLabel.text];
        NSLog(@"%@🍎", _MD5Password);
        
                MyCollectionModel *model = [[MyCollectionModel alloc] init];
                model.userid = [responseObject objectForKey:@"userid"];
            
                model.telephone = [responseObject objectForKey:@"telephone"];
                model.password = [responseObject objectForKey:@"password"];

                
//                判断密码和本地输入是否一致
                if ([_MD5Password isEqualToString:model.password]) {
                    NSLog(@"密码一致，可以登陆");
                    
                    [[NSUserDefaults standardUserDefaults]setObject:model.userid forKey:@"uid"];
                    [[NSUserDefaults standardUserDefaults]setObject:model.telephone forKey:@"tele"];
                
                      [self.navigationController popViewControllerAnimated:YES];
                    
                    
                }else {
                    [self showInfo:@"账号或密码错误"];
                }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"账号或用户名输入有误，请重新输入%@", error);
    }];

}


//点击登陆按钮
- (IBAction)chickedLandButton:(UIButton *)sender {
    
    if ([_userNameLabel.text isEqualToString: @""] && ![_passwordLabel.text isEqualToString:@""]) {
        [self showInfo:@"请输入用户名"];
    }if ([_passwordLabel.text isEqualToString:@""] && ![_userNameLabel.text isEqualToString:@""]) {
        [self showInfo:@"请输入密码"];
    }if ([_passwordLabel.text isEqualToString:@""] && [_userNameLabel.text isEqualToString:@""]) {
        [self showInfo:@"请输入用户名和密码"];
    }if (![_userNameLabel.text isEqualToString:@""] && ![_passwordLabel.text isEqualToString:@""]) {
         [self getLandURL];
    }

    
    
}



#pragma mark - public
-(void)showInfo:(NSString* )infoStr{
    
    UILabel* lbl = [[UILabel alloc]init];
    lbl.text = infoStr;
    lbl.font = [UIFont systemFontOfSize:10.f];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor whiteColor];
    lbl.backgroundColor = [UIColor blackColor];
    lbl.frame = CGRectMake(0, 0, 150, 50);
    lbl.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    lbl.alpha = 0.0;
    
    [self.view addSubview:lbl];
    [UIView animateWithDuration:1.0 animations:^{
        lbl.alpha = 0.7;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            lbl.alpha = 0.0;
        } completion:^(BOOL finished) {
            [lbl removeFromSuperview];
            
        }];
        
    }];
}


@end

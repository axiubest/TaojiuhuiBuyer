//
//  SignUpViewController.m
//  Jiu
//
//  Created by Molly on 15/10/29.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import "SignUpViewController.h"
#import "GetSmsOperator.h"
#import "NetworkingManager.h"
#import "SignUpOperator.h"
#import "UIButton+AFNetworking.h"
#import "AFNetworking.h"
@interface SignUpViewController (){
    NSString* _verfityId;
}

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"登录";
    
    UIBarButtonItem* leftBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pressCancelBtn:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
   
    
    //请登录
    if ([_flag isEqualToString:@"0"]) {
        [self showInfo];
    }
//    }else{
//        //图形验证码
//        [self requestVerfityCode];
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - public

-(void)showInfo{

    UILabel* lbl = [[UILabel alloc]init];
    lbl.text = @"请登录";
    lbl.font = [UIFont systemFontOfSize:10.f];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor whiteColor];
    lbl.backgroundColor = [UIColor blackColor];
    lbl.frame = CGRectMake(0, 0, 100, 25);
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
//            //图形验证码
//            [self requestVerfityCode];
        }];
        
    }];
}
-(void)pressCancelBtn:(id)sender{

    [self.navigationController popToRootViewControllerAnimated:YES];
   // [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)getTeleRandom:(UIButton *)sender {
    [self requestSmsCode:sender];
    
    [sender setUserInteractionEnabled:NO];
    timerCount = 60;
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeFire:) userInfo:nil repeats:YES];
   [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];//控制线程
    
}
-(void)timeFire:(NSTimer *)timer{
   
    NSString* timeStr = @"";
    
    timerCount --;
    
    if (timerCount<=0) {
        [timer invalidate];
        timeStr = @"获取短信验证码";
        //[_smsTime setEnabled:YES];
        [_smsTime setUserInteractionEnabled:YES];
        timerCount = 60;
        
    }else{
        timeStr = [[NSString alloc]initWithFormat:@"%02ds后重新获取",timerCount];
    }
    [_smsTime setTitle:timeStr forState:UIControlStateNormal];
    
    }
- (IBAction)signUp:(UIButton *)sender {
    /**登陆接口
    *Smscode 手机验证码
    *Mobile 手机号码
     *http://www.taojiuhui.cn/home/Api/manageopenapi?action=login&json=1&mobile=15764337065&smscode=005040&verfityid=接收到的

  *   返回-1验证码错误
   * 返回-2手机号码不符合规则
    *返回array(“uid” => ‘用户id, “telephone” => ‘手机号码’,);
     */
    
     SignUpOperator* signOperator = [[SignUpOperator alloc]initWithParamsDic:@{@"action":@"login",@"smscode":_smsRandom.text,@"mobile":_teleNum.text,@"json":@"1",@"verfityid":_verfityId}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];   
        //请求网络
        [manager asyncTask:_signUpBtn withOperator:signOperator withSuccessCallBack:^(BaseModel *model) {
            
           _userModel = signOperator.userModel;
           
            if (_userModel.num == nil) {
                 NSLog(@"-----------------用户id--%@----------",_userModel.uid);
                 NSLog(@"-----------------用户手机号--%@----------",_userModel.telephone);
                [[NSUserDefaults standardUserDefaults]setObject:_userModel.uid forKey:@"uid"];
                [[NSUserDefaults standardUserDefaults]setObject:_userModel.telephone forKey:@"tele"];
                
                _flag = @"1";
                [self.navigationController popViewControllerAnimated:YES];
                //登录成功 跳转
            }else{
                switch([_userModel.num intValue]){
                    case  -1:{
                        //返回-1验证码错误
                        NSLog(@"-----------------接收结果--%@----------",_userModel.num);
                        break;
                    }
                    case -2:{
                         //返回-2手机号码不符合规则
                        break;
                    }
                    default:
                    {
                        //传输错误
                        break;
                    }
                        
                }

            }
            
            
        } andFaildCallBack:^(id response) {
            
        }];

    
    
}

//-(void)requestVerfityCode{
//    /**图形验证码接口
//     *http://www.taojiuhui.cn/home/home/verfitycode?wei=240&hei=50
//    */
//
//    NSURL* url = [NSURL URLWithString:@"http://www.taojiuhui.cn/home/home/verfitycode?wei=240&hei=50"];
//    
//    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
//    [_random setBackgroundImage:image forState:UIControlStateNormal];
//
//}
#pragma mark - 获取短信验证码
-(void)requestSmsCode:(id)sender{
    /**
     *获取短信验证码
     *Verfitycode 图形验证码
     *Mobile 手机号码
     *
     http://www.taojiuhui.cn/home/Api/manageopenapi?action=getsmscode&telephone=15764337065&device=0
     */
    NSLog(@"---------获取短信验证码-----%@-",@"1");

    GetSmsOperator* smsOperator = [[GetSmsOperator alloc]initWithParamsDic:@{@"action":@"getsmscode",@"telephone":_teleNum.text,@"device":@"0"}];
        NetworkingManager* manager = [NetworkingManager sharedInstance];
    
        [manager asyncTask:sender withOperator:smsOperator withSuccessCallBack:^(BaseModel *model) {
    
            NSString* retStr = smsOperator.retStr;
            
            _verfityId = retStr;
            /**返回 -3验证码错误
             *返回 1 发送成功
             *返回 0 发送失败
             if(retStr!= nil){
             switch ([retStr intValue]) {
             case -3:
             {
             break;
             }
             case 1:{
             break;
             }
             default:{
             break;
             }
             }
             }

             */
            
        } andFaildCallBack:^(id response) {
            
        }];

}
@end

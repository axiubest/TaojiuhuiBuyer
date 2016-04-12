//
//  QRCodeViewController.m
//  Jiu
//
//  Created by Molly on 15/11/25.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "QRCodeViewController.h"

#import "ZXingObjC.h"
#import <AudioToolBox/AudioToolbox.h>

@interface QRCodeViewController ()<ZXCaptureDelegate>

@property(nonatomic,strong)ZXCapture* myCapture;
@end

@implementation QRCodeViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

-(void)dealloc{
    
    [self.myCapture.layer removeFromSuperlayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫描二维码";
    UIBarButtonItem* leftBarBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pressCancleBtn:)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    self.myCapture = [[ZXCapture alloc]init];
    self.myCapture.camera = self.myCapture.back;
    self.myCapture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.myCapture.rotation = 90.0f;
    
    self.myCapture.layer.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);

    
    [self.view.layer addSublayer:self.myCapture.layer];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

    self.myCapture.delegate = self;
}


#pragma mark - ZXCaptureDelegate
- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result{
    
    
    if (!result) return;
    
    NSLog(@"%@",result.text);

    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    [self.myCapture stop];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"扫描到的信息"
                                                                   message:result.text
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                          
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - public
-(void)pressCancleBtn:(id)sender{

    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

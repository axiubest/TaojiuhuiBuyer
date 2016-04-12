//
//  PayWayPickViewController.m
//  Jiu
//
//  Created by Molly on 16/1/27.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "PayWayPickViewController.h"

@interface PayWayPickViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    NSArray* _payWayArr;
    NSInteger* _payWayCode;
}

@end

@implementation PayWayPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    _payWayArr = @[@"货到付款",@"支付宝支付",@"微信支付"];
    _payWayPickerView.dataSource = self;
    _payWayPickerView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - pickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_payWayArr count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_payWayArr objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _payWayCode = &row;
}


#pragma mark - public
- (IBAction)pressConfirmBtn:(UIButton *)sender {
    
    if (self.block) {
        self.block(_payWayCode);
        [self dismissViewControllerAnimated:YES completion:nil];
    }   
}
@end

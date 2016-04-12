//
//  PayWayPickerView.m
//  Jiu
//
//  Created by Molly on 16/1/27.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "PayWayPickerView.h"

@implementation PayWayPickerView
+(PayWayPickerView *)instanceTextView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"PayWayPickerView" owner:nil options:nil];
    
    return [nibView objectAtIndex:0];
}
- (void)initData
{
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.pickerDataArr = @[@"货到付款",@"支付宝支付",@"微信支付"];
    
    NSMutableArray *btnArray = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *fixedHead = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedHead.width = 20;
    
    UIBarButtonItem *fixedFoot = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedFoot.width = 20;
    
    UIBarButtonItem *fixedCenter = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.conform = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(onClickSwitch:)];
    
    [btnArray addObject:fixedHead];
    [btnArray addObject:[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonSystemItemCancel target:self action:@selector(onClickCancel:)]];
    
    [btnArray addObject:fixedCenter];
    [btnArray addObject:self.conform];
    
    [btnArray addObject:fixedFoot];
    
    [self.myToolbar setItems:btnArray];
    
    [_pickerView reloadAllComponents];
}
- (void)onClickCancel:(id)sender
{
    [self removeFromSuperview];
}

- (void)onClickSwitch:(id)sender
{
    if ([_delegate respondsToSelector:@selector(payWayPickerViewDidPick:)]) {
        NSString * payWay = [self.pickerDataArr objectAtIndex:self.firstComponentRow];
       
//        [_delegate payWayPickerViewDidPick:[NSString stringWithFormat:@"%d",(int)_firstComponentRow]];
        [_delegate payWayPickerViewDidPick:payWay];
    }
    [self removeFromSuperview];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
     self.firstComponentRow = row;
}
//行数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_pickerDataArr count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_pickerDataArr objectAtIndex:row];
}


@end

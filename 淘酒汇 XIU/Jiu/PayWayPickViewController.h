//
//  PayWayPickViewController.h
//  Jiu
//
//  Created by Molly on 16/1/27.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayWayPickViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIPickerView *payWayPickerView;
- (IBAction)pressConfirmBtn:(UIButton *)sender;

typedef void (^ablock)(NSInteger* payWayCode);
@property(nonatomic,copy) ablock block;
@end

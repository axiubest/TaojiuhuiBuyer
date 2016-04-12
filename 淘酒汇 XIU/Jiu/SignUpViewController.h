//
//  SignUpViewController.h
//  Jiu
//
//  Created by Molly on 15/10/29.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "UIButton+Image.h"
#import "UserModel.h"

@interface SignUpViewController : UIViewController
{
    int timerCount;
    BOOL done;
}
@property(nonatomic,strong)UserModel* userModel;
@property (weak, nonatomic) IBOutlet UITextField *teleNum;
@property (weak, nonatomic) IBOutlet UITextField *smsRandom;
@property (weak, nonatomic) IBOutlet UIButton *smsTime;
//@property (weak, nonatomic) IBOutlet UITextField *verfityCode;
//@property (weak, nonatomic) IBOutlet UIButton *random;
@property (weak, nonatomic) IBOutlet UIButton *signUpBtn;

- (IBAction)getTeleRandom:(UIButton *)sender;
//- (IBAction)getOtherRandom:(UIButton *)sender;
- (IBAction)signUp:(UIButton *)sender;

@property(nonatomic,strong)NSString* flag;
@end

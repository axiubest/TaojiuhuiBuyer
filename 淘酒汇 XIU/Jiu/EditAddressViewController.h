//
//  EditAddressViewController.h
//  Jiu
//
//  Created by 张熔冰 on 15/9/15.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditAddressViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *editView;

@property(nonatomic, strong) NSString* placeholderText;

@end

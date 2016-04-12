//
//  AddAddressViewController.h
//  Jiu
//
//  Created by 张熔冰 on 15/9/15.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"

@interface AddAddressViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

- (IBAction)pressSaveAddressBtn:(UIButton *)sender;
@property(nonatomic, strong) NSArray* tableData;
@end

//
//  ShoppingCartViewController.h
//  Jiu
//
//  Created by 张熔冰 on 15/9/13.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Addition.h"
#import "UIView+Frame.h"
#import "FillInOrderViewController.h"

@interface ShoppingCartViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
- (IBAction)pressSelectAllBtn:(UIButton *)sender;
@property(nonatomic,strong)NSString* flag;
@end

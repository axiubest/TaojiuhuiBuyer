//
//  RightMenuViewController.h
//  Jiu
//
//  Created by 张熔冰 on 15/10/21.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicListViewController.h"

@interface RightMenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) void(^didSelectedCancel)();

@property (nonatomic, copy) void(^didSelectedOK)();

@property(nonatomic, strong) NSArray* tableData;

@property(nonatomic, weak) IBOutlet UIButton* btn;

@end

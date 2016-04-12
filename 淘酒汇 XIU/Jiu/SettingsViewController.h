//
//  SettingsViewController.h
//  Jiu
//
//  Created by A-XIU on 15/9/14.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) NSArray* tableData;
@end

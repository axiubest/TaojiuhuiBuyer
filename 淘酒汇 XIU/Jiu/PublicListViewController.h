//
//  PublicListViewController.h
//  Jiu
//
//  Created by 张熔冰 on 15/10/22.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublicListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)NSArray* tableData;

@end

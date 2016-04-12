//
//  MyAccountViewController.h
//  Jiu
//
//  Created by 张熔冰 on 15/9/15.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray* tableData;
@property(nonatomic,strong)NSString* uid;
@end

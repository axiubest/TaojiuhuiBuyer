//
//  EditAllAddressDetailViewController.h
//  Jiu
//
//  Created by Molly on 15/11/20.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"

@interface EditAllAddressDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray* tableData;
@property(nonatomic,strong)NSString* aid;
@end

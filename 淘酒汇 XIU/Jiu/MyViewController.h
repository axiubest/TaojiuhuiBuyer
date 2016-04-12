//
//  MyViewController.h
//  Jiu
//
//  Created by 张熔冰 on 15/9/13.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *myImage;
@property (weak, nonatomic) IBOutlet UILabel *teleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *myImgView;
@property (weak, nonatomic) IBOutlet UILabel *loginInfoLbl;
@property(strong, nonatomic) NSArray* tableData;
@property (weak, nonatomic) IBOutlet UILabel *balanceBtn;
@property (weak, nonatomic) IBOutlet UILabel *creditBtn;
@end

//
//  AddressTableViewCell.h
//  Jiu
//
//  Created by 张熔冰 on 15/9/15.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *setDefaultAddressBtn;
@property (weak, nonatomic) IBOutlet UILabel *infoLbl;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;

@property(nonatomic) NSInteger index;
@property(nonatomic,strong)NSString* aid;
@end

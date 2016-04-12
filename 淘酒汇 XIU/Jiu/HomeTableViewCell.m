//
//  HomeTableViewCell.m
//  Jiu
//
//  Created by 张熔冰 on 15/10/19.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [_analogyBtn1.layer setBorderWidth:0.5];
    [_analogyBtn1.layer setBorderColor:[UIColor grayColor].CGColor];
    [_analogyBtn2.layer setCornerRadius:2.f];
    [_analogyBtn2.layer setBorderWidth:0.5];
    [_analogyBtn2.layer setBorderColor:[UIColor grayColor].CGColor];
    [_analogyBtn3.layer setCornerRadius:2.f];
    [_analogyBtn3.layer setBorderWidth:0.5];
    [_analogyBtn3.layer setBorderColor:[UIColor grayColor].CGColor];
    [_analogyBtn3.layer setCornerRadius:2.f];
    
}

-(IBAction)pressCommodityBtn1:(id)sender{
    [_delegate selectItemCallBack:0];
}

-(IBAction)pressCommodityBtn2:(id)sender{
    [_delegate selectItemCallBack:1];
}

-(IBAction)pressCommodityBtn3:(id)sender{
    [_delegate selectItemCallBack:2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end

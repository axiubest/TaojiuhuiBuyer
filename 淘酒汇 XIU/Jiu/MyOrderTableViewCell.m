//
//  MyOrderTableViewCell.m
//  Jiu
//
//  Created by zhangrongbing on 15/9/15.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import "MyOrderTableViewCell.h"

@implementation MyOrderTableViewCell

- (void)awakeFromNib {
    [_statusBtn.layer setBorderColor:[UIColor redColor].CGColor];
    [_statusBtn.layer setBorderWidth:1];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

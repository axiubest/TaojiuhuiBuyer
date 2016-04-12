//
//  CommodityStatusTableViewCell.m
//  Jiu
//
//  Created by zhangrongbing on 15/9/14.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import "CommodityStatusTableViewCell.h"

@implementation CommodityStatusTableViewCell


- (IBAction)ThreeBtn:(UIButton *)sender {
    
    NSString *sendertag = [NSString stringWithFormat:@"%ld", sender.tag];
    [self.mydelegate CommodityStatusTableViewCell:self urlStr:sendertag];
    NSLog(@"chick----------ThreeBtn");

}




@end

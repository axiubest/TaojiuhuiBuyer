//
//  CommodityStatusTableViewCell.h
//  Jiu
//
//  Created by zhangrongbing on 15/9/14.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommodityStatusTableViewCell;

@protocol CommodityStatusTableViewCellDelegate <NSObject>

-(void)CommodityStatusTableViewCell:(CommodityStatusTableViewCell *)cell urlStr:(NSString *)urlStr;


@end

@interface CommodityStatusTableViewCell : UITableViewCell

@property (nonatomic, weak) id<CommodityStatusTableViewCellDelegate> mydelegate;
@end

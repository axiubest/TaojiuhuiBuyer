//
//  TableViewCellDelegate.h
//  Jiu
//
//  Created by zhangrongbing on 15/9/22.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableViewCellDelegate <NSObject>

-(void) selectItemCallBack:(NSInteger)index;

@end

//
//  LocationViewController.h
//  Jiu
//
//  Created by zhangrongbing on 15/9/15.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController
typedef void (^ablock)(NSString* city);
@property(nonatomic,copy) ablock block;

@end

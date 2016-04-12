//
//  Product.h
//  Jiu
//
//  Created by Molly on 15/11/30.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;


@property(nonatomic,copy)NSString* detailId;
@property(nonatomic,copy)NSString* title;
@property (nonatomic, copy) NSString *orderId;
@property(nonatomic,copy)NSString* gid;
@property(nonatomic,copy)NSString* countStr;
@property (nonatomic, copy)NSString* price;
@property(nonatomic,copy)NSString* msg;
@property(nonatomic,copy)NSString* src;
@end


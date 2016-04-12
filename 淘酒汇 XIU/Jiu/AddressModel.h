//
//  AddressModel.h
//  Jiu
//
//  Created by Molly on 16/1/25.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
@property(nonatomic,strong)NSString* aid;
@property(nonatomic,strong)NSString* uid;
@property(nonatomic,strong)NSString* region;
@property(nonatomic,strong)NSString* city;
@property(nonatomic,strong)NSString* qu;
@property(nonatomic,strong)NSString* fullAddress;
@property(nonatomic,strong)NSString* name;
@property(nonatomic,strong)NSString* phone;
@property(nonatomic,strong)NSString* isUse;
@property(nonatomic,strong)NSString* isDefault;
@end

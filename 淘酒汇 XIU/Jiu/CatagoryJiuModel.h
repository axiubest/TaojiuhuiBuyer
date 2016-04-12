//
//  CatagoryJiuModel.h
//  Jiu
//
//  Created by Molly on 15/11/2.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface CatagoryJiuModel : BaseModel

@property(nonatomic,strong)NSString* category_id;
@property(nonatomic,strong)NSString* name;
@property(nonatomic,strong)NSString* parent_id;
@property(nonatomic,strong)NSString* logo;
@end

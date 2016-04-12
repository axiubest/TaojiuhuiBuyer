//
//  ParseJson.h
//  DN001
//
//  Created by 张熔冰 on 15/10/13.
//  Copyright © 2015年 DNKJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@protocol ParseJson <NSObject>
-(void)parseJson:(BaseModel*) baseModel;
@end

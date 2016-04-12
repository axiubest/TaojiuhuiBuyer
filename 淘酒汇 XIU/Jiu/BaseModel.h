//
//  BaseModel.h
//  Jiu
//
//  Created by 张熔冰 on 15/10/22.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property(nonatomic, strong) NSDictionary* data;

@property(nonatomic, copy) NSString* dataStr;

/**molly 15/11/17 */
@property(nonatomic,strong)NSArray* retArr;
 
@end

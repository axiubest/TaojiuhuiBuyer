//
//  GetCategoryOpetator.h
//  Jiu
//
//  Created by Molly on 15/11/2.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "BaseOperator.h"
#import "CatagoryJiuModel.h"

@interface GetCategoryOpetator : BaseOperator

@property(nonatomic,strong)NSMutableDictionary* parentDict;

@property (nonatomic ,strong) NSMutableArray *parentArray;

/**根据需要获取相应的 jiu model*/
@property(nonatomic,strong)NSMutableArray* categoryJius;
/**scrollView 的数据*/
@property(nonatomic,strong)NSArray* categoryArrs;
-(NSMutableArray*)getCategoryJiuValue:(NSString *)jiuKey;
@end

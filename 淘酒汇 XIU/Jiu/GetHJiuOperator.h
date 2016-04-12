//
//  GetHJiuOperator.h
//  Jiu
//
//  Created by Molly on 15/11/6.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "BaseOperator.h"

@interface GetHJiuOperator : BaseOperator
/**首页 酒分类 */
@property(nonatomic,strong)NSMutableArray* homeCategoryArr;
@property(nonatomic,strong)NSMutableDictionary* homeCategoryDics;
/**首页 分类下面的具体酒*/
@property(nonatomic,strong)NSMutableArray* categoryListArr;
/**首页 分类下面的相似酒品*/
@property(nonatomic,strong)NSMutableArray* itemsArr;

-(NSMutableArray*)getCategoryListArr:(NSString*)categoryStr;
-(NSMutableArray*)getItemsArr:(NSString*)categoryStr;
@end

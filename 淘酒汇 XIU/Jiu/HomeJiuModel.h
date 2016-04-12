//
//  HomeJiuModel.h
//  Jiu
//
//  Created by Molly on 15/11/6.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "BaseModel.h"

@interface HomeJiuModel : BaseModel

{
    //int gid;
//    int goods_id;
//    int agent_id;
    int leftCount;//leftcount
    int type;
    int orderBy;//orderby
    int status;
    int freeze;
    int view;
    
}
//@property(nonatomic,strong)NSString* name;
@property(nonatomic,strong)NSString* gid;
@property(nonatomic,strong)NSString* goodsId;
@property(nonatomic,strong)NSString* agentId;
@property(nonatomic,strong)NSString* typeId;
@property(nonatomic,strong)NSString* stypeId;
@property(nonatomic,strong)NSString* title;
@property(nonatomic,strong)NSString* price;
@property(nonatomic,strong)NSString* image1;
@property(nonatomic,strong)NSString* image2;
@property(nonatomic,strong)NSString* image3;
@property(nonatomic,strong)NSString* image4;
@property(nonatomic,strong)NSString* image5;
@property(nonatomic,strong)NSString* telephone;

@end

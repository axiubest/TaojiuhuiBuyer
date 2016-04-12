//
//  ShoppingTableViewCell.m
//  Jiu
//
//  Created by 张熔冰 on 15/9/13.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "ShoppingTableViewCell.h"
#import "NetworkingManager.h"
#import "GetCartCountOperator.h"
@interface ShoppingTableViewCell(){

    int count;
}
@end
@implementation ShoppingTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
//- (IBAction)pressSubtractionBtn:(id)sender {
//    int count = [_countLabel.text intValue];
//    count--;
//    if (count <= 1) {
//        count = 1;
//    }
//    _countLabel.text = [NSString stringWithFormat:@"%d", count];
//}
//- (IBAction)pressAdditionBtn:(id)sender {
//    int count = [_countLabel.text intValue];
//    count++;
//    if (count>=999) {
//        count = 999;
//    }
//    _countLabel.text = [NSString stringWithFormat:@"%d", count];
//}

- (IBAction)pressAddBtn:(UIButton *)sender {
    NSString* action = @"1";
    [self requestUpadteCount:action];
}

- (IBAction)pressSubBtn:(UIButton *)sender {
    NSString* action = @"0";
    [self requestUpadteCount:action];
}
#pragma mark - 请求增加或减少商品数量
/**请求 增加或减少商品数量--Action 1为增加 0为减少 count数量 cartid购物车id
 *http://www.taojiuhui.cn/home/Api/manageopenapi
 *?action=updatecart&act=1&json=1&cartid=1*/
-(void)requestUpadteCount:(NSString*)action {
    
    count = [_countLabel.text intValue];
    NSLog(@"-----%d",count);
    if (count == 0) {
        [_subtractionBtn setUserInteractionEnabled:NO];
    }else{
        [_subtractionBtn setUserInteractionEnabled:YES];
    }
    if (count!=0 || [action isEqual:@"1"]) {
        GetCartCountOperator* cartOperator = [[GetCartCountOperator alloc]initWithParamsDic:@{@"action":@"updatecart",@"act":action,@"json":@"1",@"cartid":@"1"}];
        NetworkingManager* manager = [NetworkingManager sharedInstance];
        [manager asyncTask:self.countLabel withOperator:cartOperator withSuccessCallBack:^(BaseModel *model) {
            if([cartOperator.code isEqual:@"true"]){
                
                if ([action isEqual:@"1"]) {
                    count++;
                }
                if ([action isEqual:@"0"]) {
                    count--;
                }
                // NSString* count = cartOperator.count;
                
                _countLabel.text = [NSString stringWithFormat:@"%d",count];
            }
            
            
        } andFaildCallBack:^(id response) {
            
        }];

    }
   
}

@end

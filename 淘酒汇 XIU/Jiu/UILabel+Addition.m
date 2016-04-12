//
//  UILabel+Addition.m
//  Jiu
//
//  Created by 张熔冰 on 15/10/19.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)

-(void)setFitText:(NSString*)text font:(UIFont*)font{
    self.text = text;
    self.font = font;
    
    CGSize size = CGSizeMake(kScreenWidth,0);
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    self.frame = rect;
    
}

@end

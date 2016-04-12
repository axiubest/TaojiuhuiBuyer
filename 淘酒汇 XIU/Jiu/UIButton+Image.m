//
//  UIButton+Image.m
//  Jiu
//
//  Created by zhangrongbing on 15/9/21.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import "UIButton+Image.h"

@implementation UIButton (Image)
@dynamic mTitle;

/** molly 15/11/27
 *uibutton下面的字是黑色的
 */
@dynamic whiteTitle;

-(void)setMTitle:(NSString*)mTitle{
    [self setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, 0)];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-10, self.frame.size.width, 10)];
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont systemFontOfSize:10.f]];
    [label setText:mTitle];
    [self addSubview:label];
}
/** molly 15/11/27
  *uibutton下面的字是白色的
  */
-(void)setWhiteTitle:(NSString*)whiteTitle{

    [self setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, 0)];
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-10, self.frame.size.width, 10)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [label setFont:[UIFont systemFontOfSize:10.f]];
    [label setText:whiteTitle];
    [self addSubview:label];
}
@end

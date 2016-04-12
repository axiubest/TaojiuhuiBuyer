//
//  TextButton.h
//  Jiu
//
//  Created by 张熔冰 on 15/10/19.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextButton : UIView

@property(nonatomic, strong) UIImageView* imageView;
@property(nonatomic, strong) UILabel* label;
@property(nonatomic) BOOL isSelected;

-(id)initWithFrame:(CGRect)frame title:(NSString*)title image:(UIImage*)image;

-(void)addTarget:(id)target action:(SEL) action forControlEvents:(UIControlEvents) events;

@end

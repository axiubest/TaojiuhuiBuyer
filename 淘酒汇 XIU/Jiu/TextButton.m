//
//  TextButton.m
//  Jiu
//
//  Created by 张熔冰 on 15/10/19.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "TextButton.h"
#import "UIView+Frame.h"

@implementation TextButton

-(id)initWithFrame:(CGRect)frame title:(NSString*)title image:(UIImage*)image{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 6, frame.size.width-8, frame.size.height/6*5-8)];
        [_imageView setImage:image];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(8, _imageView.height+_imageView.y+5, _imageView.width, frame.size.height/6-8)];
        [_label setText:title];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setFont:[UIFont systemFontOfSize:12.f]];
        
        [self addSubview:_imageView];
        [self addSubview:_label];
    }
    return self;
}

-(void)addTarget:(id)target action:(SEL) action forControlEvents:(UIControlEvents) events{
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    
    [self addGestureRecognizer:gesture];
}

-(void)setIsSelected:(BOOL)isSelected{
    if (isSelected) {
        [_label setTextColor:kMainColor];
    }else{
        [_label setTextColor:[UIColor blackColor]];
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

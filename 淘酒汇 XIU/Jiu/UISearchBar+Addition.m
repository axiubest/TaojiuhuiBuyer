//
//  UISearchBar+Addition.m
//  Jiu
//
//  Created by 张熔冰 on 15/10/20.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "UISearchBar+Addition.h"

@implementation UISearchBar (Addition)

-(void)setBackgroundColorImage:(UIColor*)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    [self setBackgroundImage:theImage];
}

@end

//
//  MainTabBarController.m
//  Jiu
//
//  Created by zhangrongbing on 15/9/11.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = kMainColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIImage*) createImageWithColor: (UIColor*) color withRect:(CGRect)rect

{
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger tag = item.tag;

    switch (tag) {
        case 0:
//            item.image = [self createImageWithColor:[UIColor greenColor] withRect:CGRectMake(0, 0, self.tabBar.frame.size.height, self.tabBar.frame.size.height)];
            break;
        case 1:
            break;
        case 2:
            
            break;
        case 3:
            
            break;
            
        default:
            break;
    }
}

//-(void)generate
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

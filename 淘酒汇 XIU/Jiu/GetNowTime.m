//
//  GetNowTime.m
//  Jiu
//
//  Created by Molly on 16/1/5.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import "GetNowTime.h"

@implementation GetNowTime
- (NSString*)getYear{
    NSDate* date = [NSDate date];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"YY"];
    
    return [dateFormat stringFromDate:date];
}
@end

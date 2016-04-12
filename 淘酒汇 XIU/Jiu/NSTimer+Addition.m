//
//  NSTimer+Addition.m
//  DN001
//
//  Created by 张熔冰 on 15/10/7.
//  Copyright © 2015年 DNKJ. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)

-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end

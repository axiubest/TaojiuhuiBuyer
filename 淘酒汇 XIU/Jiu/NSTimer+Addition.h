//
//  NSTimer+Addition.h
//  DN001
//
//  Created by 张熔冰 on 15/10/7.
//  Copyright © 2015年 DNKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end

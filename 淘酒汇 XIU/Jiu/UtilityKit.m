//
//  UtilityKit.m
//  JiDa
//
//  Created by zhangrongbing on 15/8/27.
//
//

#import "UtilityKit.h"

@implementation UtilityKit

+(BOOL) isNetWorkConnect{
    AFNetworkReachabilityManager* manager = [AFNetworkReachabilityManager sharedManager];
    
    AFNetworkReachabilityStatus status = manager.networkReachabilityStatus;
    
    if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable) {
        FDAlertView* alertView = [[FDAlertView alloc] initWithTitle:@"网络错误" icon:[UIImage imageNamed:@"icon_lostConnect"] message:@"没有网络" delegate:nil buttonTitles:@"确定", nil];
        [alertView show];
        return NO;
    }
    return YES;
}

+(NSString*)deviceIPAdress{
    return @"";
}
@end

//
//  UtilityKit.h
//  JiDa
//
//  Created by zhangrongbing on 15/8/27.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"
#import "FDAlertView.h"

@interface UtilityKit : NSObject

+(BOOL)isNetWorkConnect;
+(NSString*)deviceIPAdress;
@end

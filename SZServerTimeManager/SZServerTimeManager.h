//
//  SZServerTimeManager.h
//  SZServerTimeManager
//
//  Created by 陈圣治 on 2017/1/4.
//  Copyright © 2017年 陈圣治. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SZServerTimeManagerGetCurrentServerTime [[SZServerTimeManager manager] currentServerTime]
#define SZServerTimeManagerSetupServerTime(t)   [[SZServerTimeManager manager] setupServerTime:t]

@interface SZServerTimeManager : NSObject

+ (instancetype)manager;

- (void)setupServerTime:(NSTimeInterval)serverTime;

- (NSTimeInterval)currentServerTime;

@end

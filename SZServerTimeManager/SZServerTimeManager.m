//
//  SZServerTimeManager.m
//  SZServerTimeManager
//
//  Created by 陈圣治 on 2017/1/4.
//  Copyright © 2017年 陈圣治. All rights reserved.
//

#import "SZServerTimeManager.h"
#import <sys/sysctl.h>

static SZServerTimeManager *_sharedManager;

@interface SZServerTimeManager ()

@property (nonatomic) NSTimeInterval serverTimeLastSync;
@property (nonatomic) NSTimeInterval localTimeIntervalLastSync;

@end

@implementation SZServerTimeManager

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[SZServerTimeManager alloc] init];
    });
    return _sharedManager;
}

- (void)setupServerTime:(NSTimeInterval)serverTime {
    self.serverTimeLastSync = serverTime;

    self.localTimeIntervalLastSync = [self currentLocalTimeInterval];
}

- (NSTimeInterval)currentServerTime {
    if (self.serverTimeLastSync > 0 && self.localTimeIntervalLastSync > 0) {
        NSTimeInterval currentInterval = [self currentLocalTimeInterval];
        if (currentInterval > 0) {
            return self.serverTimeLastSync + (currentInterval - self.localTimeIntervalLastSync);
        }
    }
    return [[[NSDate alloc] init] timeIntervalSince1970];
}

- (NSTimeInterval)currentLocalTimeInterval {
    double interval = -1;

    struct timeval now;
    struct timezone tz;
    gettimeofday(&now, &tz);

    struct timeval boottime;
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    size_t size = sizeof(boottime);
    if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1 && boottime.tv_sec != 0) {
        interval = now.tv_sec - boottime.tv_sec;
        interval += (double)(now.tv_usec - boottime.tv_usec) / 1000000.0;
    }
    return interval;
}

@end

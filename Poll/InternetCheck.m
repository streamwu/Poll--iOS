//
//  InternetCheck.m
//  Poll
//
//  Created by Matt Sun on 3/22/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import "InternetCheck.h"

@implementation InternetCheck


/*******************************************************************************
 * @class           InternetCheck
 * @description     Check whether internet is available
 ******************************************************************************/
+(BOOL)hasConnectivity {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if(reachability != NULL) {
        //NetworkStatus retVal = NotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
            {
                NSLog(@"Target host is not reachable. No Internet Access");
                return NO;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
            {
                NSLog(@"Available Internet Access");
                return YES;
            }
            
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
            {
                
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                {
                    NSLog(@"Available Internet Access");
                    return YES;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
            {
                NSLog(@"Available Internet Access");
                return YES;
            }
        }
    }
    NSLog(@"No Internet Access");
    return NO;
}

@end

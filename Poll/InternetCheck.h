//
//  InternetCheck.h
//  Poll
//
//  Created by Matt Sun on 3/22/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface InternetCheck : NSObject

+(BOOL)hasConnectivity;

@end

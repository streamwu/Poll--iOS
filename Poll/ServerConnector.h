//
//  ServerConnector.h
//  usingBlock
//
//  Created by Matt Sun on 3/16/14.
//  Copyright (c) 2014 MattSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerConnector : NSObject

- (void)dbUpdate:(NSString*)sqlStat
                 Completion:(void (^)(BOOL isSuccessful))handleCompletion;

- (void)dbQuery:(NSString*)sqlStat
      Completion:(void (^)(NSArray* returnData))handleCompletion;
@end
